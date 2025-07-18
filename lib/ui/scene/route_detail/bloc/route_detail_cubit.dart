import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:bite/models/responses/location/location.dart';
import 'package:bite/models/responses/poi/detail/poi_detail.dart';
import 'package:bite/models/responses/route/detail/route_detail.dart';
import 'package:bite/models/shared_preferences/active_route/active_route.dart';
import 'package:bite/repository/manager/draw_routes_manager.dart';
import 'package:bite/repository/manager/repo_manager/repository_manager.dart';
import 'package:bite/ui/scene/route_detail/bloc/route_detail_state.dart';
import 'package:bite/ui/themes/bite_colors.dart';
import 'package:bite/utils/logger.dart';
import 'package:bite/utils/shared_preferences.dart';
import 'package:bite/utils/utils.dart';
import 'package:collection/collection.dart';
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

  ActiveRoute? activeRoute;

  // Method to get initial values for draw map
  Future<void> _drawInitialMap() async {
    BiteLogger().info('Route: ${state.detail}');

    _checkPermissions();

    await _loadCustomMarkerIcons();

    await _getDirections();
  }

  // Custom Marker
  Future<void> _loadCustomMarkerIcons() async {
    BiteLogger().info('📷 start load icon');
    markerIcon = await BitmapDescriptor.asset(
      const ImageConfiguration(),
      'assets/images/markers/icon_pin/icon_pin_big.png',
    );

    emit(RouteDetailSuccess(detail: state.detail));
  }

  // Check user permission for location
  Future<void> _checkPermissions() async {
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied ||
        permission == LocationPermission.unableToDetermine) {
      BiteLogger().info('Permission Request');
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse) {
      BiteLogger().info('get current location 📍');
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
      BiteLogger().info('POSITION error 📍: $e');
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
      southwest: const LatLng(90, 90),
      northeast: const LatLng(90, 90),
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
    if (state.detail.path == null || state.detail.path!.length < 2) {
      BiteLogger().info('Route with 1 poi');
      return;
    }

    await DrawRoutesManager().drawRoutes(
      state.detail.path ?? [],
      (success) {
        BiteLogger().info('draw route response: $success');
        String encodedString =
            success['routes'][0]['overview_polyline']['points'];

        BiteLogger().info(encodedString);

        points = decodePoly(encodedString);

        BiteLogger().info('decode polyline $points');
        drawPolyline();
      },
      (status, message) {
        BiteLogger().info('error get directions: $status, $message');
        emit(RouteDetailError(detail: state.detail));
      },
    );
  }

  // Draw Polylines
  Future<void> drawPolyline() async {
    if (points == null || points!.isEmpty) {
      BiteLogger().error('No points available to draw a polyline.');
      return;
    }

    PolylineId polylineId =
        PolylineId('route_${DateTime.now().millisecondsSinceEpoch}');

    BiteLogger().info('polyline id: $polylineId');

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

    BiteLogger().info('bounds: $bounds');

    await updateMapPosition(
        currentPosition ?? const LatLng(41.8967, 12.4822), bounds, true);

    BiteLogger().info(
        'Polyline drawn with ID: $polylineId and ${points!.length} points.');

    emit(RouteDetailSuccess(detail: state.detail));
  }

  Future<void> deleteAndActivateNewRoute(String routeId, String routeName) async {
    StorageUtils storageUtils = await StorageUtils.getInstance();
    await storageUtils.removeData(StorageUtils.activeRoute);

    activeRoute = null;

    activateRoute(routeId, routeName);
  }

  Future<void> activateRoute(String routeId, String routeName) async {
    StorageUtils storageUtils = await StorageUtils.getInstance();
    ActiveRoute? existingRoute =
        await storageUtils.getActiveRoute(StorageUtils.activeRoute);

    if (existingRoute != null) {
      // show an alert that reminds about the already active route
      emit(RouteDetailExistingRoute(
        detail: state.detail,
        suggestedPoi: null,
        activeRoute: existingRoute,
      ));
      return;
    }

    final stops = state.detail.stops;
    if (stops == null || stops.isEmpty) {
      BiteLogger()
          .warning('⚠️ No POIs available to activate for route $routeId');
      return;
    }

    // Create and save new active route with all POIs marked as toVisit
    final activeRoute = ActiveRoute(
      routeId: routeId,
      routeName: routeName,
      pois: stops.map((stop) {
        return PoiShortInfo(
          poiId: stop.poiId ?? '',
          status: ActiveRoutePoiStatus.toVisit,
          name: stop.name ?? '',
          address: stop.address ?? '',
          shortDescription: stop.shortDescription ?? '',
          
        );
      }).toList(),
    );

    await storageUtils.saveData(
      StorageUtils.activeRoute,
      json.encode(activeRoute.toJson()),
    );

    BiteLogger().info('🟢 New Active route: $routeId');

    getNextPoi(
      routeId,
      stops.map((stop) => stop.poiId ?? '').toList(),
    );
  }

  void getExistingRoute(ActiveRoute existingRoute) {
    activeRoute = existingRoute;

    BiteLogger().info('🟡 Active Route: ${existingRoute.routeId}');

    var visitedPoiIdsList = existingRoute.pois
        .where((e) =>
            e.status == ActiveRoutePoiStatus.visited ||
            e.status == ActiveRoutePoiStatus.toAvoid)
        .map((e) => e.poiId)
        .toList();

    getNextPoi(existingRoute.routeId, visitedPoiIdsList);
  }

  Future<void> getVisitedPois() async {
    StorageUtils storageUtils = await StorageUtils.getInstance();

    activeRoute = await storageUtils.getActiveRoute(StorageUtils.activeRoute);
  }

  Future<void> onPoiCardTapped(String poiId) async {
    emit(RouteDetailUpdateActiveRoute(
      detail: state.detail,
      suggestedPoi: null,
      activeRoute: activeRoute,
      showDialog: true,
      tappedPoiId: poiId,
    ));
  }

  Future<void> visitedPoi(String poiId) async {
    // Remove other POI with status inVisit
    // activeRoute!.pois
    //     .firstWhereOrNull(
    //       (poi) => poi.status == ActiveRoutePoiStatus.inVisit,
    //     )
    //     ?.status = ActiveRoutePoiStatus.toVisit;

    // In future change state in inVisit and when user is in POI area changed in visited

    emit(RouteDetailLoading(detail: state.detail));

    activeRoute?.pois.firstWhereOrNull((poi) => poi.poiId == poiId)?.status =
        ActiveRoutePoiStatus.visited;
    BiteLogger().info('✅ Added POI with status to_visit: $poiId');

    StorageUtils storageUtils = await StorageUtils.getInstance();
    await storageUtils.saveData(
        StorageUtils.activeRoute, json.encode(activeRoute?.toJson()));

    await _checkIfRouteCompleted();

    emit(RouteDetailVisitedActiveRoute(
        detail: state.detail,
        suggestedPoi: null,
        activeRoute: activeRoute,
        showDialog: false,
        tappedPoiId: poiId));
  }

  Future<void> discardedPoi(String poiId) async {
    emit(RouteDetailLoading(detail: state.detail));

    activeRoute?.pois.firstWhereOrNull((poi) => poi.poiId == poiId)?.status =
        ActiveRoutePoiStatus.toAvoid;

    StorageUtils storageUtils = await StorageUtils.getInstance();
    await storageUtils.saveData(
        StorageUtils.activeRoute, json.encode(activeRoute!.toJson()));

    await _checkIfRouteCompleted();

    emit(RouteDetailVisitedActiveRoute(
        detail: state.detail,
        suggestedPoi: null,
        activeRoute: activeRoute,
        showDialog: false));
  }

  Future<void> _checkIfRouteCompleted() async {
    if (activeRoute == null) return;

    final isCompleted = activeRoute!.pois.every((poi) =>
        poi.status == ActiveRoutePoiStatus.visited ||
        poi.status == ActiveRoutePoiStatus.toAvoid);

    if (isCompleted) {
      BiteLogger().info('✅ Completed route: ${activeRoute!.routeId}');

      // Remove active route from storage
      StorageUtils storageUtils = await StorageUtils.getInstance();
      await storageUtils.removeData(StorageUtils.activeRoute);

      activeRoute = null;

      emit(RouteDetailCompleted(detail: state.detail));
    } else {
      await getNextPoi(
          activeRoute?.routeId ?? '',
          activeRoute?.pois
                  .where((e) => e.status == ActiveRoutePoiStatus.toVisit
                      /* ||
                      e.status == ActiveRoutePoiStatus.toAvoid*/
                      )
                  .map((e) => e.poiId)
                  .toList() ??
              []);
    }
  }

  // API Calls

  // Return suggested POI
  Future<void> getNextPoi(
    String routeId,
    List<String> poiIds,
  ) async {
    await RepoManager().manager.getRoutesDestinations(
      Location(
        longitude: currentPosition?.longitude ?? 90,
        latitude: currentPosition?.latitude ?? 90,
      ),
      routeId,
      poiIds,
      (PoiDetail result) {
        emit(RouteDetailShowBottomSheet(
            detail: state.detail,
            suggestedPoi: result,
            activeRoute: activeRoute));
      },
      (typeDataError, status, message) {
        emit(
          RouteDetailError(
            detail: state.detail,
          ),
        );
      },
    );
  }
}
