// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'poi_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PoiInfoImpl _$$PoiInfoImplFromJson(Map<String, dynamic> json) =>
    _$PoiInfoImpl(
      poiId: json['poiId'] as String?,
      order: (json['order'] as num?)?.toInt(),
      name: json['name'] as String?,
      description: json['description'] as String?,
      shortDescription: json['shortDescription'] as String?,
      address: json['address'] as String?,
    );

Map<String, dynamic> _$$PoiInfoImplToJson(_$PoiInfoImpl instance) =>
    <String, dynamic>{
      'poiId': instance.poiId,
      'order': instance.order,
      'name': instance.name,
      'description': instance.description,
      'shortDescription': instance.shortDescription,
      'address': instance.address,
    };
