// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'poi_info.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

PoiInfo _$PoiInfoFromJson(Map<String, dynamic> json) {
  return _PoiInfo.fromJson(json);
}

/// @nodoc
mixin _$PoiInfo {
  @JsonKey(name: 'poiId')
  String? get poiId => throw _privateConstructorUsedError;
  @JsonKey(name: 'order')
  int? get order => throw _privateConstructorUsedError;
  @JsonKey(name: 'name')
  String? get name => throw _privateConstructorUsedError;
  @JsonKey(name: 'description')
  String? get description => throw _privateConstructorUsedError;
  @JsonKey(name: 'shortDescription')
  String? get shortDescription => throw _privateConstructorUsedError;
  @JsonKey(name: 'address')
  String? get address => throw _privateConstructorUsedError;

  /// Serializes this PoiInfo to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PoiInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PoiInfoCopyWith<PoiInfo> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PoiInfoCopyWith<$Res> {
  factory $PoiInfoCopyWith(PoiInfo value, $Res Function(PoiInfo) then) =
      _$PoiInfoCopyWithImpl<$Res, PoiInfo>;
  @useResult
  $Res call(
      {@JsonKey(name: 'poiId') String? poiId,
      @JsonKey(name: 'order') int? order,
      @JsonKey(name: 'name') String? name,
      @JsonKey(name: 'description') String? description,
      @JsonKey(name: 'shortDescription') String? shortDescription,
      @JsonKey(name: 'address') String? address});
}

/// @nodoc
class _$PoiInfoCopyWithImpl<$Res, $Val extends PoiInfo>
    implements $PoiInfoCopyWith<$Res> {
  _$PoiInfoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PoiInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? poiId = freezed,
    Object? order = freezed,
    Object? name = freezed,
    Object? description = freezed,
    Object? shortDescription = freezed,
    Object? address = freezed,
  }) {
    return _then(_value.copyWith(
      poiId: freezed == poiId
          ? _value.poiId
          : poiId // ignore: cast_nullable_to_non_nullable
              as String?,
      order: freezed == order
          ? _value.order
          : order // ignore: cast_nullable_to_non_nullable
              as int?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      shortDescription: freezed == shortDescription
          ? _value.shortDescription
          : shortDescription // ignore: cast_nullable_to_non_nullable
              as String?,
      address: freezed == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PoiInfoImplCopyWith<$Res> implements $PoiInfoCopyWith<$Res> {
  factory _$$PoiInfoImplCopyWith(
          _$PoiInfoImpl value, $Res Function(_$PoiInfoImpl) then) =
      __$$PoiInfoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'poiId') String? poiId,
      @JsonKey(name: 'order') int? order,
      @JsonKey(name: 'name') String? name,
      @JsonKey(name: 'description') String? description,
      @JsonKey(name: 'shortDescription') String? shortDescription,
      @JsonKey(name: 'address') String? address});
}

/// @nodoc
class __$$PoiInfoImplCopyWithImpl<$Res>
    extends _$PoiInfoCopyWithImpl<$Res, _$PoiInfoImpl>
    implements _$$PoiInfoImplCopyWith<$Res> {
  __$$PoiInfoImplCopyWithImpl(
      _$PoiInfoImpl _value, $Res Function(_$PoiInfoImpl) _then)
      : super(_value, _then);

  /// Create a copy of PoiInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? poiId = freezed,
    Object? order = freezed,
    Object? name = freezed,
    Object? description = freezed,
    Object? shortDescription = freezed,
    Object? address = freezed,
  }) {
    return _then(_$PoiInfoImpl(
      poiId: freezed == poiId
          ? _value.poiId
          : poiId // ignore: cast_nullable_to_non_nullable
              as String?,
      order: freezed == order
          ? _value.order
          : order // ignore: cast_nullable_to_non_nullable
              as int?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      shortDescription: freezed == shortDescription
          ? _value.shortDescription
          : shortDescription // ignore: cast_nullable_to_non_nullable
              as String?,
      address: freezed == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PoiInfoImpl implements _PoiInfo {
  const _$PoiInfoImpl(
      {@JsonKey(name: 'poiId') this.poiId,
      @JsonKey(name: 'order') this.order,
      @JsonKey(name: 'name') this.name,
      @JsonKey(name: 'description') this.description,
      @JsonKey(name: 'shortDescription') this.shortDescription,
      @JsonKey(name: 'address') this.address});

  factory _$PoiInfoImpl.fromJson(Map<String, dynamic> json) =>
      _$$PoiInfoImplFromJson(json);

  @override
  @JsonKey(name: 'poiId')
  final String? poiId;
  @override
  @JsonKey(name: 'order')
  final int? order;
  @override
  @JsonKey(name: 'name')
  final String? name;
  @override
  @JsonKey(name: 'description')
  final String? description;
  @override
  @JsonKey(name: 'shortDescription')
  final String? shortDescription;
  @override
  @JsonKey(name: 'address')
  final String? address;

  @override
  String toString() {
    return 'PoiInfo(poiId: $poiId, order: $order, name: $name, description: $description, shortDescription: $shortDescription, address: $address)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PoiInfoImpl &&
            (identical(other.poiId, poiId) || other.poiId == poiId) &&
            (identical(other.order, order) || other.order == order) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.shortDescription, shortDescription) ||
                other.shortDescription == shortDescription) &&
            (identical(other.address, address) || other.address == address));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, poiId, order, name, description, shortDescription, address);

  /// Create a copy of PoiInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PoiInfoImplCopyWith<_$PoiInfoImpl> get copyWith =>
      __$$PoiInfoImplCopyWithImpl<_$PoiInfoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PoiInfoImplToJson(
      this,
    );
  }
}

abstract class _PoiInfo implements PoiInfo {
  const factory _PoiInfo(
      {@JsonKey(name: 'poiId') final String? poiId,
      @JsonKey(name: 'order') final int? order,
      @JsonKey(name: 'name') final String? name,
      @JsonKey(name: 'description') final String? description,
      @JsonKey(name: 'shortDescription') final String? shortDescription,
      @JsonKey(name: 'address') final String? address}) = _$PoiInfoImpl;

  factory _PoiInfo.fromJson(Map<String, dynamic> json) = _$PoiInfoImpl.fromJson;

  @override
  @JsonKey(name: 'poiId')
  String? get poiId;
  @override
  @JsonKey(name: 'order')
  int? get order;
  @override
  @JsonKey(name: 'name')
  String? get name;
  @override
  @JsonKey(name: 'description')
  String? get description;
  @override
  @JsonKey(name: 'shortDescription')
  String? get shortDescription;
  @override
  @JsonKey(name: 'address')
  String? get address;

  /// Create a copy of PoiInfo
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PoiInfoImplCopyWith<_$PoiInfoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
