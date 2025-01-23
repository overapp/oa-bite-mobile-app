import 'package:bite/utils/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StorageUtils {
  static StorageUtils? _instance;
  static SharedPreferences? _preferences;

  // Keys
  static const deviceId = 'deviceId';

  static Future<StorageUtils> getInstance() async {
    _instance ??= StorageUtils();
    _preferences ??= await SharedPreferences.getInstance();
    return _instance!;
  }

  // Method to save data in Shared Preferences
  Future<dynamic> saveData(String key, dynamic value) async {
    try {
      var isString = value is String;
      if (!isString) {
        value = value.toString();
      }

      return _preferences!.setString(key, value);
    } catch (err) {
      BiteLogger().info(err.toString());
      return Future.value(false);
    }
  }

  // Method to delete data in Shared Preferences
  Future<dynamic> removeData(String key) {
    return _preferences!.remove(key);
  }

  // Method to get String saved in Shared Preferences
  Future<String?> getString(String key) async {
    try {
      Object? value = _preferences!.get(key);

      if (value == null) {
        return Future.value(null);
      }

      return Future.value(value as String?);
    } catch (err) {
      BiteLogger().info(err.toString());
      return Future.value(null);
    }
  }

  // Method to get bool saved in Shared Preferences
  Future<bool> getBool(String key, {bool defaultValue = false}) async {
    String? value = await getString(key);

    if (value == null) {
      return Future.value(defaultValue);
    }

    try {
      return Future.value(bool.parse(value, caseSensitive: false));
    } catch (err) {
      BiteLogger().info(err.toString());
      return Future.value(defaultValue);
    }
  }

  // Method to get double saved in Shared Preferences
  Future<double?> getDouble(String key) async {
    String? value = await getString(key);

    if (value == null) {
      return Future.value(null);
    }

    try {
      return Future.value(double.parse(
        value,
      ));
    } catch (err) {
      BiteLogger().info(err.toString());
      return Future.value(null);
    }
  }
}
