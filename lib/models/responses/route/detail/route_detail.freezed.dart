// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'route_detail.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

RouteDetail _$RouteDetailFromJson(Map<String, dynamic> json) {
  return _RouteDetail.fromJson(json);
}

/// @nodoc
mixin _$RouteDetail {
  @JsonKey(name: 'id')
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'name')
  String get name => throw _privateConstructorUsedError;
  @JsonKey(name: 'description')
  String? get description => throw _privateConstructorUsedError;
  @JsonKey(name: 'stops')
  List<PoiInfo>? get stops => throw _privateConstructorUsedError;
  @JsonKey(name: 'path')
  List<Location>? get path => throw _privateConstructorUsedError;
  @JsonKey(name: 'category')
  RouteCategory get category => throw _privateConstructorUsedError;
  @JsonKey(name: 'availableServices')
  List<Service> get availableServices => throw _privateConstructorUsedError;

  /// Serializes this RouteDetail to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of RouteDetail
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RouteDetailCopyWith<RouteDetail> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RouteDetailCopyWith<$Res> {
  factory $RouteDetailCopyWith(
          RouteDetail value, $Res Function(RouteDetail) then) =
      _$RouteDetailCopyWithImpl<$Res, RouteDetail>;
  @useResult
  $Res call(
      {@JsonKey(name: 'id') String id,
      @JsonKey(name: 'name') String name,
      @JsonKey(name: 'description') String? description,
      @JsonKey(name: 'stops') List<PoiInfo>? stops,
      @JsonKey(name: 'path') List<Location>? path,
      @JsonKey(name: 'category') RouteCategory category,
      @JsonKey(name: 'availableServices') List<Service> availableServices});
}

/// @nodoc
class _$RouteDetailCopyWithImpl<$Res, $Val extends RouteDetail>
    implements $RouteDetailCopyWith<$Res> {
  _$RouteDetailCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RouteDetail
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = freezed,
    Object? stops = freezed,
    Object? path = freezed,
    Object? category = null,
    Object? availableServices = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      stops: freezed == stops
          ? _value.stops
          : stops // ignore: cast_nullable_to_non_nullable
              as List<PoiInfo>?,
      path: freezed == path
          ? _value.path
          : path // ignore: cast_nullable_to_non_nullable
              as List<Location>?,
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as RouteCategory,
      availableServices: null == availableServices
          ? _value.availableServices
          : availableServices // ignore: cast_nullable_to_non_nullable
              as List<Service>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RouteDetailImplCopyWith<$Res>
    implements $RouteDetailCopyWith<$Res> {
  factory _$$RouteDetailImplCopyWith(
          _$RouteDetailImpl value, $Res Function(_$RouteDetailImpl) then) =
      __$$RouteDetailImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'id') String id,
      @JsonKey(name: 'name') String name,
      @JsonKey(name: 'description') String? description,
      @JsonKey(name: 'stops') List<PoiInfo>? stops,
      @JsonKey(name: 'path') List<Location>? path,
      @JsonKey(name: 'category') RouteCategory category,
      @JsonKey(name: 'availableServices') List<Service> availableServices});
}

/// @nodoc
class __$$RouteDetailImplCopyWithImpl<$Res>
    extends _$RouteDetailCopyWithImpl<$Res, _$RouteDetailImpl>
    implements _$$RouteDetailImplCopyWith<$Res> {
  __$$RouteDetailImplCopyWithImpl(
      _$RouteDetailImpl _value, $Res Function(_$RouteDetailImpl) _then)
      : super(_value, _then);

  /// Create a copy of RouteDetail
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = freezed,
    Object? stops = freezed,
    Object? path = freezed,
    Object? category = null,
    Object? availableServices = null,
  }) {
    return _then(_$RouteDetailImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      stops: freezed == stops
          ? _value._stops
          : stops // ignore: cast_nullable_to_non_nullable
              as List<PoiInfo>?,
      path: freezed == path
          ? _value._path
          : path // ignore: cast_nullable_to_non_nullable
              as List<Location>?,
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as RouteCategory,
      availableServices: null == availableServices
          ? _value._availableServices
          : availableServices // ignore: cast_nullable_to_non_nullable
              as List<Service>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$RouteDetailImpl implements _RouteDetail {
  const _$RouteDetailImpl(
      {@JsonKey(name: 'id') required this.id,
      @JsonKey(name: 'name') required this.name,
      @JsonKey(name: 'description') this.description,
      @JsonKey(name: 'stops') final List<PoiInfo>? stops,
      @JsonKey(name: 'path') final List<Location>? path,
      @JsonKey(name: 'category') required this.category,
      @JsonKey(name: 'availableServices')
      required final List<Service> availableServices})
      : _stops = stops,
        _path = path,
        _availableServices = availableServices;

  factory _$RouteDetailImpl.fromJson(Map<String, dynamic> json) =>
      _$$RouteDetailImplFromJson(json);

  @override
  @JsonKey(name: 'id')
  final String id;
  @override
  @JsonKey(name: 'name')
  final String name;
  @override
  @JsonKey(name: 'description')
  final String? description;
  final List<PoiInfo>? _stops;
  @override
  @JsonKey(name: 'stops')
  List<PoiInfo>? get stops {
    final value = _stops;
    if (value == null) return null;
    if (_stops is EqualUnmodifiableListView) return _stops;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<Location>? _path;
  @override
  @JsonKey(name: 'path')
  List<Location>? get path {
    final value = _path;
    if (value == null) return null;
    if (_path is EqualUnmodifiableListView) return _path;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  @JsonKey(name: 'category')
  final RouteCategory category;
  final List<Service> _availableServices;
  @override
  @JsonKey(name: 'availableServices')
  List<Service> get availableServices {
    if (_availableServices is EqualUnmodifiableListView)
      return _availableServices;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_availableServices);
  }

  @override
  String toString() {
    return 'RouteDetail(id: $id, name: $name, description: $description, stops: $stops, path: $path, category: $category, availableServices: $availableServices)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RouteDetailImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            const DeepCollectionEquality().equals(other._stops, _stops) &&
            const DeepCollectionEquality().equals(other._path, _path) &&
            (identical(other.category, category) ||
                other.category == category) &&
            const DeepCollectionEquality()
                .equals(other._availableServices, _availableServices));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      description,
      const DeepCollectionEquality().hash(_stops),
      const DeepCollectionEquality().hash(_path),
      category,
      const DeepCollectionEquality().hash(_availableServices));

  /// Create a copy of RouteDetail
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RouteDetailImplCopyWith<_$RouteDetailImpl> get copyWith =>
      __$$RouteDetailImplCopyWithImpl<_$RouteDetailImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RouteDetailImplToJson(
      this,
    );
  }
}

abstract class _RouteDetail implements RouteDetail {
  const factory _RouteDetail(
      {@JsonKey(name: 'id') required final String id,
      @JsonKey(name: 'name') required final String name,
      @JsonKey(name: 'description') final String? description,
      @JsonKey(name: 'stops') final List<PoiInfo>? stops,
      @JsonKey(name: 'path') final List<Location>? path,
      @JsonKey(name: 'category') required final RouteCategory category,
      @JsonKey(name: 'availableServices')
      required final List<Service> availableServices}) = _$RouteDetailImpl;

  factory _RouteDetail.fromJson(Map<String, dynamic> json) =
      _$RouteDetailImpl.fromJson;

  @override
  @JsonKey(name: 'id')
  String get id;
  @override
  @JsonKey(name: 'name')
  String get name;
  @override
  @JsonKey(name: 'description')
  String? get description;
  @override
  @JsonKey(name: 'stops')
  List<PoiInfo>? get stops;
  @override
  @JsonKey(name: 'path')
  List<Location>? get path;
  @override
  @JsonKey(name: 'category')
  RouteCategory get category;
  @override
  @JsonKey(name: 'availableServices')
  List<Service> get availableServices;

  /// Create a copy of RouteDetail
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RouteDetailImplCopyWith<_$RouteDetailImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
