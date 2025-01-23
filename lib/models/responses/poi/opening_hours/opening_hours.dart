// ignore_for_file: invalid_annotation_target

import 'package:bite/models/responses/poi/time_interval/time_interval.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'opening_hours.freezed.dart';
part 'opening_hours.g.dart';

@freezed
class OpeningHours with _$OpeningHours {
  const factory OpeningHours({
    @JsonKey(name: 'monday') required List<TimeInterval> monday,
    @JsonKey(name: 'tuesday') required List<TimeInterval> tuesday,
    @JsonKey(name: 'wednesday') required List<TimeInterval> wednesday,
    @JsonKey(name: 'thursday') required List<TimeInterval> thursday,
    @JsonKey(name: 'friday') required List<TimeInterval> friday,
    @JsonKey(name: 'saturday') required List<TimeInterval> saturday,
    @JsonKey(name: 'sunday') required List<TimeInterval> sunday,
  }) = _OpeningHours;

  factory OpeningHours.fromJson(Map<String, dynamic> json) =>
      _$OpeningHoursFromJson(json);
}

