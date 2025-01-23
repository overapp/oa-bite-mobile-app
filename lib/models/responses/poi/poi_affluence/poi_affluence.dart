// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'poi_affluence.freezed.dart';
part 'poi_affluence.g.dart';

@freezed
class PoiAffluence with _$PoiAffluence {
  const factory PoiAffluence({
    @JsonKey(name: 'value') required int value,
  }) = _PoiAffluence;

  factory PoiAffluence.fromJson(Map<String, dynamic> json) =>
      _$PoiAffluenceFromJson(json);
}
