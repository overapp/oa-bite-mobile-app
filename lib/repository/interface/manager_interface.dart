import 'package:bite/models/get_device_info/get_device_info.dart';

// Manager Interface which includes every method that needs to be implemented in order to perform an API call.

abstract class Manager {
  /// {GET} API call for retrieving POI detail by id.
  /// Endpoint: /public/pois/{poiId}
  Future<dynamic> getPoiById(
    String poiId,
    Function success,
    Function error,
  );

  /// {GET} API call for retrieving list of POIs started by Coordinates.
  /// EndPoint: /public/pois
  Future<dynamic> getPoisByCoordinates(
    double latitude,
    double longitude,
    String? searchTerm,
    int page,
    int? pageSize,
    Function success,
    Function error,
  );

  /// {GET} API call for retrieving POI started by Beacon external id.
  /// EndPoint: /public/pois/{externalId}/poi
  Future<dynamic> getPoibyBeaconExternalId(
    String externalId,
    Function success,
    Function error,
  );

  /// {GET} API call for retrieving Routes.
  /// EndPoint: /public/routes
  Future<dynamic> getRoutes(
    String? searchTerm,
    String? sortBy,
    int direction,
    int page,
    int pageSize,
    Function success,
    Function error,
  );

  /// {GET} API call for retrieving Route detail by POI id.
  /// EndPoint: /public/pois/{poiId}/route
  Future<dynamic> getRoutebyPoiId(
    String poiId,
    Function success,
    Function error,
  );

  /// {GET} API call for retrieving POI affluence.
  /// EndPoint: /api/pois/{poiId}/traffic/statistics
  Future<dynamic> getPoiAffluence(
    String poiId,
    Function success,
    Function error,
  );

  /// {POST} API call for send installation ID.
  /// EndPoint: /api/devices
  Future<dynamic> sendInstallationId(
    GetDeviceInfo deviceInfo,
    Function success,
    Function error,
  );

  /// {POST} API call for generate token to write on Azure Blob Storage.
  /// EndPoint: /public/media/pois/{poiId}/alerts
  Future<dynamic> requestUploadLink(
    String poiId,
    String fileName,
    String fileType,
    Function success,
    Function error,
  );

/// {PUT} API call for confirm image upload on Azure Blob Storage.
  /// EndPoint: /public/media/pois/{poiId}/alerts/{alertId}/confirm
  Future<dynamic> confirmUpload(
    String poiId,
    String ref,
    String fileName,
    String fileType,
    String email,
    String alertId,
    String description,
    Function success,
    Function error,
  );
}
