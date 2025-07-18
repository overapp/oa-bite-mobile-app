// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'route_detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$RouteDetailImpl _$$RouteDetailImplFromJson(Map<String, dynamic> json) =>
    _$RouteDetailImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String?,
      stops: (json['stops'] as List<dynamic>?)
          ?.map((e) => PoiInfo.fromJson(e as Map<String, dynamic>))
          .toList(),
      path: (json['path'] as List<dynamic>?)
          ?.map((e) => Location.fromJson(e as Map<String, dynamic>))
          .toList(),
      category: $enumDecode(_$RouteCategoryEnumMap, json['category']),
      availableServices: (json['availableServices'] as List<dynamic>)
          .map((e) => Service.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$RouteDetailImplToJson(_$RouteDetailImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'stops': instance.stops,
      'path': instance.path,
      'category': _$RouteCategoryEnumMap[instance.category]!,
      'availableServices': instance.availableServices,
    };

const _$RouteCategoryEnumMap = {
  RouteCategory.archeology: 'archeology',
  RouteCategory.monuments: 'monuments',
  RouteCategory.tradition: 'tradition',
  RouteCategory.trekking: 'trekking',
  RouteCategory.undefined: 'undefined',
};
