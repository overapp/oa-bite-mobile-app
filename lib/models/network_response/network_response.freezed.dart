// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'network_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$NetworkResponse {
  String? get message => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(dynamic data, String status, String? message)
        onSuccess,
    required TResult Function(String status, String message) onError,
    required TResult Function(String message) loading,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(dynamic data, String status, String? message)? onSuccess,
    TResult? Function(String status, String message)? onError,
    TResult? Function(String message)? loading,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(dynamic data, String status, String? message)? onSuccess,
    TResult Function(String status, String message)? onError,
    TResult Function(String message)? loading,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Ok value) onSuccess,
    required TResult Function(ERROR value) onError,
    required TResult Function(LOADING value) loading,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Ok value)? onSuccess,
    TResult? Function(ERROR value)? onError,
    TResult? Function(LOADING value)? loading,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Ok value)? onSuccess,
    TResult Function(ERROR value)? onError,
    TResult Function(LOADING value)? loading,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  /// Create a copy of NetworkResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $NetworkResponseCopyWith<NetworkResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NetworkResponseCopyWith<$Res> {
  factory $NetworkResponseCopyWith(
          NetworkResponse value, $Res Function(NetworkResponse) then) =
      _$NetworkResponseCopyWithImpl<$Res, NetworkResponse>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class _$NetworkResponseCopyWithImpl<$Res, $Val extends NetworkResponse>
    implements $NetworkResponseCopyWith<$Res> {
  _$NetworkResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of NetworkResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
  }) {
    return _then(_value.copyWith(
      message: null == message
          ? _value.message!
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$OkImplCopyWith<$Res>
    implements $NetworkResponseCopyWith<$Res> {
  factory _$$OkImplCopyWith(_$OkImpl value, $Res Function(_$OkImpl) then) =
      __$$OkImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({dynamic data, String status, String? message});
}

/// @nodoc
class __$$OkImplCopyWithImpl<$Res>
    extends _$NetworkResponseCopyWithImpl<$Res, _$OkImpl>
    implements _$$OkImplCopyWith<$Res> {
  __$$OkImplCopyWithImpl(_$OkImpl _value, $Res Function(_$OkImpl) _then)
      : super(_value, _then);

  /// Create a copy of NetworkResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = freezed,
    Object? status = null,
    Object? message = freezed,
  }) {
    return _then(_$OkImpl(
      freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as dynamic,
      null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$OkImpl implements Ok {
  const _$OkImpl(this.data, this.status, this.message);

  @override
  final dynamic data;
  @override
  final String status;
  @override
  final String? message;

  @override
  String toString() {
    return 'NetworkResponse.onSuccess(data: $data, status: $status, message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OkImpl &&
            const DeepCollectionEquality().equals(other.data, data) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(data), status, message);

  /// Create a copy of NetworkResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OkImplCopyWith<_$OkImpl> get copyWith =>
      __$$OkImplCopyWithImpl<_$OkImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(dynamic data, String status, String? message)
        onSuccess,
    required TResult Function(String status, String message) onError,
    required TResult Function(String message) loading,
  }) {
    return onSuccess(data, status, message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(dynamic data, String status, String? message)? onSuccess,
    TResult? Function(String status, String message)? onError,
    TResult? Function(String message)? loading,
  }) {
    return onSuccess?.call(data, status, message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(dynamic data, String status, String? message)? onSuccess,
    TResult Function(String status, String message)? onError,
    TResult Function(String message)? loading,
    required TResult orElse(),
  }) {
    if (onSuccess != null) {
      return onSuccess(data, status, message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Ok value) onSuccess,
    required TResult Function(ERROR value) onError,
    required TResult Function(LOADING value) loading,
  }) {
    return onSuccess(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Ok value)? onSuccess,
    TResult? Function(ERROR value)? onError,
    TResult? Function(LOADING value)? loading,
  }) {
    return onSuccess?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Ok value)? onSuccess,
    TResult Function(ERROR value)? onError,
    TResult Function(LOADING value)? loading,
    required TResult orElse(),
  }) {
    if (onSuccess != null) {
      return onSuccess(this);
    }
    return orElse();
  }
}

abstract class Ok implements NetworkResponse {
  const factory Ok(
          final dynamic data, final String status, final String? message) =
      _$OkImpl;

  dynamic get data;
  String get status;
  @override
  String? get message;

  /// Create a copy of NetworkResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OkImplCopyWith<_$OkImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ERRORImplCopyWith<$Res>
    implements $NetworkResponseCopyWith<$Res> {
  factory _$$ERRORImplCopyWith(
          _$ERRORImpl value, $Res Function(_$ERRORImpl) then) =
      __$$ERRORImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String status, String message});
}

/// @nodoc
class __$$ERRORImplCopyWithImpl<$Res>
    extends _$NetworkResponseCopyWithImpl<$Res, _$ERRORImpl>
    implements _$$ERRORImplCopyWith<$Res> {
  __$$ERRORImplCopyWithImpl(
      _$ERRORImpl _value, $Res Function(_$ERRORImpl) _then)
      : super(_value, _then);

  /// Create a copy of NetworkResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? message = null,
  }) {
    return _then(_$ERRORImpl(
      null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$ERRORImpl implements ERROR {
  const _$ERRORImpl(this.status, this.message);

  @override
  final String status;
  @override
  final String message;

  @override
  String toString() {
    return 'NetworkResponse.onError(status: $status, message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ERRORImpl &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, status, message);

  /// Create a copy of NetworkResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ERRORImplCopyWith<_$ERRORImpl> get copyWith =>
      __$$ERRORImplCopyWithImpl<_$ERRORImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(dynamic data, String status, String? message)
        onSuccess,
    required TResult Function(String status, String message) onError,
    required TResult Function(String message) loading,
  }) {
    return onError(status, message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(dynamic data, String status, String? message)? onSuccess,
    TResult? Function(String status, String message)? onError,
    TResult? Function(String message)? loading,
  }) {
    return onError?.call(status, message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(dynamic data, String status, String? message)? onSuccess,
    TResult Function(String status, String message)? onError,
    TResult Function(String message)? loading,
    required TResult orElse(),
  }) {
    if (onError != null) {
      return onError(status, message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Ok value) onSuccess,
    required TResult Function(ERROR value) onError,
    required TResult Function(LOADING value) loading,
  }) {
    return onError(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Ok value)? onSuccess,
    TResult? Function(ERROR value)? onError,
    TResult? Function(LOADING value)? loading,
  }) {
    return onError?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Ok value)? onSuccess,
    TResult Function(ERROR value)? onError,
    TResult Function(LOADING value)? loading,
    required TResult orElse(),
  }) {
    if (onError != null) {
      return onError(this);
    }
    return orElse();
  }
}

abstract class ERROR implements NetworkResponse {
  const factory ERROR(final String status, final String message) = _$ERRORImpl;

  String get status;
  @override
  String get message;

  /// Create a copy of NetworkResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ERRORImplCopyWith<_$ERRORImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$LOADINGImplCopyWith<$Res>
    implements $NetworkResponseCopyWith<$Res> {
  factory _$$LOADINGImplCopyWith(
          _$LOADINGImpl value, $Res Function(_$LOADINGImpl) then) =
      __$$LOADINGImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$LOADINGImplCopyWithImpl<$Res>
    extends _$NetworkResponseCopyWithImpl<$Res, _$LOADINGImpl>
    implements _$$LOADINGImplCopyWith<$Res> {
  __$$LOADINGImplCopyWithImpl(
      _$LOADINGImpl _value, $Res Function(_$LOADINGImpl) _then)
      : super(_value, _then);

  /// Create a copy of NetworkResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
  }) {
    return _then(_$LOADINGImpl(
      null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$LOADINGImpl implements LOADING {
  const _$LOADINGImpl(this.message);

  @override
  final String message;

  @override
  String toString() {
    return 'NetworkResponse.loading(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LOADINGImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of NetworkResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LOADINGImplCopyWith<_$LOADINGImpl> get copyWith =>
      __$$LOADINGImplCopyWithImpl<_$LOADINGImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(dynamic data, String status, String? message)
        onSuccess,
    required TResult Function(String status, String message) onError,
    required TResult Function(String message) loading,
  }) {
    return loading(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(dynamic data, String status, String? message)? onSuccess,
    TResult? Function(String status, String message)? onError,
    TResult? Function(String message)? loading,
  }) {
    return loading?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(dynamic data, String status, String? message)? onSuccess,
    TResult Function(String status, String message)? onError,
    TResult Function(String message)? loading,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Ok value) onSuccess,
    required TResult Function(ERROR value) onError,
    required TResult Function(LOADING value) loading,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Ok value)? onSuccess,
    TResult? Function(ERROR value)? onError,
    TResult? Function(LOADING value)? loading,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Ok value)? onSuccess,
    TResult Function(ERROR value)? onError,
    TResult Function(LOADING value)? loading,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class LOADING implements NetworkResponse {
  const factory LOADING(final String message) = _$LOADINGImpl;

  @override
  String get message;

  /// Create a copy of NetworkResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LOADINGImplCopyWith<_$LOADINGImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
