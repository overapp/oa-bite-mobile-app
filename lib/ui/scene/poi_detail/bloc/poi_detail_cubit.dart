import 'dart:convert';

import 'package:bite/helpers/firebase_keys.dart';
import 'package:bite/managers/bluetooth/bluetooth_manager.dart';
import 'package:bite/models/responses/location/location.dart';
import 'package:bite/models/responses/poi/detail/poi_detail.dart';
import 'package:bite/models/responses/poi/poi_affluence/poi_affluence.dart';
import 'package:bite/models/responses/route/detail/route_detail.dart';
import 'package:bite/models/responses/sensors/sensor_reading/sensors_reading.dart';
import 'package:bite/models/screen/poi_detail/screen_type.dart';
import 'package:bite/models/sensor_reading_model/sensor_reading.dart';
import 'package:bite/repository/manager/repo_manager/repository_manager.dart';
import 'package:bite/services/firebase/firebase_service.dart';
import 'package:bite/services/queue/azure_queue_service.dart';
import 'package:bite/ui/scene/poi_detail/bloc/poi_detail_state.dart';
import 'package:bite/utils/logger.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';

class PoiDetailCubit extends Cubit<PoiDetailState> {
  PoiDetailCubit(
    String? poiId,
    String? beaconId,
    PoiDetailScreenType screenType,
  ) : super(PoiDetailInitial(
          poiId: poiId,
          beaconId: beaconId,
          screenType: screenType,
        )) {
    init();
  }

// API responses
  PoiDetail? poiDetail;
  int? poiAffluence;

// Remote Config
  final remoteConfig = FirebaseRemoteConfigService();

// Beacon environmental data
  String? humidity;
  String? temperature;

// Beacon identifiers
  String? feaaKey;
  String? beaconName;

  Future<void> init() async {
    if (state.screenType == PoiDetailScreenType.fromMap &&
        state.poiId != null) {
      await getPoiById(state.poiId!);
      getSensorsValues(state.poiId!, MeasurementType.humidity);
      getSensorsValues(state.poiId!, MeasurementType.temperature);
    } else if (state.screenType == PoiDetailScreenType.fromNotification &&
        state.beaconId != null) {
      Map<String, dynamic> beaconData = jsonDecode(state.beaconId!);

      feaaKey = beaconData['feaaKey'];
      beaconName = beaconData['beaconName'];

      await getPoiByBeaconId(feaaKey ?? '');
      startBlueScan();
    }
  }

// Bluetooth Scan

  // Start Bluetooth Scan
  Future<void> startBlueScan() async {
    BluetoothManager().startScan(_processScanResults, beaconName: beaconName);
  }

  // Callback invoked when a beacon is found through the scan.
  // Parse beacon data for write on Azure Storage Queue and show values to the user.
  void _processScanResults(DiscoveredDevice? result) {
    if (result == null) {
      return;
    }
    var beacon = BluetoothManager().parseBeaconData(result.manufacturerData);

    BiteLogger().info(
      'Foun beacon: $beacon',
    );

    humidity = beacon['humidity'];
    temperature = beacon['temperature'];

    if (poiDetail?.id?.isNotEmpty == true && humidity != null) {
      _sendMeasurement(MeasurementType.humidity, humidity, '%');
    }

    if (poiDetail?.id?.isNotEmpty == true && temperature != null) {
      _sendMeasurement(MeasurementType.temperature, temperature, '°C');
    }

    emit(
      PoiDetailSuccess(
        poiDetail: poiDetail!,
        beaconId: state.beaconId,
        humidity: humidity,
        temperature: temperature,
        poiAffluence: poiAffluence,
      ),
    );
  }

  void disposeScan() async {
    await BluetoothManager().stopScan();
    emit(PoiDetailScanDisposed(
      beaconId: state.beaconId,
    ));
  }

  // Get the beacon values, format them, and send them to the Azure storage queue
  void _sendMeasurement(
      MeasurementType type, String? value, String unitToRemove) {
    var numericValue = value?.replaceAll(unitToRemove, '');

    var parsedValue = double.tryParse(numericValue ?? '0') ?? 0;

    var formattedValue = double.parse(parsedValue.toStringAsFixed(3));

    putQMessage(
      jsonEncode({
        'poiId': poiDetail?.id,
        'type': type == MeasurementType.humidity ? 'HUMIDITY' : 'TEMPERATURE',
        'value': formattedValue,
      }),
    );
  }

// Azure Queue Storage

  Future<void> putQMessage(String message) async {
    var connectionString = dotenv.env['AZURE_STORAGE_CONNECTION_STRING'] ?? '';
    var storage = AzureStorage.parse(connectionString);

    // Sensor reading
    var queueName =
        remoteConfig.getString(FirebaseRemoteConfigKeys.sendSensorsQueueName);

    try {
      await storage.putMessage(queueName: queueName, message: message);
    } catch (e) {
      BiteLogger().error('ERROR: $e');
    }
  }

// API calls

  // Get POI by id
  Future<void> getPoiById(String poiId) async {
    emit(PoiDetailLoading(poiId: state.poiId));
    await RepoManager().manager.getPoiById(
      poiId,
      (PoiDetail data) {
        poiDetail = data;
        BiteLogger().info('POI detail: $poiId: $data');

        emit(PoiDetailSuccess(
          poiId: state.poiId,
          poiDetail: data,
        ));

        Future.delayed(const Duration(seconds: 3), () {
          getPoiAffluence(poiId);
        });
      },
      (String status, String message) {
        emit(PoiDetailError(
          poiId: state.poiId,
          message: 'error: $status $message',
        ));
      },
    );
  }

  // Get POI by id
  Future<void> getPoiByBeaconId(String beaconId) async {
    emit(PoiDetailLoading());
    await RepoManager().manager.getPoibyBeaconExternalId(
      beaconId,
      (PoiDetail data) {
        poiDetail = data;
        emit(PoiDetailSuccess(
          poiDetail: data,
        ));

        Future.delayed(const Duration(seconds: 3), () {
          if (poiDetail?.id?.isNotEmpty == true) {
            getPoiAffluence(poiDetail!.id!);
          }
        });
      },
      (String status, String message) {
        emit(PoiDetailError(message: 'error: $status $message'));
        BluetoothManager().stopScan(shouldRestart: false);
      },
    );
  }

  // Get POI affluence
  Future<void> getPoiAffluence(String poiId) async {
    await RepoManager().manager.getPoiAffluence(
      poiId,
      (PoiAffluence data) {
        BiteLogger().info('Traffic: $poiId: $data');

        poiAffluence = data.value;

        emit(
          PoiDetailSuccess(
            poiId: state.poiId,
            poiDetail: poiDetail ??
                const PoiDetail(
                  id: 'id',
                  name: 'name',
                  beaconId: 'beaconId',
                  location: Location(longitude: 90, latitude: 90),
                ),
            poiAffluence: data.value,
          ),
        );
      },
      (String status, String message) {
        poiAffluence = 0;
      },
    );
  }

// Get Route by POI id
  Future<void> getRoutebyId(
    String poiId,
  ) async {
    emit(PoiDetailLoading(poiId: state.poiId));
    await RepoManager().manager.getRoutebyPoiId(
      poiId,
      (RouteDetail data) {
        BiteLogger().info('Route by POI  $data');

        emit(PoiDetailGetRouteById(
          poiId: state.poiId,
          routeDetail: data,
        ));
      },
      (String status, String message) {
        emit(PoiDetailError(
          poiId: state.poiId,
          message: 'error: $status $message',
        ));
      },
    );
  }

  // Get Sensors Values when Scan Bluetooth isn't available

  Future<void> getSensorsValues(String poiId, MeasurementType type) async {
    emit(PoiDetailLoading(poiId: state.poiId));
    await RepoManager().manager.getSensorReading(
      poiId,
      type,
      (SensorsReading data) {
        switch (type) {
          case MeasurementType.humidity:
            humidity = '${data.value}%';

          case MeasurementType.temperature:
            temperature = '${data.value}°C';
        }

        BiteLogger().info('Sensors values $type: $data');
        emit(
          PoiDetailSuccess(
            poiDetail: poiDetail!,
            beaconId: state.beaconId,
            humidity: humidity,
            temperature: temperature,
            poiAffluence: poiAffluence,
          ),
        );
      },
      (String status, String message) {
        emit(PoiDetailError(
          poiId: state.poiId,
          message: 'error: $status $message',
        ));
      },
    );
  }
}
