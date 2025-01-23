import 'dart:async';
import 'dart:io';
import 'package:bite/helpers/firebase_keys.dart';
import 'package:bite/models/get_device_info/get_device_info.dart';
import 'package:bite/models/responses/device_info/device_info.dart';
import 'package:bite/repository/manager/repo_manager/repository_manager.dart';
import 'package:bite/ui/scene/splash/bloc/splash_state.dart';
import 'package:bite/services/firebase/firebase_service.dart';
import 'package:bite/services/notifications/local_notifications_service.dart';
import 'package:bite/utils/logger.dart';
import 'package:bite/utils/shared_preferences.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_app_installations/firebase_app_installations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(SplashInitial()) {
    LocalNotificationService().initialize();
    _startTimer();
  }

  void _startTimer() {
    Timer(
      const Duration(seconds: 3),
      () async {
        await _fetchValues();
      },
    );
  }

  Future<void> checkBluetoothPermission() async {
    if (Platform.isIOS) {
      final status = await Permission.bluetooth.status;

      if (status.isGranted || status.isPermanentlyDenied) {
        emit(SplashPermissionChechLoaded(shouldAskBluetoothPermission: false));
      } else {
        emit(SplashPermissionChechLoaded(shouldAskBluetoothPermission: true));
      }
    } else if (Platform.isAndroid) {
      if (Platform.isAndroid) {
        final status = await Future.wait([
          Permission.bluetoothScan.status,
          Permission.bluetoothAdvertise.status,
          Permission.bluetoothConnect.status
        ]);

        if (status.every((element) => element.isGranted)) {
          emit(
              SplashPermissionChechLoaded(shouldAskBluetoothPermission: false));
        } else {
          emit(SplashPermissionChechLoaded(shouldAskBluetoothPermission: true));
        }
      }
    }
  }

  Future<void> _fetchValues() async {
    try {
      final remoteConfig = FirebaseRemoteConfigService();

      await remoteConfig.fetchAndActivate();

      StorageUtils storageUtils = await StorageUtils.getInstance();

      String? deviceId = await storageUtils.getString(StorageUtils.deviceId);

      if (deviceId == null || deviceId.isEmpty) {
        await _sendInstallationId();
      }

      final message =
          remoteConfig.getString(FirebaseRemoteConfigKeys.welcomeMessage);

      emit(SplashLoaded(welcomeMessage: message));
    } catch (e) {
      BiteLogger().error('Failed to fetch remote config: $e');
      emit(SplashError());
    }
  }

  Future<void> _sendInstallationId() async {
    final deviceInfo = await _getDeviceInfo();

    await RepoManager().manager.sendInstallationId(
      deviceInfo,
      (DeviceInfo result) async {
        StorageUtils storageUtils = await StorageUtils.getInstance();

        storageUtils.saveData(
          StorageUtils.deviceId,
          result.id,
        );

        BiteLogger().info('Installation id: $result');
      },
      (typeDataError, status, message) {},
    );
  }

// Get Installation id, os, os version, device model
  Future<GetDeviceInfo> _getDeviceInfo() async {
    final deviceInfo = DeviceInfoPlugin();

    String installationId = await FirebaseInstallations.instance.getId();

    try {
      if (Platform.isAndroid) {
        AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;

        return GetDeviceInfo(
          installationId: installationId,
          model: '${androidInfo.manufacturer} ${androidInfo.model}',
          os: 'Android',
          osVersion: 'Android ${androidInfo.version.release}',
        );
      } else if (Platform.isIOS) {
        IosDeviceInfo iosInfo = await deviceInfo.iosInfo;

        return GetDeviceInfo(
          installationId: installationId,
          model: iosInfo.utsname.machine,
          os: 'iOS',
          osVersion: 'iOS ${iosInfo.systemVersion}',
        );
      }
    } catch (e) {
      BiteLogger()
          .error('Errore nel recupero delle informazioni del dispositivo: $e');

      return GetDeviceInfo(
        installationId: '',
        model: '',
        os: '',
        osVersion: '',
      );
    }

    return GetDeviceInfo(
      installationId: '',
      model: '',
      os: '',
      osVersion: '',
    );
  }
}
