// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'sensors_reading.freezed.dart';
part 'sensors_reading.g.dart';

@freezed
class SensorsReading with _$SensorsReading {
  const factory SensorsReading({
    @JsonKey(name: 'poiId') required String poiId,
    @JsonKey(name: 'firstRegistration') String? firstRegistration,
    @JsonKey(name: 'lastRegistration') String? lastRegistration,
    @JsonKey(name: 'value') int? value,
  }) = _SensorsReading;

  factory SensorsReading.fromJson(Map<String, dynamic> json) =>
      _$SensorsReadingFromJson(json);
}
