import 'dart:async';
import 'dart:typed_data';
import 'package:bite/models/bluetooth_status/bluetooth_status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'package:bite/constants/constants.dart' as constants;
import 'package:bite/utils/logger.dart';

class BluetoothManager {
  // We implement the Singleton pattern to ensure that only one instance of
  // BluetoothManager is created and used throughout the entire application.
  static final BluetoothManager _instance = BluetoothManager._internal();

  // The factory constructor returns the already existing instance, ensuring
  // that there are not multiple BluetoothManager objects floating around.
  factory BluetoothManager() {
    return _instance;
  }

  // The private constructor is called only once to create the Singleton instance.
  BluetoothManager._internal();

  // FlutterReactiveBle provides a BLE interface.
  // We use it to scan for BLE devices
  final FlutterReactiveBle _ble = FlutterReactiveBle();

  // We keep track of subscriptions for scanning and for BLE status monitoring
  // so that we can cancel them when disposing or stopping the scan.
  StreamSubscription<DiscoveredDevice>? _scanSubscription;
  StreamSubscription<BleStatus>? _bleStatusSubscription;

  // Flags to keep track of the state of the BluetoothManager:
  // - isReadyToScan: true if BLE is on and ready;
  // - _isScanning: true if we are currently scanning for devices.
  // - _pendingScan: used to defer the start of a scan until BLE is ready.
  bool isReadyToScan = false;
  bool _isScanning = false;
  bool _pendingScan = false;

  // A callback function that we invoke whenever a discovered device matches our criteria.
  // This is passed from outside so that the manager is decoupled from specific UI or logic.
  Function? _onResultCallback;

  // Timers to help manage the scanning process:
  // - _scanTimer: controls how long a scanning session lasts.
  // - _pauseTimer: controls the waiting time before starting a new scan session.
  Timer? _scanTimer;
  Timer? _pauseTimer;

  // During a single scan session, we may encounter the same device multiple times.
  // We use a Set to keep track of device IDs we've already seen, avoiding
  // reporting duplicates to the callback.
  Set<String> seenDeviceIds = {};

  ValueNotifier<BluetoothStatus> bluetoothStatus =
      ValueNotifier(BluetoothStatus.inactive);

  // init() sets up the BLE status listener. This allows us to respond to changes
  // in the BLE adapter state, such as the user turning Bluetooth on/off.
  Future<void> init() async {
    _bleStatusSubscription = _ble.statusStream.listen((status) {
      BiteLogger().info('Bluetooth Status: $status');
      if (status == BleStatus.ready) {
        // If the BLE stack is ready, we can perform scans.
        // If there was a pending scan request (user wanted to scan earlier but BLE wasn't ready),
        // we start it now.
        isReadyToScan = true;
        if (_pendingScan && _onResultCallback != null) {
          _pendingScan = false;
          startScan(_onResultCallback!);
        }
      } else {
        // If BLE is not ready (e.g., turned off or not supported),
        // we mark it as not ready and ensure no scanning is ongoing.
        isReadyToScan = false;

        stopScan();
      }
    });
  }

  // The dispose method ensures that all subscriptions are cancelled and timers cleared
  // when we no longer need the BluetoothManager, such as when the app is terminated.
  void dispose() {
    _scanSubscription?.cancel();
    _bleStatusSubscription?.cancel();
    _scanTimer?.cancel();
    _pauseTimer?.cancel();
    _isScanning = false;

    BiteLogger().info('Dispose Scan Session');
  }

  // startScan is the method to begin scanning for BLE devices.
  /// It takes a callback that will be used to report discovered devices that match criteria.
  // Parameters:
  /// - beaconName: optional, if provided, we filter devices by their name.
  /// - withServiceUuids: a list of service UUIDs to scan for, defaulting to Eddystone FEAA.
  Future<void> startScan(Function onResult,
      {String? beaconName,
      List<String> withServiceUuids = const [
        'feaa',
        '0000feaa-0000-1000-8000-00805f9b34fb'
      ]}) async {
    _onResultCallback = onResult;

    // If BLE isn't ready, we can't start scanning now.
    // We remember that a scan was requested, so when BLE becomes ready, we start scanning.
    if (!isReadyToScan) {
      BiteLogger().info(
          'Bluetooth is off or not ready. The scan will begin once Bluetooth is turned on.');

      _pendingScan = true;
      return;
    }

    // If we are already scanning, there's no need to start another scan.
    if (_isScanning) {
      BiteLogger().info('A scan is already in progress, ignoring new request.');
      return;
    }

    try {
      BiteLogger().info('Starting a new scanning session...');

      _isScanning = true;

      bluetoothStatus.value = BluetoothStatus.active;

      // Clear the set of seen device IDs so this session can report devices again.
      seenDeviceIds.clear();

      // Cancel any previous scan subscription before starting a new one.
      _scanSubscription?.cancel();

      // scanForDevices returns a stream of DiscoveredDevices, which we listen to.
      // We specify scanMode and filter by FEAA to narrow down which devices we want to detect.
      _scanSubscription = _ble
          .scanForDevices(
        withServices: withServiceUuids.map((uuid) => Uuid.parse(uuid)).toList(),
      )
          .listen(
        (device) {
          // Each time we discover a device, we check if we've seen it before.
          // If seen, we ignore it. Otherwise, we add it to the set and if the device name matches
          // (or no name filter was given), we pass it to the onResult callback.
          if (seenDeviceIds.contains(device.id)) {
            // Device already processed this session, skip it.
            return;
          }

          seenDeviceIds.add(device.id);

          // If beaconName is given, only report devices whose names contain that substring.
          if (beaconName == null || device.name.contains(beaconName)) {
            onResult(device);
          }

          BiteLogger().info('Devices: $seenDeviceIds');
        },
        onError: (e) {
          // If an error occurs during scanning, log it.
          BiteLogger().error('Scan encountered an error: $e');
        },
      );

      // We only want to scan for a certain duration (e.g., constants.Bluetooth.timeoutSeconds).
      // After that time, we automatically stop the scan.
      _scanTimer?.cancel();

      _scanTimer = Timer(
          const Duration(seconds: constants.Bluetooth.timeoutSeconds), () {
        stopScan(onResult: onResult(null));
      });
    } catch (e) {
      // If we fail to initiate a scan for some reason, log the error.
      BiteLogger().error('Failed to start scan: $e');
    }
  }

  // stopScan ends the current scanning session.
  // After scanning is stopped, we typically wait a certain interval before starting again.
  Future<void> stopScan({bool shouldRestart = true, Function? onResult}) async {
    try {
      _isScanning = false;
      bluetoothStatus.value = BluetoothStatus.inactive;

      // Cancel the scan subscription to stop receiving device events.
      await _scanSubscription?.cancel();

      // Cancel any ongoing scan timer since the scan is ending now.
      _scanTimer?.cancel();

      BiteLogger().info('Scan session ended.');

      // After stopping, we don't immediately resume scanning. Instead, we wait for a set interval
      // before starting another scan session. This prevents continuous scanning, which could waste
      // power and resources.
      // If shouldRestart is true, we skip this waiting period and don't start scanning again.
      if (!shouldRestart) {
        return;
      }

      _pauseTimer?.cancel();
      bluetoothStatus.value = BluetoothStatus.timeout;
      _pauseTimer = Timer(
          const Duration(seconds: constants.Bluetooth.intervalBetweenScans),
          () {
        // After waiting the intervalBetweenScans, if BLE is still ready and we have a callback,
        // we can start scanning again.
        if (isReadyToScan && _onResultCallback != null) {
          startScan(_onResultCallback!);
        }
      });
    } catch (e) {
      // Log any errors that occur while trying to stop scanning.
      BiteLogger().error('Failed to stop scan: $e');
    }
  }

  // parseBeaconData takes the raw manufacturer or service data (as a Uint8List) from a beacon
  // and extracts meaningful information such as temperature and humidity.
  // This logic is highly dependent on Teltonika beacon's data format.
  Map<String, String?> parseBeaconData(Uint8List data) {
    // Convert the byte data into a human-readable hexadecimal string.
    String hexString =
        data.map((byte) => byte.toRadixString(16).padLeft(2, '0')).join();

    // For this particular beacon, we know that flags and sensor data start at a specific offset.
    // The offset and parsing logic come from the beacon’s documentation and prior knowledge.
    int offset = 6; // According to our understanding, flags start at index 6

    // Extract the flags that indicate which sensors are included in the payload.
    String flagsHex = hexString.substring(offset, offset + 2);
    int flags = int.parse(flagsHex, radix: 16);

    // Determine if temperature and humidity data are present based on the flags.
    bool hasTemperature =
        (flags & 1) != 0; // If bit 0 is set, temperature is present
    bool hasHumidity = (flags & 3) != 0; // If bit 1 is set, humidity is present

    String? temperature;
    String? humidity;

    // If the beacon includes temperature, we extract the relevant bytes and convert them.
    // The method of conversion (dividing by 100.0) depends on how the beacon encodes the data.
    if (hasTemperature) {
      String tempHex = hexString.substring(offset + 2, offset + 6);
      int tempValue = int.parse(tempHex, radix: 16);
      temperature = "${(tempValue / 100.0).toStringAsFixed(2)}°C";
    }

    // Similarly, if humidity is present, we extract those bytes and interpret them as a percentage.
    if (hasHumidity) {
      String humidityHex = hexString.substring(offset + 6, offset + 8);
      int humidityValue = int.parse(humidityHex, radix: 16);
      humidity = "$humidityValue%";
    }

    // Return the parsed values. If a sensor isn't present, its value might be null.
    return {
      'temperature': temperature,
      'humidity': humidity,
    };
  }
}
