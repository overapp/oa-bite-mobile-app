import 'package:bite/models/responses/poi/detail/poi_detail.dart';
import 'package:bite/models/responses/route/detail/route_detail.dart';
import 'package:bite/models/screen/poi_detail/screen_type.dart';

abstract class PoiDetailState {
  final String? poiId;
  final String? beaconId;
  final PoiDetailScreenType screenType;

  PoiDetailState({
    this.poiId,
    this.beaconId,
    this.screenType = PoiDetailScreenType.fromMap,
  });
}

class PoiDetailInitial extends PoiDetailState {
  PoiDetailInitial({
    super.poiId,
    super.beaconId,
    super.screenType,
  });
}

class PoiDetailLoading extends PoiDetailState {
  PoiDetailLoading({
    super.poiId,
    super.beaconId,
    super.screenType,
  });
}

class PoiDetailSuccess extends PoiDetailState {
  final PoiDetail poiDetail;
  final int? poiAffluence;
  final String? humidity;
  final String? temperature;

  PoiDetailSuccess(
      {super.poiId,
      super.beaconId,
      super.screenType,
      required this.poiDetail,
      this.poiAffluence,
      this.humidity,
      this.temperature});
}

class PoiDetailGetRouteById extends PoiDetailState {
  final RouteDetail routeDetail;

  PoiDetailGetRouteById({
    super.poiId,
    super.beaconId,
    super.screenType,
    required this.routeDetail,
  });
}

class PoiDetailError extends PoiDetailState {
  String message;

  PoiDetailError({
    super.poiId,
    super.beaconId,
    super.screenType,
    required this.message,
  });
}

class PoiDetailScanDisposed extends PoiDetailState {
  PoiDetailScanDisposed({
    required super.beaconId,
  });
}
