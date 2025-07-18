// ignore_for_file: invalid_annotation_target

import 'package:bite/models/responses/location/location.dart';
import 'package:bite/models/responses/poi/opening_hours/opening_hours.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'poi_detail.freezed.dart';
part 'poi_detail.g.dart';

@freezed
class PoiDetail with _$PoiDetail {
  const factory PoiDetail({
    @JsonKey(name: 'id') String? id,
    @JsonKey(name: 'name') String? name,
    @JsonKey(name: 'description') String? description,
    @JsonKey(name: 'shortDescription') String? shortDescription,
    @JsonKey(name: 'address') String? address,
    @JsonKey(name: 'beaconId') String? beaconId,
    @JsonKey(name: 'media') List<Media>? media,
    @JsonKey(name: 'openingHours') OpeningHours? openingHours,
    @JsonKey(name: 'contacts') List<Map<String, dynamic>>? contacts,
    @JsonKey(name: 'createdAt') String? createdAt,
    @JsonKey(name: 'createdBy') String? createdBy,
    @JsonKey(name: 'updatedAt') String? updatedAt,
    @JsonKey(name: 'updatedBy') String? updatedBy,
    @JsonKey(name: 'services') List<String>? services,
    @JsonKey(name: 'location') Location? location,
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

@freezed
class Media with _$Media {
  const factory Media({
    @JsonKey(name: 'ref') String? ref,
    @JsonKey(name: 'name') String? name,
    @JsonKey(name: 'type') String? type,
    @JsonKey(name: 'url') String? url,
  }) = _Media;

  factory Media.fromJson(Map<String, dynamic> json) => _$MediaFromJson(json);
}
