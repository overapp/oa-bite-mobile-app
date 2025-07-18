import 'package:bite/models/responses/poi/detail/poi_detail.dart';
import 'package:bite/models/responses/route/detail/route_detail.dart';
import 'package:bite/models/shared_preferences/active_route/active_route.dart';

abstract class RouteDetailState {
  /// Info of the route
  final RouteDetail detail;

  /// Info of suggested poi start from visited pois
  final PoiDetail? suggestedPoi;

  /// Current active route
  final ActiveRoute? activeRoute;

  /// Tapped poi id from bottom sheet
  final String? tappedPoiId;

  const RouteDetailState({
    required this.detail,
    this.suggestedPoi,
    this.activeRoute,
    this.tappedPoiId,
  });
}

class RouteDetailInitial extends RouteDetailState {
  const RouteDetailInitial({
    required super.detail,
  });
}

class RouteDetailLoading extends RouteDetailState {
  const RouteDetailLoading({
    required super.detail,
  });
}

class RouteDetailSuccess extends RouteDetailState {
  const RouteDetailSuccess({
    required super.detail,
  });
}

class RouteDetailShowBottomSheet extends RouteDetailState {
  const RouteDetailShowBottomSheet({
    required super.detail,
    super.suggestedPoi,
    super.activeRoute,
    super.tappedPoiId,
  });
}

class RouteDetailExistingRoute extends RouteDetailState {
  const RouteDetailExistingRoute({
    required super.detail,
    super.suggestedPoi,
    super.activeRoute,
    super.tappedPoiId,
  });
}

class RouteDetailUpdateActiveRoute extends RouteDetailState {
  final bool showDialog;

  const RouteDetailUpdateActiveRoute({
    required super.detail,
    super.suggestedPoi,
    super.activeRoute,
    super.tappedPoiId,
    required this.showDialog,
  });
}

class RouteDetailVisitedActiveRoute extends RouteDetailState {
  final bool showDialog;

  const RouteDetailVisitedActiveRoute({
    required super.detail,
    super.suggestedPoi,
    super.activeRoute,
    super.tappedPoiId,
    required this.showDialog,
  });
}

class RouteDetailCompleted extends RouteDetailState {
  const RouteDetailCompleted({
    required super.detail,
  });
}

class RouteDetailError extends RouteDetailState {
  const RouteDetailError({
    required super.detail,
  });
}

class RouteDetailGetPositionError extends RouteDetailState {
  const RouteDetailGetPositionError({
    required super.detail,
  });
}
