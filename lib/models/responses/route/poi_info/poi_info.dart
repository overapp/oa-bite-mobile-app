// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'poi_info.freezed.dart';
part 'poi_info.g.dart';

@freezed
class PoiInfo with _$PoiInfo {
  const factory PoiInfo({
    @JsonKey(name: 'poiId') required String poiId,
    @JsonKey(name: 'order') int? order,
  }) = _PoiInfo;

  factory PoiInfo.fromJson(Map<String, dynamic> json) =>
      _$PoiInfoFromJson(json);
}
