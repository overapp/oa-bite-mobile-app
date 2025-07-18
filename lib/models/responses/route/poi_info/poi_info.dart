// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'poi_info.freezed.dart';
part 'poi_info.g.dart';

@freezed
class PoiInfo with _$PoiInfo {
  const factory PoiInfo({
    @JsonKey(name: 'poiId')  String? poiId,
    @JsonKey(name: 'order') int? order,
    @JsonKey(name: 'name') String? name,
    @JsonKey(name: 'description') String? description,
    @JsonKey(name: 'shortDescription') String? shortDescription,
    @JsonKey(name: 'address') String? address,

  }) = _PoiInfo;

  factory PoiInfo.fromJson(Map<String, dynamic> json) =>
      _$PoiInfoFromJson(json);
}

