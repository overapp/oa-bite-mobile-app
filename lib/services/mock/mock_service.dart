import 'dart:convert';

import 'package:bite/models/api_calls/api_calls.dart';
import 'package:bite/models/network_response/network_response.dart';
import 'package:bite/models/responses/device_info/device_info.dart';
import 'package:bite/models/responses/poi/detail/poi_detail.dart';
import 'package:bite/models/responses/poi/poi_affluence/poi_affluence.dart';
import 'package:bite/models/responses/pois_by_beacon_coordinates/pois_by_beacon_coordinates.dart';
import 'package:bite/models/responses/route/get_routes/get_routes.dart';
import 'package:flutter/services.dart';

/// Service to manage HTTP requests when MockMode is enabled.
class MockApi {
  MockApi._internal();

  static final _singleton = MockApi._internal();

  factory MockApi() => _singleton;

  Future<NetworkResponse> request({
    required ApiCalls apiCall,
    Function(dynamic data)? fromJson,
    required requestType,
    String? poiId,
  }) async {
    await Future.delayed(const Duration(milliseconds: 50));

    switch (apiCall) {
      case ApiCalls.getPoiById:
        return _getPoiById(poiId);
      case ApiCalls.getPoisByBeaconCoordinates:
        return _getPoisByBeaconCoordinates();
      case ApiCalls.getPoiAffluence:
        return _getPoiAffluence(poiId);
      case ApiCalls.getPoisbyBeaconExternalId:
        return getPoisbyBeaconExternalId();
      case ApiCalls.sendInstallationId:
        return _sendInstallationId();
      case ApiCalls.requireUploadLink:
        return _requireUploadLink();
      case ApiCalls.sensorsReading:
        return _getSensorsReadingValues();
      case ApiCalls.getRoutes:
        return _getRoutes();
      case ApiCalls.getRoutebyId:
        return const NetworkResponse.onError(
            'Default ERROR', 'Error loading mock data');
      case ApiCalls.getRoutesDestinations:
        return _getSuggestedPoi();
    }
  }

  Future<NetworkResponse> getPoisbyBeaconExternalId() async {
    try {
      var jsonModel = 'assets/mock_models/poi_detail_1.json';

      // load local json file
      String jsonString = await rootBundle.loadString(jsonModel);

      final Map<String, dynamic> jsonResponse = jsonDecode(jsonString);

      if (jsonResponse.isNotEmpty) {
        final PoiDetail poiDetail = PoiDetail.fromJson(jsonResponse);

        return NetworkResponse.onSuccess(poiDetail, 'OK', null);
      } else {
        return const NetworkResponse.onError(
          '',
          '',
        );
      }
    } catch (error) {
      return NetworkResponse.onError(
        'ERROR',
        'Error loading mock data: $error',
      );
    }
  }

  Future<NetworkResponse> _getPoiById(String? poiId) async {
    try {
      var jsonModel = 'assets/mock_models/poi_detail_1.json';

      if (poiId == '6744b74e6b7050c7ed6b8a56') {
        jsonModel = 'assets/mock_models/poi_detail_1.json';
      } else {
        jsonModel = 'assets/mock_models/poi_detail_2.json';
      }

      // load local json file
      String jsonString = await rootBundle.loadString(jsonModel);

      final Map<String, dynamic> jsonResponse = jsonDecode(jsonString);

      if (jsonResponse.isNotEmpty) {
        final PoiDetail poiDetail = PoiDetail.fromJson(jsonResponse);

        return NetworkResponse.onSuccess(poiDetail, 'OK', null);
      } else {
        return const NetworkResponse.onError(
          '',
          '',
        );
      }
    } catch (error) {
      return NetworkResponse.onError(
        'ERROR',
        'Error loading mock data: $error',
      );
    }
  }

  Future<NetworkResponse> _getSuggestedPoi() async {
    try {
      var jsonModel = 'assets/mock_models/poi_suggestion.json';

      // load local json file
      String jsonString = await rootBundle.loadString(jsonModel);

      final Map<String, dynamic> jsonResponse = jsonDecode(jsonString);

      if (jsonResponse.isNotEmpty) {
        final PoiDetail poiDetail = PoiDetail.fromJson(jsonResponse);

        return NetworkResponse.onSuccess(poiDetail, 'OK', null);
      } else {
        return const NetworkResponse.onError(
          '',
          '',
        );
      }
    } catch (error) {
      return NetworkResponse.onError(
        'ERROR',
        'Error loading mock data: $error',
      );
    }
  }

  Future<NetworkResponse> _getPoisByBeaconCoordinates() async {
    try {
      var jsonModel = 'assets/mock_models/get_poi_by_beacon_coordinates.json';

      // load local json file
      String jsonString = await rootBundle.loadString(jsonModel);

      final Map<String, dynamic> jsonResponse = jsonDecode(jsonString);

      if (jsonResponse.isNotEmpty) {
        final PoisByBeaconCoordinates poisByBeaconCoordinates =
            PoisByBeaconCoordinates.fromJson(jsonResponse);

        return NetworkResponse.onSuccess(poisByBeaconCoordinates, 'OK', null);
      } else {
        return const NetworkResponse.onError(
          '',
          '',
        );
      }
    } catch (error) {
      return NetworkResponse.onError(
        'ERROR',
        'Error loading mock data: $error',
      );
    }
  }

  Future<NetworkResponse> _getRoutes() async {
    try {
      var jsonModel = 'assets/mock_models/get_routes.json';

      // load local json file
      String jsonString = await rootBundle.loadString(jsonModel);

      final Map<String, dynamic> jsonResponse = jsonDecode(jsonString);

      if (jsonResponse.isNotEmpty) {
        final GetRoutes getroutes = GetRoutes.fromJson(jsonResponse);

        return NetworkResponse.onSuccess(getroutes, 'OK', null);
      } else {
        return const NetworkResponse.onError(
          '',
          '',
        );
      }
    } catch (error) {
      return NetworkResponse.onError(
        'ERROR',
        'Error loading mock data: $error',
      );
    }
  }

  Future<NetworkResponse> _getPoiAffluence(String? poiId) async {
    try {
      var jsonModel = 'assets/mock_models/affluence_poi_1.json';

      if (poiId == '6744b74e6b7050c7ed6b8a56') {
        jsonModel = 'assets/mock_models/affluence_poi_1.json';
      } else {
        jsonModel = 'assets/mock_models/affluence_poi_2.json';
      }

      // load local json file
      String jsonString = await rootBundle.loadString(jsonModel);

      final Map<String, dynamic> jsonResponse = jsonDecode(jsonString);

      if (jsonResponse.isNotEmpty) {
        final PoiAffluence poiAffluence = PoiAffluence.fromJson(jsonResponse);

        return NetworkResponse.onSuccess(poiAffluence, 'OK', null);
      } else {
        return const NetworkResponse.onError(
          '',
          '',
        );
      }
    } catch (error) {
      return NetworkResponse.onError(
        'ERROR',
        'Error loading mock data: $error',
      );
    }
  }

  Future<NetworkResponse> _sendInstallationId() async {
    try {
      var jsonModel = 'assets/mock_models/device_info.json';

      // load local json file
      String jsonString = await rootBundle.loadString(jsonModel);

      final Map<String, dynamic> jsonResponse = jsonDecode(jsonString);

      if (jsonResponse.isNotEmpty) {
        final DeviceInfo poiAffluence = DeviceInfo.fromJson(jsonResponse);

        return NetworkResponse.onSuccess(poiAffluence, 'OK', null);
      } else {
        return const NetworkResponse.onError(
          '',
          '',
        );
      }
    } catch (error) {
      return NetworkResponse.onError(
        'ERROR',
        'Error loading mock data: $error',
      );
    }
  }

  Future<NetworkResponse> _requireUploadLink() async {
    try {
      var jsonModel = 'assets/mock_models/require_upload_link.json';

      // load local json file
      String jsonString = await rootBundle.loadString(jsonModel);

      final Map<String, dynamic> jsonResponse = jsonDecode(jsonString);

      if (jsonResponse.isNotEmpty) {
        return NetworkResponse.onSuccess(jsonResponse, 'OK', null);
      } else {
        return const NetworkResponse.onError(
          '',
          '',
        );
      }
    } catch (error) {
      return NetworkResponse.onError(
        'ERROR',
        'Error loading mock data: $error',
      );
    }
  }

  Future<NetworkResponse> _getSensorsReadingValues() async {
    try {
      var jsonModel = 'assets/mock_models/sensors_reading_humidity.json';

      // load local json file
      String jsonString = await rootBundle.loadString(jsonModel);

      final Map<String, dynamic> jsonResponse = jsonDecode(jsonString);

      if (jsonResponse.isNotEmpty) {
        return NetworkResponse.onSuccess(jsonResponse, 'OK', null);
      } else {
        return const NetworkResponse.onError(
          '',
          '',
        );
      }
    } catch (error) {
      return NetworkResponse.onError(
        'ERROR',
        'Error loading mock data: $error',
      );
    }
  }
}
