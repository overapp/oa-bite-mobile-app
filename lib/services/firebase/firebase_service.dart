import 'package:bite/helpers/firebase_keys.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';

/// Service for managing Firebase Remote Config settings and values.
class FirebaseRemoteConfigService {
  // Private constructor to implement a singleton pattern.
  FirebaseRemoteConfigService._()
      : _remoteConfig = FirebaseRemoteConfig.instance;

  // Singleton instance of the service.
  static FirebaseRemoteConfigService? _instance;

  // The factory constructor returns the already existing instance, ensuring
  // that there are not multiple BluetoothManager objects floating around.
  factory FirebaseRemoteConfigService() =>
      _instance ??= FirebaseRemoteConfigService._();

  // Instance of Firebase Remote Config.
  final FirebaseRemoteConfig _remoteConfig;

  /// Retrieves a string value from the remote config using the provided key.
  String getString(String key) => _remoteConfig.getString(key);

  /// Retrieves a boolean value from the remote config using the provided key.
  bool getBool(String key) => _remoteConfig.getBool(key);

  /// Retrieves a integer value from the remote config using the provided key.
  int getInt(String key) => _remoteConfig.getInt(key);

  /// Retrieves a double value from the remote config using the provided key.
  double getDouble(String key) => _remoteConfig.getDouble(key);

  // Initializes the Remote Config by setting default values, applying settings,
  // and enabling real-time updates.
  Future<void> initialize() async {
    await _setConfigSettings();
    await fetchAndActivate();

  // Listen for config updates and activate changes.
    _remoteConfig.onConfigUpdated.listen((event) async {
      await _remoteConfig.activate();
    });
  }

  // Configures settings such as fetch timeout and minimum fetch interval.
  Future<void> _setConfigSettings() async => _remoteConfig.setConfigSettings(
        RemoteConfigSettings(
          fetchTimeout: const Duration(minutes: 1),
          minimumFetchInterval: const Duration(minutes: 2),
        ),
      );

  // Sets default values for the remote config to use as fallback.
  Future<void> _setDefaults() async => _remoteConfig.setDefaults(
        const {
          FirebaseRemoteConfigKeys.welcomeMessage:
              'this message is coming from local defaults',
        },
      );

  /// Fetches the latest configuration and activates it. If no updates are
  /// available, it applies the default values.
  Future<void> fetchAndActivate() async {
    bool updated = await _remoteConfig.fetchAndActivate();

    if (updated) {
      debugPrint('The config has been updated.');
    } else {
      debugPrint('The config is not updated..');
      await _setDefaults();
    }
  }
}
