import 'dart:convert';

import 'package:bite/helpers/firebase_keys.dart';
import 'package:bite/models/responses/location/location.dart';
import 'package:bite/models/responses/poi/detail/poi_detail.dart';
import 'package:bite/models/responses/route/detail/route_detail.dart';
import 'package:bite/models/responses/route/get_routes/get_routes.dart';
import 'package:bite/models/responses/route/poi_info/poi_info.dart';
import 'package:bite/models/shared_preferences/active_route/active_route.dart';
import 'package:bite/repository/manager/repo_manager/repository_manager.dart';
import 'package:bite/services/firebase/firebase_service.dart';
import 'package:bite/ui/scene/tabs/routes/bloc/routes_state.dart';
import 'package:bite/utils/logger.dart';
import 'package:bite/utils/shared_preferences.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:collection/collection.dart';

class RoutesCubit extends Cubit<RoutesState> {
  RoutesCubit() : super(RoutesInitial()) {
    init();
  }

  // Main List Properties
  final PagingController<int, RouteDetail> pagingController =
      PagingController(firstPageKey: 1);

  final int _pageSize = 10;

  // API Response
  GetRoutes? routes;
  GetRoutes? filteredRoutes;

  // Total items for search results
  int? totalItems = 10;
  int currentPage = 1;
  String searchedText = '';

  // Remote Config
  final remoteConfig = FirebaseRemoteConfigService();

  bool _isInitialized = false;

  ActiveRoute? activeRoute;

  // Current Position
  LatLng? currentPosition;

  void init() async {
    if (_isInitialized) {
      return;
    }

    _isInitialized = true;

    pagingController.addPageRequestListener((pageKey) {
      _fetchPage(null, null, 1, pageKey);
    });

    _getFullTextTotalCount();
  }

  void _getFullTextTotalCount() {
    totalItems =
        remoteConfig.getInt(FirebaseRemoteConfigKeys.fullTextSearchTotalCount);
  }

  void updateCurrentPage(int index, String query) {
    currentPage = index;
    searchedText = query;
  }

  // Infinite scroll
  Future<void> _fetchPage(
    String? searchTerm,
    String? sortBy,
    int direction,
    int pageKey,
  ) async {
    emit(RoutesLoading());

    await RepoManager().manager.getRoutes(
      searchTerm,
      sortBy,
      direction,
      pageKey,
      _pageSize,
      (GetRoutes data) async {
        final isLastPage = (data.items.length) < _pageSize;

        routes = data;

        if (isLastPage == true) {
          pagingController.appendLastPage(data.items);
        } else {
          final nextPageKey = pageKey + 1;
          pagingController.appendPage(data.items, nextPageKey);
        }
        await getActiveRoute(false, data.items);

        emit(RoutesSuccess(
          routes: data,
          activeRoute: activeRoute,
        ));
      },
      (String message) {
        emit(RoutesError(message: 'error: $message'));
        pagingController.error = 'error:  $message';
      },
    );
  }

  Future<void> getActiveRoute(
      bool updateScreen, List<RouteDetail> routes) async {
    StorageUtils storageUtils = await StorageUtils.getInstance();

    activeRoute = await storageUtils.getActiveRoute(StorageUtils.activeRoute);

    if (updateScreen) {
      emit(RoutesGetActiveRoute(
        activeRoute: activeRoute,
      ));
    }
  }

  List<PoiInfo>? getPois() {
    if (activeRoute == null) {
      return null;
    }

    return routes?.items
        .firstWhereOrNull(
          (route) => route.id == activeRoute?.routeId,
        )
        ?.stops;
  }

  Future<void> visitedPoi(String poiId) async {
    // Remove other POI with status inVisit
    // activeRoute!.pois
    //     .firstWhereOrNull(
    //       (poi) => poi.status == ActiveRoutePoiStatus.inVisit,
    //     )
    //     ?.status = ActiveRoutePoiStatus.toVisit;

    // In future change state in inVisit and when user is in POI area changed in visited

    emit(RoutesLoading());

    activeRoute!.pois.firstWhereOrNull((poi) => poi.poiId == poiId)?.status =
        ActiveRoutePoiStatus.visited;

    BiteLogger().info('✅ Added POI with status to_visit: $poiId');

    StorageUtils storageUtils = await StorageUtils.getInstance();
    await storageUtils.saveData(
        StorageUtils.activeRoute, json.encode(activeRoute!.toJson()));

    await _checkIfRouteCompleted();

    emit(RouteVisitedActiveRoute(
        suggestedPoi: null, activeRoute: activeRoute, tappedPoiId: poiId));
  }

  Future<void> discardedPoi(String poiId) async {
    emit(RoutesLoading());

    activeRoute!.pois.firstWhereOrNull((poi) => poi.poiId == poiId)?.status =
        ActiveRoutePoiStatus.toAvoid;

    StorageUtils storageUtils = await StorageUtils.getInstance();
    await storageUtils.saveData(
        StorageUtils.activeRoute, json.encode(activeRoute!.toJson()));

    await _checkIfRouteCompleted();

    emit(RouteVisitedActiveRoute(
      suggestedPoi: null,
      activeRoute: activeRoute,
      tappedPoiId: poiId,
    ));
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

      emit(RouteCompleted());
    } else {
      await getNextPoi(
          activeRoute?.routeId ?? '',
          activeRoute?.pois
                  .where((e) =>
                      e.status == ActiveRoutePoiStatus.toVisit 
                      /*||
                      e.status == ActiveRoutePoiStatus.*/)
                  .map((e) => e.poiId)
                  .toList() ??
              []);
    }
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
    } catch (e) {
      BiteLogger().info('POSITION error 📍: $e');
    }
  }

  // API calls

  Future<void> fullTextSearch(String? searchTerm, int page) async {
    if (!_isInitialized) {
      init();
    }

    pagingController.itemList = [];
    searchedText = searchTerm ?? '';
    currentPage = 1;

    await _fetchPage(searchTerm, null, 1, page);
  }

  Location getTappedPoiCordinates(String tappedPoiId) {
    RouteDetail? currentRoute = pagingController.itemList
        ?.where((e) => e.id == activeRoute?.routeId)
        .firstOrNull;
    int poiOrder = currentRoute?.stops
            ?.where((poi) => poi.poiId == tappedPoiId)
            .firstOrNull
            ?.order ??
        0;

    Location poiLocation = Location(
      latitude: currentRoute?.path?[poiOrder].latitude ?? 90,
      longitude: currentRoute?.path?[poiOrder].latitude ?? 90,
    );
    return poiLocation;
  }

  // Return list of POIS for draw markers

  Future<void> getNextPoi(
    String routeId,
    List<String> poiIds,
  ) async {
    await _checkPermissions();

    await RepoManager().manager.getRoutesDestinations(
      Location(
        longitude: currentPosition?.longitude ?? 90,
        latitude: currentPosition?.latitude ?? 90,
      ),
      routeId,
      poiIds,
      (PoiDetail result) {
        emit(RoutesShowBottomSheet(
          suggestedPoi: result,
          activeRoute: activeRoute,
          pois: getPois(),
        ));
      },
      (typeDataError, status, message) {
        emit(
          RoutesError(
            message: "error: $message",
          ),
        );
      },
    );
  }
}
