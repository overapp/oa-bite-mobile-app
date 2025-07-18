import 'dart:io';
import 'package:bite/utils/logger.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:bite/ui/scene/bluetooth_permission/bloc/bluetooth_permission_state.dart';

class BluetoothPermissionCubit extends Cubit<BluetoothPermissionState> {
  BluetoothPermissionCubit() : super(BluetoothPermissionInitial());

  Future<void> askBluetoothPermission() async {
    try {
      if (Platform.isAndroid) {
        // Check the current permission status
        final status = await Future.wait([
          Permission.bluetoothScan.status,
          Permission.bluetoothAdvertise.status,
          Permission.bluetoothConnect.status,
          Permission.bluetoothAdvertise.status,
        ]);

         BiteLogger().info("Statuses: $status");

        if (status.every((element) => element.isGranted)) {
          // If permission is already granted
          emit(BluetoothPermissionSuccess());
        } else {
          // Request Bluetooth permission
          final result = await [
            Permission.bluetoothScan,
            Permission.bluetoothAdvertise,
            Permission.bluetoothConnect,
            Permission.bluetoothAdvertise,
          ].request();

          if (result[Permission.bluetoothScan]!.isGranted &&
              result[Permission.bluetoothAdvertise]!.isGranted &&
              result[Permission.bluetoothConnect]!.isGranted &&
              result[Permission.bluetoothAdvertise]!.isGranted) {
            // Permission granted
            emit(BluetoothPermissionSuccess());
          } else if (result[Permission.bluetoothScan]!.isPermanentlyDenied &&
              result[Permission.bluetoothAdvertise]!.isPermanentlyDenied &&
              result[Permission.bluetoothConnect]!.isPermanentlyDenied &&
              result[Permission.bluetoothAdvertise]!.isPermanentlyDenied) {
            // Permission permanently denied
            emit(BluetoothPermissionError(
                "Bluetooth permission is permanently denied."));
          } else {
            // Permission denied
            emit(BluetoothPermissionError("Bluetooth permission denied."));
          }
        }
      } else if (Platform.isIOS) {
        // Check the current permission status
        final status = await Permission.bluetooth.status;

        if (status.isGranted) {
          // If permission is already granted
          emit(BluetoothPermissionSuccess());
        } else {
          final result = await Permission.bluetooth.request();

          if (result.isGranted) {
            // Permission granted
            emit(BluetoothPermissionSuccess());
          } else if (result.isPermanentlyDenied) {
            // Permission permanently denied
            emit(BluetoothPermissionError(
                "Bluetooth permission is permanently denied."));
          } else {
            // Permission denied
            emit(BluetoothPermissionError("Bluetooth permission denied."));
          }
        }
      }
    } catch (e) {
      emit(BluetoothPermissionError(
          "Error while requesting Bluetooth permission: $e"));
    }
  }
}
