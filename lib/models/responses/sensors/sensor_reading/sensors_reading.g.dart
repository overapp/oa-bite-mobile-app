// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sensors_reading.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SensorsReadingImpl _$$SensorsReadingImplFromJson(Map<String, dynamic> json) =>
    _$SensorsReadingImpl(
      poiId: json['poiId'] as String,
      firstRegistration: json['firstRegistration'] as String?,
      lastRegistration: json['lastRegistration'] as String?,
      value: (json['value'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$SensorsReadingImplToJson(
        _$SensorsReadingImpl instance) =>
    <String, dynamic>{
      'poiId': instance.poiId,
      'firstRegistration': instance.firstRegistration,
      'lastRegistration': instance.lastRegistration,
      'value': instance.value,
    };
