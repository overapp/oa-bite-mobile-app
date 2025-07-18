import 'package:bite/models/responses/poi/detail/poi_detail.dart';
import 'package:bite/models/responses/route/get_routes/get_routes.dart';
import 'package:bite/models/responses/route/poi_info/poi_info.dart';
import 'package:bite/models/shared_preferences/active_route/active_route.dart';

abstract class RoutesState {}

class RoutesInitial extends RoutesState {}

class RoutesLoading extends RoutesState {}

class RoutesSuccess extends RoutesState {
  final GetRoutes routes;
  final ActiveRoute? activeRoute;

  RoutesSuccess({
    required this.routes,
    this.activeRoute,
  });
}

class RoutesGetActiveRoute extends RoutesState {
  final ActiveRoute? activeRoute;

  RoutesGetActiveRoute({
    this.activeRoute,
  });
}

class RoutesShowBottomSheet extends RoutesState {
  PoiDetail? suggestedPoi;
  ActiveRoute? activeRoute;
  final List<PoiInfo>? pois;

  RoutesShowBottomSheet({
    this.suggestedPoi,
    this.activeRoute,
    this.pois,
  });
}

class RouteVisitedActiveRoute extends RoutesState {
  PoiDetail? suggestedPoi;
  ActiveRoute? activeRoute;
  final List<PoiInfo>? pois;
  final String tappedPoiId;

  RouteVisitedActiveRoute({
    this.suggestedPoi,
    this.activeRoute,
    this.pois,
    required this.tappedPoiId,
  });
}

class RouteCompleted extends RoutesState {}

class RoutesError extends RoutesState {
  final String message;

  RoutesError({
    required this.message,
  });
}
