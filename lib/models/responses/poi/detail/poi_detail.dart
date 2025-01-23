// ignore_for_file: invalid_annotation_target

import 'package:bite/models/responses/location/location.dart';
import 'package:bite/models/responses/poi/opening_hours/opening_hours.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'poi_detail.freezed.dart';
part 'poi_detail.g.dart';

@freezed
class PoiDetail with _$PoiDetail {
  const factory PoiDetail({
    @JsonKey(name: 'id') required String id,
    @JsonKey(name: 'name') required String name,
    @JsonKey(name: 'description') String? description,
    @JsonKey(name: 'shortDescription') String? shortDescription,
    @JsonKey(name: 'address') String? address,
    @JsonKey(name: 'beaconId') required String beaconId,
    @JsonKey(name: 'media') List<String>? media,
    @JsonKey(name: 'openingHours') OpeningHours? openingHours,
    @JsonKey(name: 'contacts') List<Map<String, dynamic>>? contacts,
    @JsonKey(name: 'createdAt') String? createdAt,
    @JsonKey(name: 'createdBy') String? createdBy,
    @JsonKey(name: 'updatedAt') String? updatedAt,
    @JsonKey(name: 'updatedBy') String? updatedBy,
    @JsonKey(name: 'services') List<String>? services,
    @JsonKey(name: 'location') required Location location,
    @JsonKey(name: 'class') String? path,
  }) = _PoiDetail;

  factory PoiDetail.fromJson(Map<String, dynamic> json) =>
      _$PoiDetailFromJson(json);
}

@freezed
class PoiTranslation with _$PoiTranslation {
  const factory PoiTranslation({
    @JsonKey(name: 'name') required String name,
    @JsonKey(name: 'description') String? description,
    @JsonKey(name: 'shortDescription') String? shortDescription,
  }) = _PoiTranslation;

  factory PoiTranslation.fromJson(Map<String, dynamic> json) =>
      _$PoiTranslationFromJson(json);
}
