import 'dart:async';
import 'dart:convert';
import 'package:bite/managers/bluetooth/bluetooth_manager.dart';
import 'package:bite/constants/constants.dart' as constants;
import 'package:bite/helpers/firebase_keys.dart';
import 'package:bite/models/device_traffic_model/device_traffic.dart';
import 'package:bite/models/local_notifications/local_notifications.dart';
import 'package:bite/models/responses/poi/detail/poi_detail.dart';
import 'package:bite/models/responses/pois_by_beacon_coordinates/pois_by_beacon_coordinates.dart';
import 'package:bite/repository/manager/repo_manager/repository_manager.dart';
import 'package:bite/services/firebase/firebase_service.dart';
import 'package:bite/services/notifications/local_notifications_service.dart';
import 'package:bite/services/queue/azure_queue_service.dart';
import 'package:bite/ui/scene/tabs/home/bloc/home_state.dart';
import 'package:bite/utils/logger.dart';
import 'package:bite/utils/shared_preferences.dart';
import 'package:bite/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial()) {
    _checkBluetooth();
    _getFullTextTotalCount();
    _drawInitialMap();
  }

  // API Response
  PoisByBeaconCoordinates? poisByBeaconCoordinates;
  PoisByBeaconCoordinates? searchResults;

  // Keep track of discovered devices to find the strongest RSSI device
  final List<DiscoveredDevice> _discoveredDevices = [];

  // Map Style
  BitmapDescriptor? markerIcon;
  List<LatLng>? points;

  // Google Maps Controller
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  // Maps Info
  double initialZoom = 17;

  // Current Position
  LatLng? currentPosition;

  PoiDetail? closestPoi;

  PermissionStatus? bluetoothPermissionStatus;

  // Custom Marker
  Future<void> _loadCustomMarkerIcons() async {
    markerIcon = await BitmapDescriptor.asset(
      const ImageConfiguration(),
      'assets/images/markers/icon_pin/icon_pin_big.png',
    );
  }

  // Notification Service
  final LocalNotificationService _notificationService =
      LocalNotificationService();

  // Remote Config
  final remoteConfig = FirebaseRemoteConfigService();

  // Total items for search results
  int? totalItems = 10;
  int currentPage = 1;
  String searchedText = '';

  // List of Scan Results
  List<ScanResult> scanResults = [];

  // Method to get initial values for draw map
  Future<void> _drawInitialMap() async {
    checkPermissions();

    await _loadCustomMarkerIcons();
  }

  // Put message in Azure Queue
  Future<void> putQMessage(
    String beaconExternalId,
    DeviceTrafficDirection deviceDirection,
  ) async {
    var connectionString = dotenv.env['AZURE_STORAGE_CONNECTION_STRING'] ?? '';
    var storage = AzureStorage.parse(connectionString);

    StorageUtils storageUtils = await StorageUtils.getInstance();

    String? deviceId = await storageUtils.getString(StorageUtils.deviceId);

    // Poi Affluence data
    var queueName =
        remoteConfig.getString(FirebaseRemoteConfigKeys.affluenceQueueName);

    try {
      await storage.putMessage(
        queueName: queueName,
        message: jsonEncode({
          'deviceId': deviceId,
          'beaconExternalId': beaconExternalId,
          'value': deviceDirection == DeviceTrafficDirection.entry
              ? 'ENTRY'
              : 'EXIT',
          'type': 'TRAFFIC',
        }),
      );
    } catch (e) {
      debugPrint('get data error: $e');
      BiteLogger().error('ERROR');
    }
  }

  // start Bluetooth Scan
  Future<void> _checkBluetooth() async {
    bluetoothPermissionStatus = await Permission.bluetooth.status;

    if (bluetoothPermissionStatus?.isGranted == true) {
      BluetoothManager().init();
    }
  }

  Future<void> _startBluetoothScan() async {
    if (bluetoothPermissionStatus?.isGranted == false) {
      BiteLogger().info('Bluetooth permission not granted');
      return;
    }
    BluetoothManager().startScan(_processScanResults);
  }

  // Check user permission for location
  Future<void> checkPermissions() async {
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied ||
        permission == LocationPermission.unableToDetermine) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.deniedForever) {
      emit(HomePermissionDenied());
      return;
    }

    if (permission == LocationPermission.denied) {
      emit(HomePermissionDenied());
      return;
    }

    if (permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse) {
      await _getCurrentLocation();
    }
  }

  // Start checking user position
  void _startPoiPositionCheck() async {
    BiteLogger().info('Start poi position check');
    _checkPoisInProximity();

    Timer.periodic(
      const Duration(seconds: 30),
      (timer) async {
        await _checkPoisInProximity();
      },
    );
  }

  // Get user location
  Future<void> _getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition();

      currentPosition = LatLng(position.latitude, position.longitude);

      getPoisByBeaconCoordinates(
        currentPosition?.latitude ?? 90,
        currentPosition?.longitude ?? 90,
        1,
      );

      await updateMapPosition(currentPosition ?? const LatLng(90, 90));
    } catch (e) {
      emit(
        HomeGetPositionError(
          message: e.toString(),
        ),
      );
    }
  }

  // Get user location
  Future<void> _checkPoisInProximity() async {
    try {
      Position position = await Geolocator.getCurrentPosition();

      currentPosition ??= LatLng(position.latitude, position.longitude);

      await _compareLastPositionAndCurrentPosition(
        LatLng(position.latitude, position.longitude),
      );

      if (poisByBeaconCoordinates != null) {
        for (var poi in poisByBeaconCoordinates!.items) {
          double distance = Geolocator.distanceBetween(
            currentPosition!.latitude,
            currentPosition!.longitude,
            poi.location?.latitude ?? 0,
            poi.location?.longitude ?? 0,
          );

          if (distance < 50) {
            BiteLogger().info('REACHABLE POI: ${poi.name}');
            closestPoi = poi;

            _startBluetoothScan();
          }
        }
      }
    } catch (e) {
      emit(
        HomeGetPositionError(
          message: e.toString(),
        ),
      );
    }
  }

  // Compare last position with current position
  Future<void> _compareLastPositionAndCurrentPosition(
      LatLng newPosition) async {
    BiteLogger().info('COMPARE POSITIONS');

    double distance = Geolocator.distanceBetween(
      currentPosition!.latitude,
      currentPosition!.longitude,
      newPosition.latitude,
      newPosition.longitude,
    );

    // if distance is more then 500 meters, then get pois
    if (distance > 500) {
      updateMapPosition(currentPosition ?? const LatLng(90, 90));
      BiteLogger().info('GET POIS, DISTANCE: $distance');
      await getPoisByBeaconCoordinates(
        currentPosition?.latitude ?? 90,
        currentPosition?.longitude ?? 90,
        1,
      );
    }
  }

  // Update Map with animation
  Future<void> updateMapPosition(
    LatLng newPosition,
  ) async {
    if (!_controller.isCompleted) {
      return;
    }

    final GoogleMapController controller = await _controller.future;

    if (_controller.isCompleted) {
      CameraUpdate cameraUpdate = CameraUpdate.newCameraPosition(
        CameraPosition(
          target: newPosition,
          zoom: initialZoom,
        ),
      );
      await controller.animateCamera(cameraUpdate);
    }
  }

  // Map Controller
  Future<void> setMapController(GoogleMapController controller) async {
    if (!_controller.isCompleted) {
      _controller.complete(controller);
    }
  }

  // Get values for populate notification payload
  String? getPayLoad(DiscoveredDevice device) {
    String beaconNameKey = 'beaconName';
    String beaconNameValue = device.name;

    String feaaKey = 'feaaKey';
    String feaaValue = getFeaaCode(device);
    Map<String, String> jsonMap = {
      feaaKey: feaaValue,
      beaconNameKey: beaconNameValue,
    };

    String jsonString = jsonEncode(jsonMap);

    BiteLogger().info('jsonString OF PAYLOAD: $jsonString');

    return jsonString;
  }

  void _compareAndHandleDevices() {
    // Find missing devices
    List<DiscoveredDevice> missingDevices = _discoveredDevices
        .where(
          (device) =>
              !BluetoothManager().seenDeviceIds.any((id) => id == device.id),
        )
        .toList();

    // Manage missing devices
    for (var missingDevice in missingDevices) {
      putQMessage(getFeaaCode(missingDevice), DeviceTrafficDirection.exit);
      _discoveredDevices.remove(missingDevice);
      BiteLogger().info('Missing device: ${missingDevice.name}');
    }
  }

  void _processScanResults(DiscoveredDevice? device) {
    if (device == null) {
      // Compare devices and handle queue messages
      _compareAndHandleDevices();
      return;
    }

    BiteLogger().info('FOUND: $device');

    // Add the newly discovered device to the list
    if (!_discoveredDevices.any((d) => d.id == device.id)) {
      putQMessage(getFeaaCode(device), DeviceTrafficDirection.entry);
      _discoveredDevices.add(device);
    }

    int rssiCalibrated = constants.Bluetooth.rssiCalibrated;
    const double n = constants.Bluetooth.propagationFactor;
    double distance = calculateDistance(device.rssi, rssiCalibrated, n);

    _showNotification(
      LocalNotification(
        id: device.rssi,
        title: 'Sei vicino a ${closestPoi?.name}',
        body: 'Si trova a ${distance.toStringAsFixed(2)} metri',
        payload: getPayLoad(device),
        isAlarm: null,
      ),
      () {},
    );

    BiteLogger().info('IL PIÙ VICINO! ${device.id}: '
        '"${device.name}" (RSSI: ${device.rssi})');
  }

// Show Local Notification when he comes they find a beacon
  Future<void> _showNotification(
      LocalNotification notification, Function onPoppedTrue) async {
    _notificationService.showNotification(
      notification,
      onPoppedTrue: onPoppedTrue,
    );
  }

  void _getFullTextTotalCount() {
    totalItems =
        remoteConfig.getInt(FirebaseRemoteConfigKeys.fullTextSearchTotalCount);
  }

  void updateCurrentPage(int index, String query) {
    currentPage = index;
    searchedText = query;
  }

// API calls

  // Return list of POIS for draw markers
  Future<void> getPoisByBeaconCoordinates(
    double latitude,
    double longitude,
    int page,
  ) async {
    await RepoManager().manager.getPoisByCoordinates(
      latitude,
      longitude,
      null,
      page,
      null,
      (PoisByBeaconCoordinates result) {
        poisByBeaconCoordinates = result;

        _startPoiPositionCheck();
        emit(HomeSuccess());
      },
      (typeDataError, status, message) {
        emit(
          HomeError(
            message: "error: $message",
          ),
        );
      },
    );
  }

  // Return result of search
  Future<void> fullTextSearch(
    double latitude,
    double longitude,
    String searchTerm,
    int page,
  ) async {
    await RepoManager().manager.getPoisByCoordinates(
      latitude,
      longitude,
      searchTerm,
      page,
      totalItems,
      (PoisByBeaconCoordinates result) {
        searchResults = result;
        emit(HomeSuccess());
      },
      (typeDataError, status, message) {
        emit(
          HomeError(
            message: "error: $message",
          ),
        );
      },
    );
  }
}
