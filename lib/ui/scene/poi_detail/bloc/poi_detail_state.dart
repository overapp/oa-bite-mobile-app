
import 'package:bite/models/responses/poi/detail/poi_detail.dart';
import 'package:bite/models/responses/route/detail/route_detail.dart';

abstract class PoiDetailState {
  final String poiId;

  PoiDetailState({required this.poiId});
}

class PoiDetailInitial extends PoiDetailState {
  PoiDetailInitial({required super.poiId});
}

class PoiDetailLoading extends PoiDetailState {
  PoiDetailLoading({required super.poiId});
}

class PoiDetailSuccess extends PoiDetailState {
  final PoiDetail poiDetail;
  final int? poiAffluence;

  PoiDetailSuccess({
    required this.poiDetail,
    this.poiAffluence,
    required super.poiId,
  });
}

class PoiDetailGetRouteById extends PoiDetailState {
  final RouteDetail routeDetail;

  PoiDetailGetRouteById({
    required super.poiId,
    required this.routeDetail,
  });
}

class PoiDetailError extends PoiDetailState {
  String message;

  PoiDetailError({
    required this.message,
    required super.poiId,
  });
}
