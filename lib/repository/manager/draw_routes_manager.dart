import 'dart:io';

import 'package:bite/models/network_response/network_response.dart';
import 'package:bite/models/request_type/request_type.dart';
import 'package:bite/models/responses/location/location.dart';
import 'package:bite/services/routes/draw_routes_service.dart';
import 'package:bite/utils/logger.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

// Manages the process of drawing routes between multiple geographic locations
// using the Google Directions API.
class DrawRoutesManager {
  DrawRoutesManager();

  Future drawRoutes(
    List<Location> coordinates,
    Function success,
    Function error,
  ) async {
    String apiKey;

    if (Platform.isAndroid) {
      apiKey = dotenv.env['MAPS_API_KEY_ANDROID'] ?? '';
    } else {
      apiKey = dotenv.env['MAPS_API_KEY_IOS'] ?? '';
    }

    // Departure and arrive pois coordinates
    final String origin =
        "${coordinates.first.latitude},${coordinates.first.longitude}";
    final String destination =
        "${coordinates.last.latitude},${coordinates.last.longitude}";

    // Waypoints
    final List<Location> waypoints =
        coordinates.sublist(1, coordinates.length - 1);
    final String waypointsString = waypoints
        .map((point) => "${point.latitude},${point.longitude}")
        .join('|');

    // Create URL for Directions API
    final String url = "https://maps.googleapis.com/maps/api/directions/json?"
        "origin=$origin&destination=$destination"
        "${waypoints.isNotEmpty ? '&waypoints=$waypointsString' : ''}&key=$apiKey";

    BiteLogger().info('Request Routes URL: $url');

    // Call Google API
    NetworkResponse? poi = await RoutesApi().request(
      url: url,
      requestType: RequestType.GET,
    );

    return poi.maybeWhen(
      onSuccess: (response, status, message) async {
        BiteLogger().info('ROUTES 🪡: $response');

        return success(response);
      },
      loading: (message) {
        return null;
      },
      onError: (status, message) {
        return error(status, message);
      },
      orElse: () {
        return error('unknow error', 'unknow error');
      },
    );
  }
}
