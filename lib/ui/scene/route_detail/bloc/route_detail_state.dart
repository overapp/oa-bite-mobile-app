import 'package:bite/models/responses/route/detail/route_detail.dart';

abstract class RouteDetailState {
  final RouteDetail detail;

  RouteDetailState({
    required this.detail,
  });
}

class RouteDetailInitial extends RouteDetailState {
  RouteDetailInitial({
    required super.detail,
  });
}

class RouteDetailLoading extends RouteDetailState {
  RouteDetailLoading({
    required super.detail,
  });
}

class RouteDetailSuccess extends RouteDetailState {
  RouteDetailSuccess({
    required super.detail,
  });
}

class RouteDetailError extends RouteDetailState {
  RouteDetailError({
    required super.detail,
  });
}

class RouteDetailGetPositionError extends RouteDetailState {
  RouteDetailGetPositionError({
    required super.detail,
  });
}
