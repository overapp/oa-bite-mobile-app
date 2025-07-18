// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sensors_reading.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

SensorsReading _$SensorsReadingFromJson(Map<String, dynamic> json) {
  return _SensorsReading.fromJson(json);
}

/// @nodoc
mixin _$SensorsReading {
  @JsonKey(name: 'poiId')
  String get poiId => throw _privateConstructorUsedError;
  @JsonKey(name: 'firstRegistration')
  String? get firstRegistration => throw _privateConstructorUsedError;
  @JsonKey(name: 'lastRegistration')
  String? get lastRegistration => throw _privateConstructorUsedError;
  @JsonKey(name: 'value')
  int? get value => throw _privateConstructorUsedError;

  /// Serializes this SensorsReading to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SensorsReading
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SensorsReadingCopyWith<SensorsReading> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SensorsReadingCopyWith<$Res> {
  factory $SensorsReadingCopyWith(
          SensorsReading value, $Res Function(SensorsReading) then) =
      _$SensorsReadingCopyWithImpl<$Res, SensorsReading>;
  @useResult
  $Res call(
      {@JsonKey(name: 'poiId') String poiId,
      @JsonKey(name: 'firstRegistration') String? firstRegistration,
      @JsonKey(name: 'lastRegistration') String? lastRegistration,
      @JsonKey(name: 'value') int? value});
}

/// @nodoc
class _$SensorsReadingCopyWithImpl<$Res, $Val extends SensorsReading>
    implements $SensorsReadingCopyWith<$Res> {
  _$SensorsReadingCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SensorsReading
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? poiId = null,
    Object? firstRegistration = freezed,
    Object? lastRegistration = freezed,
    Object? value = freezed,
  }) {
    return _then(_value.copyWith(
      poiId: null == poiId
          ? _value.poiId
          : poiId // ignore: cast_nullable_to_non_nullable
              as String,
      firstRegistration: freezed == firstRegistration
          ? _value.firstRegistration
          : firstRegistration // ignore: cast_nullable_to_non_nullable
              as String?,
      lastRegistration: freezed == lastRegistration
          ? _value.lastRegistration
          : lastRegistration // ignore: cast_nullable_to_non_nullable
              as String?,
      value: freezed == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SensorsReadingImplCopyWith<$Res>
    implements $SensorsReadingCopyWith<$Res> {
  factory _$$SensorsReadingImplCopyWith(_$SensorsReadingImpl value,
          $Res Function(_$SensorsReadingImpl) then) =
      __$$SensorsReadingImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'poiId') String poiId,
      @JsonKey(name: 'firstRegistration') String? firstRegistration,
      @JsonKey(name: 'lastRegistration') String? lastRegistration,
      @JsonKey(name: 'value') int? value});
}

/// @nodoc
class __$$SensorsReadingImplCopyWithImpl<$Res>
    extends _$SensorsReadingCopyWithImpl<$Res, _$SensorsReadingImpl>
    implements _$$SensorsReadingImplCopyWith<$Res> {
  __$$SensorsReadingImplCopyWithImpl(
      _$SensorsReadingImpl _value, $Res Function(_$SensorsReadingImpl) _then)
      : super(_value, _then);

  /// Create a copy of SensorsReading
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? poiId = null,
    Object? firstRegistration = freezed,
    Object? lastRegistration = freezed,
    Object? value = freezed,
  }) {
    return _then(_$SensorsReadingImpl(
      poiId: null == poiId
          ? _value.poiId
          : poiId // ignore: cast_nullable_to_non_nullable
              as String,
      firstRegistration: freezed == firstRegistration
          ? _value.firstRegistration
          : firstRegistration // ignore: cast_nullable_to_non_nullable
              as String?,
      lastRegistration: freezed == lastRegistration
          ? _value.lastRegistration
          : lastRegistration // ignore: cast_nullable_to_non_nullable
              as String?,
      value: freezed == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SensorsReadingImpl implements _SensorsReading {
  const _$SensorsReadingImpl(
      {@JsonKey(name: 'poiId') required this.poiId,
      @JsonKey(name: 'firstRegistration') this.firstRegistration,
      @JsonKey(name: 'lastRegistration') this.lastRegistration,
      @JsonKey(name: 'value') this.value});

  factory _$SensorsReadingImpl.fromJson(Map<String, dynamic> json) =>
      _$$SensorsReadingImplFromJson(json);

  @override
  @JsonKey(name: 'poiId')
  final String poiId;
  @override
  @JsonKey(name: 'firstRegistration')
  final String? firstRegistration;
  @override
  @JsonKey(name: 'lastRegistration')
  final String? lastRegistration;
  @override
  @JsonKey(name: 'value')
  final int? value;

  @override
  String toString() {
    return 'SensorsReading(poiId: $poiId, firstRegistration: $firstRegistration, lastRegistration: $lastRegistration, value: $value)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SensorsReadingImpl &&
            (identical(other.poiId, poiId) || other.poiId == poiId) &&
            (identical(other.firstRegistration, firstRegistration) ||
                other.firstRegistration == firstRegistration) &&
            (identical(other.lastRegistration, lastRegistration) ||
                other.lastRegistration == lastRegistration) &&
            (identical(other.value, value) || other.value == value));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, poiId, firstRegistration, lastRegistration, value);

  /// Create a copy of SensorsReading
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SensorsReadingImplCopyWith<_$SensorsReadingImpl> get copyWith =>
      __$$SensorsReadingImplCopyWithImpl<_$SensorsReadingImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SensorsReadingImplToJson(
      this,
    );
  }
}

abstract class _SensorsReading implements SensorsReading {
  const factory _SensorsReading(
      {@JsonKey(name: 'poiId') required final String poiId,
      @JsonKey(name: 'firstRegistration') final String? firstRegistration,
      @JsonKey(name: 'lastRegistration') final String? lastRegistration,
      @JsonKey(name: 'value') final int? value}) = _$SensorsReadingImpl;

  factory _SensorsReading.fromJson(Map<String, dynamic> json) =
      _$SensorsReadingImpl.fromJson;

  @override
  @JsonKey(name: 'poiId')
  String get poiId;
  @override
  @JsonKey(name: 'firstRegistration')
  String? get firstRegistration;
  @override
  @JsonKey(name: 'lastRegistration')
  String? get lastRegistration;
  @override
  @JsonKey(name: 'value')
  int? get value;

  /// Create a copy of SensorsReading
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SensorsReadingImplCopyWith<_$SensorsReadingImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
