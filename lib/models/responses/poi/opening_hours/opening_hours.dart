// ignore_for_file: invalid_annotation_target

import 'package:bite/models/responses/poi/time_interval/time_interval.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'opening_hours.freezed.dart';
part 'opening_hours.g.dart';

@freezed
class OpeningHours with _$OpeningHours {
  const factory OpeningHours({
    @JsonKey(name: 'monday')  List<TimeInterval>? monday,
    @JsonKey(name: 'tuesday')  List<TimeInterval>? tuesday,
    @JsonKey(name: 'wednesday')  List<TimeInterval>? wednesday,
    @JsonKey(name: 'thursday')  List<TimeInterval>? thursday,
    @JsonKey(name: 'friday')  List<TimeInterval>? friday,
    @JsonKey(name: 'saturday')  List<TimeInterval>? saturday,
    @JsonKey(name: 'sunday')  List<TimeInterval>? sunday,
  }) = _OpeningHours;

  factory OpeningHours.fromJson(Map<String, dynamic> json) =>
      _$OpeningHoursFromJson(json);
}

