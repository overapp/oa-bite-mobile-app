// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'poi_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PoiInfoImpl _$$PoiInfoImplFromJson(Map<String, dynamic> json) =>
    _$PoiInfoImpl(
      poiId: json['poiId'] as String,
      order: (json['order'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$PoiInfoImplToJson(_$PoiInfoImpl instance) =>
    <String, dynamic>{
      'poiId': instance.poiId,
      'order': instance.order,
    };
