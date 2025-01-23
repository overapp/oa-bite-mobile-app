import 'dart:async';
import 'dart:math';

import 'package:bite/models/responses/route/detail/route_detail.dart';
import 'package:bite/repository/manager/draw_routes_manager.dart';
import 'package:bite/ui/scene/route_detail/bloc/route_detail_state.dart';
import 'package:bite/ui/themes/bite_colors.dart';
import 'package:bite/utils/logger.dart';
import 'package:bite/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class RouteDetailCubit extends Cubit<RouteDetailState> {
  RouteDetailCubit(RouteDetail detail)
      : super(RouteDetailInitial(detail: detail)) {
    _drawInitialMap();
  }

  // Map Style
  BitmapDescriptor? markerIcon;
  final Set<Polyline> polylines = {};
  List<LatLng>? points;

  // Maps Info
  LatLng initialCoordinates = const LatLng(90, 90);

  // Google Maps Controller
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  // Current Position
  LatLng? currentPosition;

  // Method to get initial values for draw map
  Future<void> _drawInitialMap() async {
    _checkPermissions();
    await _getDirections();
    await _loadCustomMarkerIcons();
  }

  // Custom Marker
  Future<void> _loadCustomMarkerIcons() async {
    markerIcon = await BitmapDescriptor.asset(
      const ImageConfiguration(),
      'assets/images/markers/icon_pin/icon_pin_big.png',
    );
  }

  // Check user permission for location
  Future<void> _checkPermissions() async {
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied ||
        permission == LocationPermission.unableToDetermine) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse) {
      await _getCurrentLocation();
    }
  }

  // Get user location
  Future<void> _getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition();

      currentPosition = LatLng(position.latitude, position.longitude);

      BiteLogger().info('POSITION 📍: $currentPosition');
    } catch (e) {
      emit(
        RouteDetailGetPositionError(
          detail: state.detail,
        ),
      );
    }
  }

  // Calculate dynamic zoom
  LatLngBounds _getDynamicZoom(LatLng currentPosition, List<LatLng> points) {
    if (points.isNotEmpty) {
      double minLat =
          points.map((point) => point.latitude).reduce((a, b) => a < b ? a : b);
      double maxLat =
          points.map((point) => point.latitude).reduce((a, b) => a > b ? a : b);
      double minLng = points
          .map((point) => point.longitude)
          .reduce((a, b) => a < b ? a : b);
      double maxLng = points
          .map((point) => point.longitude)
          .reduce((a, b) => a > b ? a : b);

      minLat = min(minLat, currentPosition.latitude);
      maxLat = max(maxLat, currentPosition.latitude);
      minLng = min(minLng, currentPosition.longitude);
      maxLng = max(maxLng, currentPosition.longitude);

      return LatLngBounds(
        southwest: LatLng(minLat, minLng),
        northeast: LatLng(maxLat, maxLng),
      );
    }

    return LatLngBounds(
      southwest: const LatLng(0, 0),
      northeast: const LatLng(0, 0),
    );
  }

  // Update Map with animation
  Future<void> updateMapPosition(
      LatLng newPosition, LatLngBounds bounds, bool isBounds) async {
    if (!_controller.isCompleted) {
      return;
    }

    final GoogleMapController controller = await _controller.future;

    if (_controller.isCompleted) {
      if (isBounds) {
        CameraUpdate cameraUpdate = CameraUpdate.newLatLngBounds(bounds, 30);

        await controller.animateCamera(cameraUpdate);
      } else {
        CameraUpdate cameraUpdate = CameraUpdate.newCameraPosition(
          CameraPosition(
            target: newPosition,
            zoom: 14,
          ),
        );
        await controller.animateCamera(cameraUpdate);
      }
    }
  }

  // Map Controller
  Future<void> setMapController(
    GoogleMapController controller,
  ) async {
    if (!_controller.isCompleted) {
      _controller.complete(controller);
    }
  }

  Future<void> _getDirections() async {
    await DrawRoutesManager().drawRoutes(
      state.detail.path ?? [],
      (success) {
        String encodedString =
            success['routes'][0]['overview_polyline']['points'];
        points = decodePoly(encodedString);
        drawPolyline();
      },
      (status, message) {
        emit(RouteDetailError(detail: state.detail));
      },
    );
  }

  // Draw Polylines
  void drawPolyline() async {
    if (points == null || points!.isEmpty) {
      BiteLogger().error('No points available to draw a polyline.');
      return;
    }

    PolylineId polylineId =
        PolylineId('route_${DateTime.now().millisecondsSinceEpoch}');

    polylines.add(
      Polyline(
        polylineId: polylineId,
        visible: true,
        width: 5,
        points: points!,
        color: BiteColors.primaryColor,
      ),
    );

    var bounds =
        _getDynamicZoom(currentPosition ?? const LatLng(90, 90), points!);

    await updateMapPosition(
        currentPosition ?? const LatLng(90, 90), bounds, true);

    BiteLogger().info(
        'Polyline drawn with ID: $polylineId and ${points!.length} points.');
    emit(RouteDetailSuccess(detail: state.detail));
  }
}
