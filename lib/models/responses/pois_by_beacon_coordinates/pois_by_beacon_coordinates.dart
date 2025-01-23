// ignore_for_file: invalid_annotation_target

import 'package:bite/models/responses/poi/detail/poi_detail.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'pois_by_beacon_coordinates.freezed.dart';
part 'pois_by_beacon_coordinates.g.dart';

@freezed
class PoisByBeaconCoordinates with _$PoisByBeaconCoordinates {
  const factory PoisByBeaconCoordinates({
    @JsonKey(name: 'items') required List<PoiDetail> items,
    @JsonKey(name: 'pageNumber') required int pageNumber,
    @JsonKey(name: 'pageSize') required int pageSize,
    @JsonKey(name: 'totalPages') required int totalPages,
    @JsonKey(name: 'totalCount') required int totalCount,
    @JsonKey(name: 'hasPreviousPage') required bool hasPreviousPage,
    @JsonKey(name: 'hasNextPage') required bool hasNextPage,
  }) = _PoisByBeaconCoordinates;

  factory PoisByBeaconCoordinates.fromJson(Map<String, dynamic> json) =>
      _$PoisByBeaconCoordinatesFromJson(json);
}
