import 'dart:convert';
import 'package:bite/helpers/firebase_keys.dart';
import 'package:bite/managers/bluetooth/bluetooth_manager.dart';
import 'package:bite/models/responses/location/location.dart';
import 'package:bite/models/responses/poi/detail/poi_detail.dart';
import 'package:bite/models/responses/poi/poi_affluence/poi_affluence.dart';
import 'package:bite/models/sensor_reading_model/sensor_reading.dart';
import 'package:bite/repository/manager/repo_manager/repository_manager.dart';
import 'package:bite/services/queue/azure_queue_service.dart';
import 'package:bite/services/firebase/firebase_service.dart';
import 'package:bite/ui/scene/poi_detail_from_beacon/bloc/poi_detail_from_beacon_state.dart';
import 'package:bite/utils/logger.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';

class PoiDetailFromBeaconCubit extends Cubit<PoiDetailFromBeaconState> {
  PoiDetailFromBeaconCubit(
    String beaconId,
  ) : super(PoiDetailFromBeaconInitial(beaconId: beaconId)) {
    init();
  }

  // Remote Config
  final remoteConfig = FirebaseRemoteConfigService();

  // API responses
  PoiDetail? poiDetail;
  int? poiAffluence;

  // Beacon environmental data
  String? humidity;
  String? temperature;

  // Beacon identifiers
  String? feaaKey;
  String? beaconName;

  Future<void> init() async {
    Map<String, dynamic> beaconData = jsonDecode(state.beaconId);

    feaaKey = beaconData['feaaKey'];
    beaconName = beaconData['beaconName'];

    await getPoiByBeaconId(feaaKey ?? '');
    startBlueScan();
  }

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

    if (poiDetail?.id.isNotEmpty == true && humidity != null) {
      _sendMeasurement(MeasurementType.humidity, humidity, '%');
    }

    if (poiDetail?.id.isNotEmpty == true && temperature != null) {
      _sendMeasurement(MeasurementType.temperature, temperature, '°C');
    }

    emit(
      PoiDetailFromBeaconSuccess(
        poiDetail: poiDetail,
        beaconId: state.beaconId,
        humidity: humidity,
        temperature: temperature,
        poiAffluence: poiAffluence,
      ),
    );
  }

  void disposeScan() async {
    await BluetoothManager().stopScan();
    emit(PoiDetailFromBeaconScanDisposed(
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
  Future<void> getPoiByBeaconId(String beaconId) async {
    emit(PoiDetailFromBeaconLoading(beaconId: beaconId));
    await RepoManager().manager.getPoibyBeaconExternalId(
      beaconId,
      (PoiDetail data) {
        poiDetail = data;
        emit(PoiDetailFromBeaconSuccess(
          beaconId: state.beaconId,
          poiDetail: data,
        ));

        Future.delayed(const Duration(seconds: 3), () {
          if (poiDetail?.id.isNotEmpty == true) {
            getPoiAffluence(poiDetail!.id);
          }
        });
      },
      (String status, String message) {
        emit(PoiDetailFromBeaconError(
            beaconId: state.beaconId, message: 'error: $status $message'));
        BluetoothManager().stopScan(shouldRestart: false);
      },
    );
  }

  // Get POI affluence
  Future<void> getPoiAffluence(String poiId) async {
    await RepoManager().manager.getPoiAffluence(
      poiId,
      (PoiAffluence data) {
        poiAffluence = data.value;

        emit(
          PoiDetailFromBeaconSuccess(
            beaconId: state.beaconId,
            poiDetail: poiDetail ??
                const PoiDetail(
                  id: 'id',
                  name: 'name',
                  beaconId: 'beaconId',
                  location: Location(longitude: 90, latitude: 90),
                ),
            poiAffluence: data.value,
            humidity: humidity,
            temperature: temperature,
          ),
        );
      },
      (String status, String message) {
        poiAffluence = 0;
      },
    );
  }
}
