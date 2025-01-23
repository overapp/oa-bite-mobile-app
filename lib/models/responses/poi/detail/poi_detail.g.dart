// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'poi_detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PoiDetailImpl _$$PoiDetailImplFromJson(Map<String, dynamic> json) =>
    _$PoiDetailImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String?,
      shortDescription: json['shortDescription'] as String?,
      address: json['address'] as String?,
      beaconId: json['beaconId'] as String,
      media:
          (json['media'] as List<dynamic>?)?.map((e) => e as String).toList(),
      openingHours: json['openingHours'] == null
          ? null
          : OpeningHours.fromJson(json['openingHours'] as Map<String, dynamic>),
      contacts: (json['contacts'] as List<dynamic>?)
          ?.map((e) => e as Map<String, dynamic>)
          .toList(),
      createdAt: json['createdAt'] as String?,
      createdBy: json['createdBy'] as String?,
      updatedAt: json['updatedAt'] as String?,
      updatedBy: json['updatedBy'] as String?,
      services: (json['services'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      location: Location.fromJson(json['location'] as Map<String, dynamic>),
      path: json['class'] as String?,
    );

Map<String, dynamic> _$$PoiDetailImplToJson(_$PoiDetailImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'shortDescription': instance.shortDescription,
      'address': instance.address,
      'beaconId': instance.beaconId,
      'media': instance.media,
      'openingHours': instance.openingHours,
      'contacts': instance.contacts,
      'createdAt': instance.createdAt,
      'createdBy': instance.createdBy,
      'updatedAt': instance.updatedAt,
      'updatedBy': instance.updatedBy,
      'services': instance.services,
      'location': instance.location,
      'class': instance.path,
    };

_$PoiTranslationImpl _$$PoiTranslationImplFromJson(Map<String, dynamic> json) =>
    _$PoiTranslationImpl(
      name: json['name'] as String,
      description: json['description'] as String?,
      shortDescription: json['shortDescription'] as String?,
    );

Map<String, dynamic> _$$PoiTranslationImplToJson(
        _$PoiTranslationImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'shortDescription': instance.shortDescription,
    };
