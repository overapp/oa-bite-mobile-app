// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'poi_detail.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

PoiDetail _$PoiDetailFromJson(Map<String, dynamic> json) {
  return _PoiDetail.fromJson(json);
}

/// @nodoc
mixin _$PoiDetail {
  @JsonKey(name: 'id')
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'name')
  String get name => throw _privateConstructorUsedError;
  @JsonKey(name: 'description')
  String? get description => throw _privateConstructorUsedError;
  @JsonKey(name: 'shortDescription')
  String? get shortDescription => throw _privateConstructorUsedError;
  @JsonKey(name: 'address')
  String? get address => throw _privateConstructorUsedError;
  @JsonKey(name: 'beaconId')
  String get beaconId => throw _privateConstructorUsedError;
  @JsonKey(name: 'media')
  List<String>? get media => throw _privateConstructorUsedError;
  @JsonKey(name: 'openingHours')
  OpeningHours? get openingHours => throw _privateConstructorUsedError;
  @JsonKey(name: 'contacts')
  List<Map<String, dynamic>>? get contacts =>
      throw _privateConstructorUsedError;
  @JsonKey(name: 'createdAt')
  String? get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'createdBy')
  String? get createdBy => throw _privateConstructorUsedError;
  @JsonKey(name: 'updatedAt')
  String? get updatedAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'updatedBy')
  String? get updatedBy => throw _privateConstructorUsedError;
  @JsonKey(name: 'services')
  List<String>? get services => throw _privateConstructorUsedError;
  @JsonKey(name: 'location')
  Location get location => throw _privateConstructorUsedError;
  @JsonKey(name: 'class')
  String? get path => throw _privateConstructorUsedError;

  /// Serializes this PoiDetail to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PoiDetail
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PoiDetailCopyWith<PoiDetail> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PoiDetailCopyWith<$Res> {
  factory $PoiDetailCopyWith(PoiDetail value, $Res Function(PoiDetail) then) =
      _$PoiDetailCopyWithImpl<$Res, PoiDetail>;
  @useResult
  $Res call(
      {@JsonKey(name: 'id') String id,
      @JsonKey(name: 'name') String name,
      @JsonKey(name: 'description') String? description,
      @JsonKey(name: 'shortDescription') String? shortDescription,
      @JsonKey(name: 'address') String? address,
      @JsonKey(name: 'beaconId') String beaconId,
      @JsonKey(name: 'media') List<String>? media,
      @JsonKey(name: 'openingHours') OpeningHours? openingHours,
      @JsonKey(name: 'contacts') List<Map<String, dynamic>>? contacts,
      @JsonKey(name: 'createdAt') String? createdAt,
      @JsonKey(name: 'createdBy') String? createdBy,
      @JsonKey(name: 'updatedAt') String? updatedAt,
      @JsonKey(name: 'updatedBy') String? updatedBy,
      @JsonKey(name: 'services') List<String>? services,
      @JsonKey(name: 'location') Location location,
      @JsonKey(name: 'class') String? path});

  $OpeningHoursCopyWith<$Res>? get openingHours;
  $LocationCopyWith<$Res> get location;
}

/// @nodoc
class _$PoiDetailCopyWithImpl<$Res, $Val extends PoiDetail>
    implements $PoiDetailCopyWith<$Res> {
  _$PoiDetailCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PoiDetail
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = freezed,
    Object? shortDescription = freezed,
    Object? address = freezed,
    Object? beaconId = null,
    Object? media = freezed,
    Object? openingHours = freezed,
    Object? contacts = freezed,
    Object? createdAt = freezed,
    Object? createdBy = freezed,
    Object? updatedAt = freezed,
    Object? updatedBy = freezed,
    Object? services = freezed,
    Object? location = null,
    Object? path = freezed,
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
      shortDescription: freezed == shortDescription
          ? _value.shortDescription
          : shortDescription // ignore: cast_nullable_to_non_nullable
              as String?,
      address: freezed == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String?,
      beaconId: null == beaconId
          ? _value.beaconId
          : beaconId // ignore: cast_nullable_to_non_nullable
              as String,
      media: freezed == media
          ? _value.media
          : media // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      openingHours: freezed == openingHours
          ? _value.openingHours
          : openingHours // ignore: cast_nullable_to_non_nullable
              as OpeningHours?,
      contacts: freezed == contacts
          ? _value.contacts
          : contacts // ignore: cast_nullable_to_non_nullable
              as List<Map<String, dynamic>>?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String?,
      createdBy: freezed == createdBy
          ? _value.createdBy
          : createdBy // ignore: cast_nullable_to_non_nullable
              as String?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as String?,
      updatedBy: freezed == updatedBy
          ? _value.updatedBy
          : updatedBy // ignore: cast_nullable_to_non_nullable
              as String?,
      services: freezed == services
          ? _value.services
          : services // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      location: null == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as Location,
      path: freezed == path
          ? _value.path
          : path // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }

  /// Create a copy of PoiDetail
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $OpeningHoursCopyWith<$Res>? get openingHours {
    if (_value.openingHours == null) {
      return null;
    }

    return $OpeningHoursCopyWith<$Res>(_value.openingHours!, (value) {
      return _then(_value.copyWith(openingHours: value) as $Val);
    });
  }

  /// Create a copy of PoiDetail
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $LocationCopyWith<$Res> get location {
    return $LocationCopyWith<$Res>(_value.location, (value) {
      return _then(_value.copyWith(location: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$PoiDetailImplCopyWith<$Res>
    implements $PoiDetailCopyWith<$Res> {
  factory _$$PoiDetailImplCopyWith(
          _$PoiDetailImpl value, $Res Function(_$PoiDetailImpl) then) =
      __$$PoiDetailImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'id') String id,
      @JsonKey(name: 'name') String name,
      @JsonKey(name: 'description') String? description,
      @JsonKey(name: 'shortDescription') String? shortDescription,
      @JsonKey(name: 'address') String? address,
      @JsonKey(name: 'beaconId') String beaconId,
      @JsonKey(name: 'media') List<String>? media,
      @JsonKey(name: 'openingHours') OpeningHours? openingHours,
      @JsonKey(name: 'contacts') List<Map<String, dynamic>>? contacts,
      @JsonKey(name: 'createdAt') String? createdAt,
      @JsonKey(name: 'createdBy') String? createdBy,
      @JsonKey(name: 'updatedAt') String? updatedAt,
      @JsonKey(name: 'updatedBy') String? updatedBy,
      @JsonKey(name: 'services') List<String>? services,
      @JsonKey(name: 'location') Location location,
      @JsonKey(name: 'class') String? path});

  @override
  $OpeningHoursCopyWith<$Res>? get openingHours;
  @override
  $LocationCopyWith<$Res> get location;
}

/// @nodoc
class __$$PoiDetailImplCopyWithImpl<$Res>
    extends _$PoiDetailCopyWithImpl<$Res, _$PoiDetailImpl>
    implements _$$PoiDetailImplCopyWith<$Res> {
  __$$PoiDetailImplCopyWithImpl(
      _$PoiDetailImpl _value, $Res Function(_$PoiDetailImpl) _then)
      : super(_value, _then);

  /// Create a copy of PoiDetail
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = freezed,
    Object? shortDescription = freezed,
    Object? address = freezed,
    Object? beaconId = null,
    Object? media = freezed,
    Object? openingHours = freezed,
    Object? contacts = freezed,
    Object? createdAt = freezed,
    Object? createdBy = freezed,
    Object? updatedAt = freezed,
    Object? updatedBy = freezed,
    Object? services = freezed,
    Object? location = null,
    Object? path = freezed,
  }) {
    return _then(_$PoiDetailImpl(
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
      shortDescription: freezed == shortDescription
          ? _value.shortDescription
          : shortDescription // ignore: cast_nullable_to_non_nullable
              as String?,
      address: freezed == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String?,
      beaconId: null == beaconId
          ? _value.beaconId
          : beaconId // ignore: cast_nullable_to_non_nullable
              as String,
      media: freezed == media
          ? _value._media
          : media // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      openingHours: freezed == openingHours
          ? _value.openingHours
          : openingHours // ignore: cast_nullable_to_non_nullable
              as OpeningHours?,
      contacts: freezed == contacts
          ? _value._contacts
          : contacts // ignore: cast_nullable_to_non_nullable
              as List<Map<String, dynamic>>?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String?,
      createdBy: freezed == createdBy
          ? _value.createdBy
          : createdBy // ignore: cast_nullable_to_non_nullable
              as String?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as String?,
      updatedBy: freezed == updatedBy
          ? _value.updatedBy
          : updatedBy // ignore: cast_nullable_to_non_nullable
              as String?,
      services: freezed == services
          ? _value._services
          : services // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      location: null == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as Location,
      path: freezed == path
          ? _value.path
          : path // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PoiDetailImpl implements _PoiDetail {
  const _$PoiDetailImpl(
      {@JsonKey(name: 'id') required this.id,
      @JsonKey(name: 'name') required this.name,
      @JsonKey(name: 'description') this.description,
      @JsonKey(name: 'shortDescription') this.shortDescription,
      @JsonKey(name: 'address') this.address,
      @JsonKey(name: 'beaconId') required this.beaconId,
      @JsonKey(name: 'media') final List<String>? media,
      @JsonKey(name: 'openingHours') this.openingHours,
      @JsonKey(name: 'contacts') final List<Map<String, dynamic>>? contacts,
      @JsonKey(name: 'createdAt') this.createdAt,
      @JsonKey(name: 'createdBy') this.createdBy,
      @JsonKey(name: 'updatedAt') this.updatedAt,
      @JsonKey(name: 'updatedBy') this.updatedBy,
      @JsonKey(name: 'services') final List<String>? services,
      @JsonKey(name: 'location') required this.location,
      @JsonKey(name: 'class') this.path})
      : _media = media,
        _contacts = contacts,
        _services = services;

  factory _$PoiDetailImpl.fromJson(Map<String, dynamic> json) =>
      _$$PoiDetailImplFromJson(json);

  @override
  @JsonKey(name: 'id')
  final String id;
  @override
  @JsonKey(name: 'name')
  final String name;
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
  @JsonKey(name: 'beaconId')
  final String beaconId;
  final List<String>? _media;
  @override
  @JsonKey(name: 'media')
  List<String>? get media {
    final value = _media;
    if (value == null) return null;
    if (_media is EqualUnmodifiableListView) return _media;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  @JsonKey(name: 'openingHours')
  final OpeningHours? openingHours;
  final List<Map<String, dynamic>>? _contacts;
  @override
  @JsonKey(name: 'contacts')
  List<Map<String, dynamic>>? get contacts {
    final value = _contacts;
    if (value == null) return null;
    if (_contacts is EqualUnmodifiableListView) return _contacts;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  @JsonKey(name: 'createdAt')
  final String? createdAt;
  @override
  @JsonKey(name: 'createdBy')
  final String? createdBy;
  @override
  @JsonKey(name: 'updatedAt')
  final String? updatedAt;
  @override
  @JsonKey(name: 'updatedBy')
  final String? updatedBy;
  final List<String>? _services;
  @override
  @JsonKey(name: 'services')
  List<String>? get services {
    final value = _services;
    if (value == null) return null;
    if (_services is EqualUnmodifiableListView) return _services;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  @JsonKey(name: 'location')
  final Location location;
  @override
  @JsonKey(name: 'class')
  final String? path;

  @override
  String toString() {
    return 'PoiDetail(id: $id, name: $name, description: $description, shortDescription: $shortDescription, address: $address, beaconId: $beaconId, media: $media, openingHours: $openingHours, contacts: $contacts, createdAt: $createdAt, createdBy: $createdBy, updatedAt: $updatedAt, updatedBy: $updatedBy, services: $services, location: $location, path: $path)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PoiDetailImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.shortDescription, shortDescription) ||
                other.shortDescription == shortDescription) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.beaconId, beaconId) ||
                other.beaconId == beaconId) &&
            const DeepCollectionEquality().equals(other._media, _media) &&
            (identical(other.openingHours, openingHours) ||
                other.openingHours == openingHours) &&
            const DeepCollectionEquality().equals(other._contacts, _contacts) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.createdBy, createdBy) ||
                other.createdBy == createdBy) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.updatedBy, updatedBy) ||
                other.updatedBy == updatedBy) &&
            const DeepCollectionEquality().equals(other._services, _services) &&
            (identical(other.location, location) ||
                other.location == location) &&
            (identical(other.path, path) || other.path == path));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      description,
      shortDescription,
      address,
      beaconId,
      const DeepCollectionEquality().hash(_media),
      openingHours,
      const DeepCollectionEquality().hash(_contacts),
      createdAt,
      createdBy,
      updatedAt,
      updatedBy,
      const DeepCollectionEquality().hash(_services),
      location,
      path);

  /// Create a copy of PoiDetail
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PoiDetailImplCopyWith<_$PoiDetailImpl> get copyWith =>
      __$$PoiDetailImplCopyWithImpl<_$PoiDetailImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PoiDetailImplToJson(
      this,
    );
  }
}

abstract class _PoiDetail implements PoiDetail {
  const factory _PoiDetail(
      {@JsonKey(name: 'id') required final String id,
      @JsonKey(name: 'name') required final String name,
      @JsonKey(name: 'description') final String? description,
      @JsonKey(name: 'shortDescription') final String? shortDescription,
      @JsonKey(name: 'address') final String? address,
      @JsonKey(name: 'beaconId') required final String beaconId,
      @JsonKey(name: 'media') final List<String>? media,
      @JsonKey(name: 'openingHours') final OpeningHours? openingHours,
      @JsonKey(name: 'contacts') final List<Map<String, dynamic>>? contacts,
      @JsonKey(name: 'createdAt') final String? createdAt,
      @JsonKey(name: 'createdBy') final String? createdBy,
      @JsonKey(name: 'updatedAt') final String? updatedAt,
      @JsonKey(name: 'updatedBy') final String? updatedBy,
      @JsonKey(name: 'services') final List<String>? services,
      @JsonKey(name: 'location') required final Location location,
      @JsonKey(name: 'class') final String? path}) = _$PoiDetailImpl;

  factory _PoiDetail.fromJson(Map<String, dynamic> json) =
      _$PoiDetailImpl.fromJson;

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
  @JsonKey(name: 'shortDescription')
  String? get shortDescription;
  @override
  @JsonKey(name: 'address')
  String? get address;
  @override
  @JsonKey(name: 'beaconId')
  String get beaconId;
  @override
  @JsonKey(name: 'media')
  List<String>? get media;
  @override
  @JsonKey(name: 'openingHours')
  OpeningHours? get openingHours;
  @override
  @JsonKey(name: 'contacts')
  List<Map<String, dynamic>>? get contacts;
  @override
  @JsonKey(name: 'createdAt')
  String? get createdAt;
  @override
  @JsonKey(name: 'createdBy')
  String? get createdBy;
  @override
  @JsonKey(name: 'updatedAt')
  String? get updatedAt;
  @override
  @JsonKey(name: 'updatedBy')
  String? get updatedBy;
  @override
  @JsonKey(name: 'services')
  List<String>? get services;
  @override
  @JsonKey(name: 'location')
  Location get location;
  @override
  @JsonKey(name: 'class')
  String? get path;

  /// Create a copy of PoiDetail
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PoiDetailImplCopyWith<_$PoiDetailImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PoiTranslation _$PoiTranslationFromJson(Map<String, dynamic> json) {
  return _PoiTranslation.fromJson(json);
}

/// @nodoc
mixin _$PoiTranslation {
  @JsonKey(name: 'name')
  String get name => throw _privateConstructorUsedError;
  @JsonKey(name: 'description')
  String? get description => throw _privateConstructorUsedError;
  @JsonKey(name: 'shortDescription')
  String? get shortDescription => throw _privateConstructorUsedError;

  /// Serializes this PoiTranslation to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PoiTranslation
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PoiTranslationCopyWith<PoiTranslation> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PoiTranslationCopyWith<$Res> {
  factory $PoiTranslationCopyWith(
          PoiTranslation value, $Res Function(PoiTranslation) then) =
      _$PoiTranslationCopyWithImpl<$Res, PoiTranslation>;
  @useResult
  $Res call(
      {@JsonKey(name: 'name') String name,
      @JsonKey(name: 'description') String? description,
      @JsonKey(name: 'shortDescription') String? shortDescription});
}

/// @nodoc
class _$PoiTranslationCopyWithImpl<$Res, $Val extends PoiTranslation>
    implements $PoiTranslationCopyWith<$Res> {
  _$PoiTranslationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PoiTranslation
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? description = freezed,
    Object? shortDescription = freezed,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      shortDescription: freezed == shortDescription
          ? _value.shortDescription
          : shortDescription // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PoiTranslationImplCopyWith<$Res>
    implements $PoiTranslationCopyWith<$Res> {
  factory _$$PoiTranslationImplCopyWith(_$PoiTranslationImpl value,
          $Res Function(_$PoiTranslationImpl) then) =
      __$$PoiTranslationImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'name') String name,
      @JsonKey(name: 'description') String? description,
      @JsonKey(name: 'shortDescription') String? shortDescription});
}

/// @nodoc
class __$$PoiTranslationImplCopyWithImpl<$Res>
    extends _$PoiTranslationCopyWithImpl<$Res, _$PoiTranslationImpl>
    implements _$$PoiTranslationImplCopyWith<$Res> {
  __$$PoiTranslationImplCopyWithImpl(
      _$PoiTranslationImpl _value, $Res Function(_$PoiTranslationImpl) _then)
      : super(_value, _then);

  /// Create a copy of PoiTranslation
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? description = freezed,
    Object? shortDescription = freezed,
  }) {
    return _then(_$PoiTranslationImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      shortDescription: freezed == shortDescription
          ? _value.shortDescription
          : shortDescription // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PoiTranslationImpl implements _PoiTranslation {
  const _$PoiTranslationImpl(
      {@JsonKey(name: 'name') required this.name,
      @JsonKey(name: 'description') this.description,
      @JsonKey(name: 'shortDescription') this.shortDescription});

  factory _$PoiTranslationImpl.fromJson(Map<String, dynamic> json) =>
      _$$PoiTranslationImplFromJson(json);

  @override
  @JsonKey(name: 'name')
  final String name;
  @override
  @JsonKey(name: 'description')
  final String? description;
  @override
  @JsonKey(name: 'shortDescription')
  final String? shortDescription;

  @override
  String toString() {
    return 'PoiTranslation(name: $name, description: $description, shortDescription: $shortDescription)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PoiTranslationImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.shortDescription, shortDescription) ||
                other.shortDescription == shortDescription));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, name, description, shortDescription);

  /// Create a copy of PoiTranslation
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PoiTranslationImplCopyWith<_$PoiTranslationImpl> get copyWith =>
      __$$PoiTranslationImplCopyWithImpl<_$PoiTranslationImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PoiTranslationImplToJson(
      this,
    );
  }
}

abstract class _PoiTranslation implements PoiTranslation {
  const factory _PoiTranslation(
          {@JsonKey(name: 'name') required final String name,
          @JsonKey(name: 'description') final String? description,
          @JsonKey(name: 'shortDescription') final String? shortDescription}) =
      _$PoiTranslationImpl;

  factory _PoiTranslation.fromJson(Map<String, dynamic> json) =
      _$PoiTranslationImpl.fromJson;

  @override
  @JsonKey(name: 'name')
  String get name;
  @override
  @JsonKey(name: 'description')
  String? get description;
  @override
  @JsonKey(name: 'shortDescription')
  String? get shortDescription;

  /// Create a copy of PoiTranslation
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PoiTranslationImplCopyWith<_$PoiTranslationImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
