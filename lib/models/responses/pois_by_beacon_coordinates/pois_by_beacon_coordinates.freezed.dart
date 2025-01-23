// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'pois_by_beacon_coordinates.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

PoisByBeaconCoordinates _$PoisByBeaconCoordinatesFromJson(
    Map<String, dynamic> json) {
  return _PoisByBeaconCoordinates.fromJson(json);
}

/// @nodoc
mixin _$PoisByBeaconCoordinates {
  @JsonKey(name: 'items')
  List<PoiDetail> get items => throw _privateConstructorUsedError;
  @JsonKey(name: 'pageNumber')
  int get pageNumber => throw _privateConstructorUsedError;
  @JsonKey(name: 'pageSize')
  int get pageSize => throw _privateConstructorUsedError;
  @JsonKey(name: 'totalPages')
  int get totalPages => throw _privateConstructorUsedError;
  @JsonKey(name: 'totalCount')
  int get totalCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'hasPreviousPage')
  bool get hasPreviousPage => throw _privateConstructorUsedError;
  @JsonKey(name: 'hasNextPage')
  bool get hasNextPage => throw _privateConstructorUsedError;

  /// Serializes this PoisByBeaconCoordinates to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PoisByBeaconCoordinates
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PoisByBeaconCoordinatesCopyWith<PoisByBeaconCoordinates> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PoisByBeaconCoordinatesCopyWith<$Res> {
  factory $PoisByBeaconCoordinatesCopyWith(PoisByBeaconCoordinates value,
          $Res Function(PoisByBeaconCoordinates) then) =
      _$PoisByBeaconCoordinatesCopyWithImpl<$Res, PoisByBeaconCoordinates>;
  @useResult
  $Res call(
      {@JsonKey(name: 'items') List<PoiDetail> items,
      @JsonKey(name: 'pageNumber') int pageNumber,
      @JsonKey(name: 'pageSize') int pageSize,
      @JsonKey(name: 'totalPages') int totalPages,
      @JsonKey(name: 'totalCount') int totalCount,
      @JsonKey(name: 'hasPreviousPage') bool hasPreviousPage,
      @JsonKey(name: 'hasNextPage') bool hasNextPage});
}

/// @nodoc
class _$PoisByBeaconCoordinatesCopyWithImpl<$Res,
        $Val extends PoisByBeaconCoordinates>
    implements $PoisByBeaconCoordinatesCopyWith<$Res> {
  _$PoisByBeaconCoordinatesCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PoisByBeaconCoordinates
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? items = null,
    Object? pageNumber = null,
    Object? pageSize = null,
    Object? totalPages = null,
    Object? totalCount = null,
    Object? hasPreviousPage = null,
    Object? hasNextPage = null,
  }) {
    return _then(_value.copyWith(
      items: null == items
          ? _value.items
          : items // ignore: cast_nullable_to_non_nullable
              as List<PoiDetail>,
      pageNumber: null == pageNumber
          ? _value.pageNumber
          : pageNumber // ignore: cast_nullable_to_non_nullable
              as int,
      pageSize: null == pageSize
          ? _value.pageSize
          : pageSize // ignore: cast_nullable_to_non_nullable
              as int,
      totalPages: null == totalPages
          ? _value.totalPages
          : totalPages // ignore: cast_nullable_to_non_nullable
              as int,
      totalCount: null == totalCount
          ? _value.totalCount
          : totalCount // ignore: cast_nullable_to_non_nullable
              as int,
      hasPreviousPage: null == hasPreviousPage
          ? _value.hasPreviousPage
          : hasPreviousPage // ignore: cast_nullable_to_non_nullable
              as bool,
      hasNextPage: null == hasNextPage
          ? _value.hasNextPage
          : hasNextPage // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PoisByBeaconCoordinatesImplCopyWith<$Res>
    implements $PoisByBeaconCoordinatesCopyWith<$Res> {
  factory _$$PoisByBeaconCoordinatesImplCopyWith(
          _$PoisByBeaconCoordinatesImpl value,
          $Res Function(_$PoisByBeaconCoordinatesImpl) then) =
      __$$PoisByBeaconCoordinatesImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'items') List<PoiDetail> items,
      @JsonKey(name: 'pageNumber') int pageNumber,
      @JsonKey(name: 'pageSize') int pageSize,
      @JsonKey(name: 'totalPages') int totalPages,
      @JsonKey(name: 'totalCount') int totalCount,
      @JsonKey(name: 'hasPreviousPage') bool hasPreviousPage,
      @JsonKey(name: 'hasNextPage') bool hasNextPage});
}

/// @nodoc
class __$$PoisByBeaconCoordinatesImplCopyWithImpl<$Res>
    extends _$PoisByBeaconCoordinatesCopyWithImpl<$Res,
        _$PoisByBeaconCoordinatesImpl>
    implements _$$PoisByBeaconCoordinatesImplCopyWith<$Res> {
  __$$PoisByBeaconCoordinatesImplCopyWithImpl(
      _$PoisByBeaconCoordinatesImpl _value,
      $Res Function(_$PoisByBeaconCoordinatesImpl) _then)
      : super(_value, _then);

  /// Create a copy of PoisByBeaconCoordinates
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? items = null,
    Object? pageNumber = null,
    Object? pageSize = null,
    Object? totalPages = null,
    Object? totalCount = null,
    Object? hasPreviousPage = null,
    Object? hasNextPage = null,
  }) {
    return _then(_$PoisByBeaconCoordinatesImpl(
      items: null == items
          ? _value._items
          : items // ignore: cast_nullable_to_non_nullable
              as List<PoiDetail>,
      pageNumber: null == pageNumber
          ? _value.pageNumber
          : pageNumber // ignore: cast_nullable_to_non_nullable
              as int,
      pageSize: null == pageSize
          ? _value.pageSize
          : pageSize // ignore: cast_nullable_to_non_nullable
              as int,
      totalPages: null == totalPages
          ? _value.totalPages
          : totalPages // ignore: cast_nullable_to_non_nullable
              as int,
      totalCount: null == totalCount
          ? _value.totalCount
          : totalCount // ignore: cast_nullable_to_non_nullable
              as int,
      hasPreviousPage: null == hasPreviousPage
          ? _value.hasPreviousPage
          : hasPreviousPage // ignore: cast_nullable_to_non_nullable
              as bool,
      hasNextPage: null == hasNextPage
          ? _value.hasNextPage
          : hasNextPage // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PoisByBeaconCoordinatesImpl implements _PoisByBeaconCoordinates {
  const _$PoisByBeaconCoordinatesImpl(
      {@JsonKey(name: 'items') required final List<PoiDetail> items,
      @JsonKey(name: 'pageNumber') required this.pageNumber,
      @JsonKey(name: 'pageSize') required this.pageSize,
      @JsonKey(name: 'totalPages') required this.totalPages,
      @JsonKey(name: 'totalCount') required this.totalCount,
      @JsonKey(name: 'hasPreviousPage') required this.hasPreviousPage,
      @JsonKey(name: 'hasNextPage') required this.hasNextPage})
      : _items = items;

  factory _$PoisByBeaconCoordinatesImpl.fromJson(Map<String, dynamic> json) =>
      _$$PoisByBeaconCoordinatesImplFromJson(json);

  final List<PoiDetail> _items;
  @override
  @JsonKey(name: 'items')
  List<PoiDetail> get items {
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_items);
  }

  @override
  @JsonKey(name: 'pageNumber')
  final int pageNumber;
  @override
  @JsonKey(name: 'pageSize')
  final int pageSize;
  @override
  @JsonKey(name: 'totalPages')
  final int totalPages;
  @override
  @JsonKey(name: 'totalCount')
  final int totalCount;
  @override
  @JsonKey(name: 'hasPreviousPage')
  final bool hasPreviousPage;
  @override
  @JsonKey(name: 'hasNextPage')
  final bool hasNextPage;

  @override
  String toString() {
    return 'PoisByBeaconCoordinates(items: $items, pageNumber: $pageNumber, pageSize: $pageSize, totalPages: $totalPages, totalCount: $totalCount, hasPreviousPage: $hasPreviousPage, hasNextPage: $hasNextPage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PoisByBeaconCoordinatesImpl &&
            const DeepCollectionEquality().equals(other._items, _items) &&
            (identical(other.pageNumber, pageNumber) ||
                other.pageNumber == pageNumber) &&
            (identical(other.pageSize, pageSize) ||
                other.pageSize == pageSize) &&
            (identical(other.totalPages, totalPages) ||
                other.totalPages == totalPages) &&
            (identical(other.totalCount, totalCount) ||
                other.totalCount == totalCount) &&
            (identical(other.hasPreviousPage, hasPreviousPage) ||
                other.hasPreviousPage == hasPreviousPage) &&
            (identical(other.hasNextPage, hasNextPage) ||
                other.hasNextPage == hasNextPage));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_items),
      pageNumber,
      pageSize,
      totalPages,
      totalCount,
      hasPreviousPage,
      hasNextPage);

  /// Create a copy of PoisByBeaconCoordinates
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PoisByBeaconCoordinatesImplCopyWith<_$PoisByBeaconCoordinatesImpl>
      get copyWith => __$$PoisByBeaconCoordinatesImplCopyWithImpl<
          _$PoisByBeaconCoordinatesImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PoisByBeaconCoordinatesImplToJson(
      this,
    );
  }
}

abstract class _PoisByBeaconCoordinates implements PoisByBeaconCoordinates {
  const factory _PoisByBeaconCoordinates(
          {@JsonKey(name: 'items') required final List<PoiDetail> items,
          @JsonKey(name: 'pageNumber') required final int pageNumber,
          @JsonKey(name: 'pageSize') required final int pageSize,
          @JsonKey(name: 'totalPages') required final int totalPages,
          @JsonKey(name: 'totalCount') required final int totalCount,
          @JsonKey(name: 'hasPreviousPage') required final bool hasPreviousPage,
          @JsonKey(name: 'hasNextPage') required final bool hasNextPage}) =
      _$PoisByBeaconCoordinatesImpl;

  factory _PoisByBeaconCoordinates.fromJson(Map<String, dynamic> json) =
      _$PoisByBeaconCoordinatesImpl.fromJson;

  @override
  @JsonKey(name: 'items')
  List<PoiDetail> get items;
  @override
  @JsonKey(name: 'pageNumber')
  int get pageNumber;
  @override
  @JsonKey(name: 'pageSize')
  int get pageSize;
  @override
  @JsonKey(name: 'totalPages')
  int get totalPages;
  @override
  @JsonKey(name: 'totalCount')
  int get totalCount;
  @override
  @JsonKey(name: 'hasPreviousPage')
  bool get hasPreviousPage;
  @override
  @JsonKey(name: 'hasNextPage')
  bool get hasNextPage;

  /// Create a copy of PoisByBeaconCoordinates
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PoisByBeaconCoordinatesImplCopyWith<_$PoisByBeaconCoordinatesImpl>
      get copyWith => throw _privateConstructorUsedError;
}
