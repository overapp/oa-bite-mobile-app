// ignore_for_file: body_might_complete_normally_nullable

// Use .maybeWhen because .when will be deprecated

import 'package:bite/models/get_device_info/get_device_info.dart';
import 'package:bite/models/network_response/network_response.dart';
import 'package:bite/models/request_type/request_type.dart';
import 'package:bite/models/responses/device_info/device_info.dart';
import 'package:bite/models/responses/location/location.dart';
import 'package:bite/models/responses/poi/detail/poi_detail.dart';
import 'package:bite/models/responses/poi/poi_affluence/poi_affluence.dart';
import 'package:bite/models/responses/pois_by_beacon_coordinates/pois_by_beacon_coordinates.dart';
import 'package:bite/models/responses/request_upload_link/request_upload_link.dart';
import 'package:bite/models/responses/route/detail/route_detail.dart';
import 'package:bite/models/responses/route/get_routes/get_routes.dart';
import 'package:bite/models/responses/sensors/sensor_reading/sensors_reading.dart';
import 'package:bite/models/sensor_reading_model/sensor_reading.dart';
import 'package:bite/repository/interface/manager_interface.dart';
import 'package:bite/services/network/network_service.dart';

class NetworkManager implements Manager {
  /// {GET} API call for retrieving POI detail by id.
  /// Endpoint: /public/pois/{poiId}
  @override
  Future getPoiById(
    String poiId,
    Function success,
    Function error,
  ) async {
    NetworkResponse? poi = await Api().request(
      url: '/public/pois/$poiId',
      requestType: RequestType.GET,
    );

    return poi.maybeWhen(
        onSuccess: (response, status, message) {
          final result = PoiDetail.fromJson(response);
          return success(result);
        },
        loading: (message) {},
        onError: (status, message) {
          return error(status, message);
        },
        orElse: () {
          return error('Unknow error', 'Unknow error');
        });
  }

  /// {GET} API call for retrieving list of POIs started by Coordinates.
  /// EndPoint: /public/pois
  @override
  Future getPoisByCoordinates(
    double latitude,
    double longitude,
    String? searchTerm,
    int page,
    int? pageSize,
    Function success,
    Function error,
  ) async {
    final queryParameters = {
      'latitude': latitude,
      'longitude': longitude,
      if (searchTerm != null) 'fullText': searchTerm,
      'page': page,
      if (pageSize != null) 'pageSize': pageSize,
    };
    NetworkResponse? pois = await Api().request(
      url: '/public/pois',
      queryParameters: queryParameters,
      requestType: RequestType.GET,
    );

    return pois.maybeWhen(
        onSuccess: (response, status, message) {
          final result = PoisByBeaconCoordinates.fromJson(response);
          return success(result);
        },
        loading: (message) {},
        onError: (status, message) {
          return error(status, message);
        },
        orElse: () {
          return error('Unknow error', 'Unknow error');
        });
  }

  /// {GET} API call for retrieving POI started by Beacon external id.
  /// EndPoint: /public/pois/{externalId}/poi
  @override
  Future getPoibyBeaconExternalId(
      String externalId, Function success, Function error) async {
    NetworkResponse? poi = await Api().request(
      url: '/public/beacons/$externalId/poi',
      requestType: RequestType.GET,
    );

    return poi.maybeWhen(
        onSuccess: (response, status, message) {
          final result = PoiDetail.fromJson(response);
          return success(result);
        },
        loading: (message) {},
        onError: (status, message) {
          return error(status, message);
        },
        orElse: () {
          return error('Unknow error', 'Unknow error');
        });
  }

  /// {GET} API call for retrieving Routes.
  /// EndPoint: /public/routes
  @override
  Future getRoutes(
    String? searchTerm,
    String? sortBy,
    int direction,
    int page,
    int pageSize,
    Function success,
    Function error,
  ) async {
    final queryParameters = {
      if (searchTerm != null) 'FullText': searchTerm,
      if (sortBy != null) 'SortBy': sortBy,
      'Direction': direction, // 1 or -1
      'Page': page,
      'PageSize': pageSize,
    };
    NetworkResponse? pois = await Api().request(
      url: '/public/routes',
      queryParameters: queryParameters,
      requestType: RequestType.GET,
    );

    return pois.maybeWhen(
        onSuccess: (response, status, message) {
          final result = GetRoutes.fromJson(response);
          return success(result);
        },
        loading: (message) {},
        onError: (status, message) {
          return error(status, message);
        },
        orElse: () {
          return error('Unknow error', 'Unknow error');
        });
  }

  /// {GET} API call for retrieving Route detail by POI id.
  /// EndPoint: /public/pois/{poiId}/route
  @override
  Future getRoutebyPoiId(String poiId, Function success, Function error) async {
    NetworkResponse? pois = await Api().request(
      url: '/public/pois/$poiId/route',
      requestType: RequestType.GET,
    );

    return pois.maybeWhen(
        onSuccess: (response, status, message) {
          if (response != null && response.isNotEmpty) {
            final result = RouteDetail.fromJson(response);
            return success(result);
          } else {
            return error(status, message);
          }
        },
        loading: (message) {},
        onError: (status, message) {
          return error(status, message);
        },
        orElse: () {
          return error('Unknow error', 'Unknow error');
        });
  }

  /// {POST} API call return suggestion fr next poi to visit
  /// EndPoint: /public/routes/{routeId}/destinations
  @override
  Future getRoutesDestinations(Location userCurrentLocation, String routeId,
      List<String> poiIds, Function success, Function error) async {
    final body = {
      'poiIds': poiIds,
      'currentLocation': {
        'latitude': userCurrentLocation.latitude,
        'longitude':  userCurrentLocation.longitude,
      },
    };

    NetworkResponse? pois = await Api().request(
      url: '/public/routes/$routeId/destinations',
      requestType: RequestType.POST,
      body: body,
    );

    return pois.maybeWhen(
        onSuccess: (response, status, message) {
          if (response != null && response.isNotEmpty) {
            final result = PoiDetail.fromJson(response);
            return success(result);
          } else {
            return error(status, message);
          }
        },
        loading: (message) {},
        onError: (status, message) {
          return error(status, message);
        },
        orElse: () {
          return error('Unknow error', 'Unknow error');
        });
  }

  /// {GET} API call for retrieving POI affluence.
  /// EndPoint: /api/pois/{poiId}/traffic/statistics
  @override
  Future getPoiAffluence(String poiId, Function success, Function error) async {
    NetworkResponse? pois = await Api().request(
      url: '/public/pois/$poiId/traffic/statistics',
      requestType: RequestType.GET,
    );

    return pois.maybeWhen(
        onSuccess: (response, status, message) {
          if (response != null && response.isNotEmpty) {
            final result = PoiAffluence.fromJson(response);
            return success(result);
          } else {
            return error(status, message);
          }
        },
        loading: (message) {},
        onError: (status, message) {
          return error(status, message);
        },
        orElse: () {
          return error('Unknow error', 'Unknow error');
        });
  }

  /// {POST} API call for send installation ID.
  /// EndPoint: /api/devices
  @override
  Future sendInstallationId(
      GetDeviceInfo info, Function success, Function error) async {
    final body = {
      "installationId": info.installationId,
      "os": info.os,
      "osVersion": info.osVersion,
      "model": info.model,
    };

    NetworkResponse? deviceInfo = await Api().request(
      url: '/api/devices',
      requestType: RequestType.POST,
      body: body,
    );

    return deviceInfo.maybeWhen(
        onSuccess: (response, status, message) {
          if (response != null && response.isNotEmpty) {
            final result = DeviceInfo.fromJson(response);
            return success(result);
          } else {
            return error(status, message);
          }
        },
        loading: (message) {},
        onError: (status, message) {
          return error(status, message);
        },
        orElse: () {
          return error('Unknow error', 'Unknow error');
        });
  }

  /// {POST} API call for generate token to write on Azure Blob Storage.
  /// EndPoint: /public/media/pois/{poiId}/alerts
  @override
  Future requestUploadLink(String poiId, String imageName, String type,
      Function success, Function error) async {
    final body = {
      "type": type,
      "name": imageName,
    };

    NetworkResponse? deviceInfo = await Api().request(
      url: '/public/media/pois/$poiId/alerts',
      requestType: RequestType.POST,
      body: body,
    );

    return deviceInfo.maybeWhen(
        onSuccess: (response, status, message) {
          if (response != null && response.isNotEmpty) {
            final result = RequestUploadLink.fromJson(response);

            return success(result);
          } else {
            return error(status, message);
          }
        },
        loading: (message) {},
        onError: (status, message) {
          return error(status, message);
        },
        orElse: () {
          return error('Unknow error', 'Unknow error');
        });
  }

  /// {PUT} API call for confirm image upload on Azure Blob Storage.
  /// EndPoint: /public/media/pois/{poiId}/alerts/{alertId}/confirm
  @override
  Future confirmUpload(
    String poiId,
    String ref,
    String fileName,
    String fileType,
    String email,
    String description,
    String alertId,
    Function success,
    Function error,
  ) async {
    final body = {
      "ref": ref,
      "name": fileName,
      "type": fileType,
      "email": email,
      "description": description,
    };

    NetworkResponse? response = await Api().request(
      url: '/public/media/pois/$poiId/alerts/$alertId/confirm',
      requestType: RequestType.PUT,
      body: body,
    );

    return response.maybeWhen(
        onSuccess: (response, status, message) {
          return success(status);
        },
        loading: (message) {},
        onError: (status, message) {
          return error(status, message);
        },
        orElse: () {
          return error('Unknow error', 'Unknow error');
        });
  }

  /// {GET} API call for retrieving sensors data when scan bluetooth isn't available.
  /// EndPoint: /api/pois/{poiId}/sensor-readings/{type}/latest
  @override
  Future getSensorReading(String poiId, MeasurementType type, Function success,
      Function error) async {
    var measurementType = switch (type) {
      MeasurementType.humidity => 'HUMIDITY',
      MeasurementType.temperature => 'TEMPERATURE',
    };

    NetworkResponse? response = await Api().request(
      url: '/api/pois/$poiId/sensor-readings/$measurementType/latest',
      requestType: RequestType.GET,
    );

    return response.maybeWhen(
        onSuccess: (response, status, message) {
          if (response != null && response.isNotEmpty) {
            final result = SensorsReading.fromJson(response);

            return success(result);
          } else {
            return error(status, message);
          }
        },
        loading: (message) {},
        onError: (status, message) {
          return error(status, message);
        },
        orElse: () {
          return error('Unknow error', 'Unknow error');
        });
  }
}
