// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'time_interval.freezed.dart';
part 'time_interval.g.dart';

@freezed
class TimeInterval with _$TimeInterval {
  const factory TimeInterval({
    @JsonKey(name: 'from') required String from,
    @JsonKey(name: 'to') required String to,
  }) = _TimeInterval;

  factory TimeInterval.fromJson(Map<String, dynamic> json) =>
      _$TimeIntervalFromJson(json);
}
