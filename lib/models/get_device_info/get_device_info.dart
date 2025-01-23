// A data model representing device information.
// This class is used to encapsulate details about a device,
// such as its unique installation ID, hardware model, operating system,
// and OS version.

class GetDeviceInfo {
  final String installationId;
  final String model;
  final String os;
  final String osVersion;

  GetDeviceInfo({
    required this.installationId,
    required this.model,
    required this.os,
    required this.osVersion,
  });
}
