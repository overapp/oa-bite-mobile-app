// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'time_interval.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

TimeInterval _$TimeIntervalFromJson(Map<String, dynamic> json) {
  return _TimeInterval.fromJson(json);
}

/// @nodoc
mixin _$TimeInterval {
  @JsonKey(name: 'from')
  String get from => throw _privateConstructorUsedError;
  @JsonKey(name: 'to')
  String get to => throw _privateConstructorUsedError;

  /// Serializes this TimeInterval to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TimeInterval
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TimeIntervalCopyWith<TimeInterval> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TimeIntervalCopyWith<$Res> {
  factory $TimeIntervalCopyWith(
          TimeInterval value, $Res Function(TimeInterval) then) =
      _$TimeIntervalCopyWithImpl<$Res, TimeInterval>;
  @useResult
  $Res call(
      {@JsonKey(name: 'from') String from, @JsonKey(name: 'to') String to});
}

/// @nodoc
class _$TimeIntervalCopyWithImpl<$Res, $Val extends TimeInterval>
    implements $TimeIntervalCopyWith<$Res> {
  _$TimeIntervalCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TimeInterval
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? from = null,
    Object? to = null,
  }) {
    return _then(_value.copyWith(
      from: null == from
          ? _value.from
          : from // ignore: cast_nullable_to_non_nullable
              as String,
      to: null == to
          ? _value.to
          : to // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TimeIntervalImplCopyWith<$Res>
    implements $TimeIntervalCopyWith<$Res> {
  factory _$$TimeIntervalImplCopyWith(
          _$TimeIntervalImpl value, $Res Function(_$TimeIntervalImpl) then) =
      __$$TimeIntervalImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'from') String from, @JsonKey(name: 'to') String to});
}

/// @nodoc
class __$$TimeIntervalImplCopyWithImpl<$Res>
    extends _$TimeIntervalCopyWithImpl<$Res, _$TimeIntervalImpl>
    implements _$$TimeIntervalImplCopyWith<$Res> {
  __$$TimeIntervalImplCopyWithImpl(
      _$TimeIntervalImpl _value, $Res Function(_$TimeIntervalImpl) _then)
      : super(_value, _then);

  /// Create a copy of TimeInterval
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? from = null,
    Object? to = null,
  }) {
    return _then(_$TimeIntervalImpl(
      from: null == from
          ? _value.from
          : from // ignore: cast_nullable_to_non_nullable
              as String,
      to: null == to
          ? _value.to
          : to // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TimeIntervalImpl implements _TimeInterval {
  const _$TimeIntervalImpl(
      {@JsonKey(name: 'from') required this.from,
      @JsonKey(name: 'to') required this.to});

  factory _$TimeIntervalImpl.fromJson(Map<String, dynamic> json) =>
      _$$TimeIntervalImplFromJson(json);

  @override
  @JsonKey(name: 'from')
  final String from;
  @override
  @JsonKey(name: 'to')
  final String to;

  @override
  String toString() {
    return 'TimeInterval(from: $from, to: $to)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TimeIntervalImpl &&
            (identical(other.from, from) || other.from == from) &&
            (identical(other.to, to) || other.to == to));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, from, to);

  /// Create a copy of TimeInterval
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TimeIntervalImplCopyWith<_$TimeIntervalImpl> get copyWith =>
      __$$TimeIntervalImplCopyWithImpl<_$TimeIntervalImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TimeIntervalImplToJson(
      this,
    );
  }
}

abstract class _TimeInterval implements TimeInterval {
  const factory _TimeInterval(
      {@JsonKey(name: 'from') required final String from,
      @JsonKey(name: 'to') required final String to}) = _$TimeIntervalImpl;

  factory _TimeInterval.fromJson(Map<String, dynamic> json) =
      _$TimeIntervalImpl.fromJson;

  @override
  @JsonKey(name: 'from')
  String get from;
  @override
  @JsonKey(name: 'to')
  String get to;

  /// Create a copy of TimeInterval
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TimeIntervalImplCopyWith<_$TimeIntervalImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
