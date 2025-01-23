// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:bite/models/responses/poi/detail/poi_detail.dart';

abstract class PoiDetailFromBeaconState {
  final String beaconId;

  PoiDetailFromBeaconState({required this.beaconId});
}

class PoiDetailFromBeaconInitial extends PoiDetailFromBeaconState {
  PoiDetailFromBeaconInitial({required super.beaconId});
}

class PoiDetailFromBeaconLoading extends PoiDetailFromBeaconState {
  PoiDetailFromBeaconLoading({required super.beaconId});
}

class PoiDetailFromBeaconSuccess extends PoiDetailFromBeaconState {
  final PoiDetail? poiDetail;
  final int? poiAffluence;
  final String? humidity;
  final String? temperature;

  PoiDetailFromBeaconSuccess({
    required this.poiDetail,
    this.poiAffluence,
    required super.beaconId,
    this.humidity,
    this.temperature,
  });
}

class PoiDetailFromBeaconError extends PoiDetailFromBeaconState {
  String message;

  PoiDetailFromBeaconError({
    required this.message,
    required super.beaconId,
  });
}

class PoiDetailFromBeaconScanDisposed extends PoiDetailFromBeaconState {
  PoiDetailFromBeaconScanDisposed({
    required super.beaconId,
  });
}
