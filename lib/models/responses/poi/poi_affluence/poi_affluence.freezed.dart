// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'poi_affluence.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

PoiAffluence _$PoiAffluenceFromJson(Map<String, dynamic> json) {
  return _PoiAffluence.fromJson(json);
}

/// @nodoc
mixin _$PoiAffluence {
  @JsonKey(name: 'value')
  int get value => throw _privateConstructorUsedError;

  /// Serializes this PoiAffluence to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PoiAffluence
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PoiAffluenceCopyWith<PoiAffluence> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PoiAffluenceCopyWith<$Res> {
  factory $PoiAffluenceCopyWith(
          PoiAffluence value, $Res Function(PoiAffluence) then) =
      _$PoiAffluenceCopyWithImpl<$Res, PoiAffluence>;
  @useResult
  $Res call({@JsonKey(name: 'value') int value});
}

/// @nodoc
class _$PoiAffluenceCopyWithImpl<$Res, $Val extends PoiAffluence>
    implements $PoiAffluenceCopyWith<$Res> {
  _$PoiAffluenceCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PoiAffluence
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? value = null,
  }) {
    return _then(_value.copyWith(
      value: null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PoiAffluenceImplCopyWith<$Res>
    implements $PoiAffluenceCopyWith<$Res> {
  factory _$$PoiAffluenceImplCopyWith(
          _$PoiAffluenceImpl value, $Res Function(_$PoiAffluenceImpl) then) =
      __$$PoiAffluenceImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({@JsonKey(name: 'value') int value});
}

/// @nodoc
class __$$PoiAffluenceImplCopyWithImpl<$Res>
    extends _$PoiAffluenceCopyWithImpl<$Res, _$PoiAffluenceImpl>
    implements _$$PoiAffluenceImplCopyWith<$Res> {
  __$$PoiAffluenceImplCopyWithImpl(
      _$PoiAffluenceImpl _value, $Res Function(_$PoiAffluenceImpl) _then)
      : super(_value, _then);

  /// Create a copy of PoiAffluence
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? value = null,
  }) {
    return _then(_$PoiAffluenceImpl(
      value: null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PoiAffluenceImpl implements _PoiAffluence {
  const _$PoiAffluenceImpl({@JsonKey(name: 'value') required this.value});

  factory _$PoiAffluenceImpl.fromJson(Map<String, dynamic> json) =>
      _$$PoiAffluenceImplFromJson(json);

  @override
  @JsonKey(name: 'value')
  final int value;

  @override
  String toString() {
    return 'PoiAffluence(value: $value)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PoiAffluenceImpl &&
            (identical(other.value, value) || other.value == value));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, value);

  /// Create a copy of PoiAffluence
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PoiAffluenceImplCopyWith<_$PoiAffluenceImpl> get copyWith =>
      __$$PoiAffluenceImplCopyWithImpl<_$PoiAffluenceImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PoiAffluenceImplToJson(
      this,
    );
  }
}

abstract class _PoiAffluence implements PoiAffluence {
  const factory _PoiAffluence(
      {@JsonKey(name: 'value') required final int value}) = _$PoiAffluenceImpl;

  factory _PoiAffluence.fromJson(Map<String, dynamic> json) =
      _$PoiAffluenceImpl.fromJson;

  @override
  @JsonKey(name: 'value')
  int get value;

  /// Create a copy of PoiAffluence
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PoiAffluenceImplCopyWith<_$PoiAffluenceImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
