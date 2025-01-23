// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'device_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DeviceInfoImpl _$$DeviceInfoImplFromJson(Map<String, dynamic> json) =>
    _$DeviceInfoImpl(
      id: json['id'] as String?,
      installationId: json['installationId'] as String?,
      os: json['os'] as String?,
      osVersion: json['osVersion'] as String?,
      model: json['model'] as String?,
      path: json['class'] as String?,
    );

Map<String, dynamic> _$$DeviceInfoImplToJson(_$DeviceInfoImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'installationId': instance.installationId,
      'os': instance.os,
      'osVersion': instance.osVersion,
      'model': instance.model,
      'class': instance.path,
    };
