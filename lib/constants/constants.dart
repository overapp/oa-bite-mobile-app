// This file contains constant values that are accessible throughout the application. With the integration of environments, some of these values will be dynamically retrieved from configuration files using dart-define-from-file.
class Http {
  static const bool debug = true;
  static const String baseApiUrl = "https://bite-api-dev.azurewebsites.net";
}

class Bluetooth {
  static const int rssiCalibrated = -59;
  static const double propagationFactor = 3;
  static const int intervalBetweenScans = 30;
  static const int timeoutSeconds = 30;
}
