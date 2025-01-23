// ignore_for_file: invalid_annotation_target

import 'package:bite/models/responses/route/detail/route_detail.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'get_routes.freezed.dart';
part 'get_routes.g.dart';

@freezed
class GetRoutes with _$GetRoutes {
  const factory GetRoutes({
    @JsonKey(name: 'items') required List<RouteDetail> items,
    @JsonKey(name: 'pageNumber') required int pageNumber,
    @JsonKey(name: 'pageSize') required int pageSize,
    @JsonKey(name: 'totalPages') required int totalPages,
    @JsonKey(name: 'totalCount') required int totalCount,
    @JsonKey(name: 'hasPreviousPage') required bool hasPreviousPage,
    @JsonKey(name: 'hasNextPage') required bool hasNextPage,
  }) = _GetRoutes;

  factory GetRoutes.fromJson(Map<String, dynamic> json) =>
      _$GetRoutesFromJson(json);
}
