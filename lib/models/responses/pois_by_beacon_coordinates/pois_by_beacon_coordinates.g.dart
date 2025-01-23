// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pois_by_beacon_coordinates.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PoisByBeaconCoordinatesImpl _$$PoisByBeaconCoordinatesImplFromJson(
        Map<String, dynamic> json) =>
    _$PoisByBeaconCoordinatesImpl(
      items: (json['items'] as List<dynamic>)
          .map((e) => PoiDetail.fromJson(e as Map<String, dynamic>))
          .toList(),
      pageNumber: (json['pageNumber'] as num).toInt(),
      pageSize: (json['pageSize'] as num).toInt(),
      totalPages: (json['totalPages'] as num).toInt(),
      totalCount: (json['totalCount'] as num).toInt(),
      hasPreviousPage: json['hasPreviousPage'] as bool,
      hasNextPage: json['hasNextPage'] as bool,
    );

Map<String, dynamic> _$$PoisByBeaconCoordinatesImplToJson(
        _$PoisByBeaconCoordinatesImpl instance) =>
    <String, dynamic>{
      'items': instance.items,
      'pageNumber': instance.pageNumber,
      'pageSize': instance.pageSize,
      'totalPages': instance.totalPages,
      'totalCount': instance.totalCount,
      'hasPreviousPage': instance.hasPreviousPage,
      'hasNextPage': instance.hasNextPage,
    };
