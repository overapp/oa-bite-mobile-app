import 'package:bite/models/api_calls/api_calls.dart';
import 'package:bite/models/get_device_info/get_device_info.dart';
import 'package:bite/models/network_response/network_response.dart';
import 'package:bite/models/request_type/request_type.dart';
import 'package:bite/repository/interface/manager_interface.dart';
import 'package:bite/services/mock/mock_service.dart';

class MockManager implements Manager {
  @override
  Future getPoiById(
    String poiId,
    Function success,
    Function error,
  ) async {
    NetworkResponse? getPoiById = await MockApi().request(
      apiCall: ApiCalls.getPoiById,
      requestType: RequestType.GET,
      poiId: poiId,
    );

    return getPoiById.maybeWhen(onSuccess: (response, status, message) {
      return success(response);
    }, loading: (message) {
      return null;
    }, onError: (status, message) {
      return error(status, message);
    }, orElse: () {
      return null;
    });
  }

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
    NetworkResponse? getPoiByCoordinates = await MockApi().request(
      apiCall: ApiCalls.getPoisByBeaconCoordinates,
      requestType: RequestType.GET,
    );

    return getPoiByCoordinates.maybeWhen(
        onSuccess: (response, status, message) {
      return success(response);
    }, loading: (message) {
      return null;
    }, onError: (status, message) {
      return error(status, message);
    }, orElse: () {
      return null;
    });
  }

  @override
  Future getPoibyBeaconExternalId(
    String externalId,
    Function success,
    Function error,
  ) async {
    NetworkResponse? getPoisbyBeaconExternalId = await MockApi().request(
      apiCall: ApiCalls.getPoisbyBeaconExternalId,
      requestType: RequestType.GET,
    );

    return getPoisbyBeaconExternalId.maybeWhen(
        onSuccess: (response, status, message) {
      return success(response);
    }, loading: (message) {
      return null;
    }, onError: (status, message) {
      return error(status, message);
    }, orElse: () {
      return null;
    });
  }

  @override
  Future getRoutebyPoiId(
    String poiId,
    Function success,
    Function error,
  ) async {
    NetworkResponse? getRoutebyId = await MockApi().request(
      apiCall: ApiCalls.getRoutebyId,
      requestType: RequestType.GET,
    );

    return getRoutebyId.maybeWhen(onSuccess: (response, status, message) {
      return success(response);
    }, loading: (message) {
      return null;
    }, onError: (status, message) {
      return error(status, message);
    }, orElse: () {
      return null;
    });
  }

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
    NetworkResponse? getRoutes = await MockApi().request(
      apiCall: ApiCalls.getRoutes,
      requestType: RequestType.GET,
    );

    return getRoutes.maybeWhen(onSuccess: (response, status, message) {
      return success(response);
    }, loading: (message) {
      return null;
    }, onError: (status, message) {
      return error(status, message);
    }, orElse: () {
      return null;
    });
  }

  // Get POI affluence
  @override
  Future getPoiAffluence(
    String poiId,
    Function success,
    Function error,
  ) async {
    NetworkResponse? getPoiAffluence = await MockApi().request(
      apiCall: ApiCalls.getPoiAffluence,
      requestType: RequestType.GET,
      poiId: poiId,
    );

    return getPoiAffluence.maybeWhen(onSuccess: (response, status, message) {
      return success(response);
    }, loading: (message) {
      return null;
    }, onError: (status, message) {
      return error(status, message);
    }, orElse: () {
      return null;
    });
  }

  @override
  Future sendInstallationId(
    GetDeviceInfo info,
    Function success,
    Function error,
  ) async {
    NetworkResponse? deviceInfo = await MockApi().request(
      apiCall: ApiCalls.sendInstallationId,
      requestType: RequestType.POST,
    );

    return deviceInfo.maybeWhen(onSuccess: (response, status, message) {
      return success(response);
    }, loading: (message) {
      return null;
    }, onError: (status, message) {
      return error(status, message);
    }, orElse: () {
      return null;
    });
  }

  @override
  Future requestUploadLink(
    String poiId,
    String fileName,
    String fileType,
    Function success,
    Function error,
  ) async {
    NetworkResponse? deviceInfo = await MockApi().request(
      apiCall: ApiCalls.requireUploadLink,
      requestType: RequestType.POST,
    );

    return deviceInfo.maybeWhen(onSuccess: (response, status, message) {
      return success(response);
    }, loading: (message) {
      return null;
    }, onError: (status, message) {
      return error(status, message);
    }, orElse: () {
      return null;
    });
  }

  @override
  Future confirmUpload(
    String poiId,
    String ref,
    String fileName,
    String fileType,
    String email,
    String alertId,
    String description,
    Function success,
    Function error,
  ) async {
    // NetworkResponse? deviceInfo = await MockApi().request(
    //   apiCall: ApiCalls.requireUploadLink,
    //   requestType: RequestType.POST,
    // );

    // return deviceInfo.maybeWhen(onSuccess: (response, status, message) {
    //   return success(response);
    // }, loading: (message) {
    //   return null;
    // }, onError: (status, message) {
    //   return error(status, message);
    // }, orElse: () {
    //   return null;
    // });
  }
}
