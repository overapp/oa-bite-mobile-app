// ignore_for_file: invalid_annotation_target

import 'package:bite/models/responses/location/location.dart';
import 'package:bite/models/responses/route/poi_info/poi_info.dart';
import 'package:bite/models/responses/route/service/service.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'route_detail.freezed.dart';
part 'route_detail.g.dart';

enum RouteCategory {
  @JsonValue('archeology') archeology,
  @JsonValue('monuments') monuments,
  @JsonValue('tradition') tradition,
  @JsonValue('trekking') trekking,
  @JsonValue('undefined') undefined,
}


@freezed
class RouteDetail with _$RouteDetail {
  const factory RouteDetail({
    @JsonKey(name: 'id') required String id,
    @JsonKey(name: 'name') required String name,
    @JsonKey(name: 'description') String? description,
    @JsonKey(name: 'stops') List<PoiInfo>? stops,
    @JsonKey(name: 'path') List<Location>? path,
    @JsonKey(name: 'category') required RouteCategory category,
    @JsonKey(name: 'availableServices')
    required List<Service> availableServices,
  }) = _RouteDetail;

  factory RouteDetail.fromJson(Map<String, dynamic> json) =>
      _$RouteDetailFromJson(json);
}
