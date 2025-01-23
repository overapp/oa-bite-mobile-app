// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'device_info.freezed.dart';
part 'device_info.g.dart';

@freezed
class DeviceInfo with _$DeviceInfo {
  const factory DeviceInfo({
    @JsonKey(name: 'id') String? id,
    @JsonKey(name: 'installationId') String? installationId,
    @JsonKey(name: 'os') String? os,
    @JsonKey(name: 'osVersion') String? osVersion,
    @JsonKey(name: 'model') String? model,
    @JsonKey(name: 'class') String? path,
  }) = _DeviceInfo;

  factory DeviceInfo.fromJson(Map<String, dynamic> json) =>
      _$DeviceInfoFromJson(json);
}
