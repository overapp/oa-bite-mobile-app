// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_routes.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$GetRoutesImpl _$$GetRoutesImplFromJson(Map<String, dynamic> json) =>
    _$GetRoutesImpl(
      items: (json['items'] as List<dynamic>)
          .map((e) => RouteDetail.fromJson(e as Map<String, dynamic>))
          .toList(),
      pageNumber: (json['pageNumber'] as num).toInt(),
      pageSize: (json['pageSize'] as num).toInt(),
      totalPages: (json['totalPages'] as num).toInt(),
      totalCount: (json['totalCount'] as num).toInt(),
      hasPreviousPage: json['hasPreviousPage'] as bool,
      hasNextPage: json['hasNextPage'] as bool,
    );

Map<String, dynamic> _$$GetRoutesImplToJson(_$GetRoutesImpl instance) =>
    <String, dynamic>{
      'items': instance.items,
      'pageNumber': instance.pageNumber,
      'pageSize': instance.pageSize,
      'totalPages': instance.totalPages,
      'totalCount': instance.totalCount,
      'hasPreviousPage': instance.hasPreviousPage,
      'hasNextPage': instance.hasNextPage,
    };
