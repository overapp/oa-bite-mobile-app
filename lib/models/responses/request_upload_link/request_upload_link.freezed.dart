// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'request_upload_link.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

RequestUploadLink _$RequesUploadLinkFromJson(Map<String, dynamic> json) {
  return _RequesUploadLink.fromJson(json);
}

/// @nodoc
mixin _$RequesUploadLink {
  @JsonKey(name: 'url')
  String? get url => throw _privateConstructorUsedError;
  @JsonKey(name: 'relatedEntityId')
  String? get relatedEntityId => throw _privateConstructorUsedError;

  /// Serializes this RequesUploadLink to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of RequesUploadLink
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RequesUploadLinkCopyWith<RequestUploadLink> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RequesUploadLinkCopyWith<$Res> {
  factory $RequesUploadLinkCopyWith(
          RequestUploadLink value, $Res Function(RequestUploadLink) then) =
      _$RequesUploadLinkCopyWithImpl<$Res, RequestUploadLink>;
  @useResult
  $Res call(
      {@JsonKey(name: 'url') String? url,
      @JsonKey(name: 'relatedEntityId') String? relatedEntityId});
}

/// @nodoc
class _$RequesUploadLinkCopyWithImpl<$Res, $Val extends RequestUploadLink>
    implements $RequesUploadLinkCopyWith<$Res> {
  _$RequesUploadLinkCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RequesUploadLink
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? url = freezed,
    Object? relatedEntityId = freezed,
  }) {
    return _then(_value.copyWith(
      url: freezed == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String?,
      relatedEntityId: freezed == relatedEntityId
          ? _value.relatedEntityId
          : relatedEntityId // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RequesUploadLinkImplCopyWith<$Res>
    implements $RequesUploadLinkCopyWith<$Res> {
  factory _$$RequesUploadLinkImplCopyWith(_$RequesUploadLinkImpl value,
          $Res Function(_$RequesUploadLinkImpl) then) =
      __$$RequesUploadLinkImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'url') String? url,
      @JsonKey(name: 'relatedEntityId') String? relatedEntityId});
}

/// @nodoc
class __$$RequesUploadLinkImplCopyWithImpl<$Res>
    extends _$RequesUploadLinkCopyWithImpl<$Res, _$RequesUploadLinkImpl>
    implements _$$RequesUploadLinkImplCopyWith<$Res> {
  __$$RequesUploadLinkImplCopyWithImpl(_$RequesUploadLinkImpl _value,
      $Res Function(_$RequesUploadLinkImpl) _then)
      : super(_value, _then);

  /// Create a copy of RequesUploadLink
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? url = freezed,
    Object? relatedEntityId = freezed,
  }) {
    return _then(_$RequesUploadLinkImpl(
      url: freezed == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String?,
      relatedEntityId: freezed == relatedEntityId
          ? _value.relatedEntityId
          : relatedEntityId // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$RequesUploadLinkImpl implements _RequesUploadLink {
  const _$RequesUploadLinkImpl(
      {@JsonKey(name: 'url') this.url,
      @JsonKey(name: 'relatedEntityId') this.relatedEntityId});

  factory _$RequesUploadLinkImpl.fromJson(Map<String, dynamic> json) =>
      _$$RequesUploadLinkImplFromJson(json);

  @override
  @JsonKey(name: 'url')
  final String? url;
  @override
  @JsonKey(name: 'relatedEntityId')
  final String? relatedEntityId;

  @override
  String toString() {
    return 'RequesUploadLink(url: $url, relatedEntityId: $relatedEntityId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RequesUploadLinkImpl &&
            (identical(other.url, url) || other.url == url) &&
            (identical(other.relatedEntityId, relatedEntityId) ||
                other.relatedEntityId == relatedEntityId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, url, relatedEntityId);

  /// Create a copy of RequesUploadLink
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RequesUploadLinkImplCopyWith<_$RequesUploadLinkImpl> get copyWith =>
      __$$RequesUploadLinkImplCopyWithImpl<_$RequesUploadLinkImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RequesUploadLinkImplToJson(
      this,
    );
  }
}

abstract class _RequesUploadLink implements RequestUploadLink {
  const factory _RequesUploadLink(
          {@JsonKey(name: 'url') final String? url,
          @JsonKey(name: 'relatedEntityId') final String? relatedEntityId}) =
      _$RequesUploadLinkImpl;

  factory _RequesUploadLink.fromJson(Map<String, dynamic> json) =
      _$RequesUploadLinkImpl.fromJson;

  @override
  @JsonKey(name: 'url')
  String? get url;
  @override
  @JsonKey(name: 'relatedEntityId')
  String? get relatedEntityId;

  /// Create a copy of RequesUploadLink
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RequesUploadLinkImplCopyWith<_$RequesUploadLinkImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
