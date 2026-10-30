// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'announcement.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Announcement {

@JsonKey(name: 'id_announcement') int get id;@JsonKey(name: 'id_building') int get buildingId; String get title; String get description; String get message; String get priority;@JsonKey(name: 'created_at') String? get createdAt;
/// Create a copy of Announcement
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AnnouncementCopyWith<Announcement> get copyWith => _$AnnouncementCopyWithImpl<Announcement>(this as Announcement, _$identity);

  /// Serializes this Announcement to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Announcement&&(identical(other.id, id) || other.id == id)&&(identical(other.buildingId, buildingId) || other.buildingId == buildingId)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.message, message) || other.message == message)&&(identical(other.priority, priority) || other.priority == priority)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,buildingId,title,description,message,priority,createdAt);

@override
String toString() {
  return 'Announcement(id: $id, buildingId: $buildingId, title: $title, description: $description, message: $message, priority: $priority, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $AnnouncementCopyWith<$Res>  {
  factory $AnnouncementCopyWith(Announcement value, $Res Function(Announcement) _then) = _$AnnouncementCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'id_announcement') int id,@JsonKey(name: 'id_building') int buildingId, String title, String description, String message, String priority,@JsonKey(name: 'created_at') String? createdAt
});




}
/// @nodoc
class _$AnnouncementCopyWithImpl<$Res>
    implements $AnnouncementCopyWith<$Res> {
  _$AnnouncementCopyWithImpl(this._self, this._then);

  final Announcement _self;
  final $Res Function(Announcement) _then;

/// Create a copy of Announcement
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? buildingId = null,Object? title = null,Object? description = null,Object? message = null,Object? priority = null,Object? createdAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,buildingId: null == buildingId ? _self.buildingId : buildingId // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,priority: null == priority ? _self.priority : priority // ignore: cast_nullable_to_non_nullable
as String,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [Announcement].
extension AnnouncementPatterns on Announcement {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Announcement value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Announcement() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Announcement value)  $default,){
final _that = this;
switch (_that) {
case _Announcement():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Announcement value)?  $default,){
final _that = this;
switch (_that) {
case _Announcement() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'id_announcement')  int id, @JsonKey(name: 'id_building')  int buildingId,  String title,  String description,  String message,  String priority, @JsonKey(name: 'created_at')  String? createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Announcement() when $default != null:
return $default(_that.id,_that.buildingId,_that.title,_that.description,_that.message,_that.priority,_that.createdAt);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'id_announcement')  int id, @JsonKey(name: 'id_building')  int buildingId,  String title,  String description,  String message,  String priority, @JsonKey(name: 'created_at')  String? createdAt)  $default,) {final _that = this;
switch (_that) {
case _Announcement():
return $default(_that.id,_that.buildingId,_that.title,_that.description,_that.message,_that.priority,_that.createdAt);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'id_announcement')  int id, @JsonKey(name: 'id_building')  int buildingId,  String title,  String description,  String message,  String priority, @JsonKey(name: 'created_at')  String? createdAt)?  $default,) {final _that = this;
switch (_that) {
case _Announcement() when $default != null:
return $default(_that.id,_that.buildingId,_that.title,_that.description,_that.message,_that.priority,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Announcement implements Announcement {
  const _Announcement({@JsonKey(name: 'id_announcement') required this.id, @JsonKey(name: 'id_building') required this.buildingId, required this.title, this.description = '', this.message = '', this.priority = '', @JsonKey(name: 'created_at') this.createdAt});
  factory _Announcement.fromJson(Map<String, dynamic> json) => _$AnnouncementFromJson(json);

@override@JsonKey(name: 'id_announcement') final  int id;
@override@JsonKey(name: 'id_building') final  int buildingId;
@override final  String title;
@override@JsonKey() final  String description;
@override@JsonKey() final  String message;
@override@JsonKey() final  String priority;
@override@JsonKey(name: 'created_at') final  String? createdAt;

/// Create a copy of Announcement
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AnnouncementCopyWith<_Announcement> get copyWith => __$AnnouncementCopyWithImpl<_Announcement>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AnnouncementToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Announcement&&(identical(other.id, id) || other.id == id)&&(identical(other.buildingId, buildingId) || other.buildingId == buildingId)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.message, message) || other.message == message)&&(identical(other.priority, priority) || other.priority == priority)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,buildingId,title,description,message,priority,createdAt);

@override
String toString() {
  return 'Announcement(id: $id, buildingId: $buildingId, title: $title, description: $description, message: $message, priority: $priority, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$AnnouncementCopyWith<$Res> implements $AnnouncementCopyWith<$Res> {
  factory _$AnnouncementCopyWith(_Announcement value, $Res Function(_Announcement) _then) = __$AnnouncementCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'id_announcement') int id,@JsonKey(name: 'id_building') int buildingId, String title, String description, String message, String priority,@JsonKey(name: 'created_at') String? createdAt
});




}
/// @nodoc
class __$AnnouncementCopyWithImpl<$Res>
    implements _$AnnouncementCopyWith<$Res> {
  __$AnnouncementCopyWithImpl(this._self, this._then);

  final _Announcement _self;
  final $Res Function(_Announcement) _then;

/// Create a copy of Announcement
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? buildingId = null,Object? title = null,Object? description = null,Object? message = null,Object? priority = null,Object? createdAt = freezed,}) {
  return _then(_Announcement(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,buildingId: null == buildingId ? _self.buildingId : buildingId // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,priority: null == priority ? _self.priority : priority // ignore: cast_nullable_to_non_nullable
as String,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$AnnouncementRead {

@JsonKey(name: 'id_announcement_read') int get id;@JsonKey(name: 'id_announcement') int get announcementId;@JsonKey(name: 'id_user') int get userId;
/// Create a copy of AnnouncementRead
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AnnouncementReadCopyWith<AnnouncementRead> get copyWith => _$AnnouncementReadCopyWithImpl<AnnouncementRead>(this as AnnouncementRead, _$identity);

  /// Serializes this AnnouncementRead to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AnnouncementRead&&(identical(other.id, id) || other.id == id)&&(identical(other.announcementId, announcementId) || other.announcementId == announcementId)&&(identical(other.userId, userId) || other.userId == userId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,announcementId,userId);

@override
String toString() {
  return 'AnnouncementRead(id: $id, announcementId: $announcementId, userId: $userId)';
}


}

/// @nodoc
abstract mixin class $AnnouncementReadCopyWith<$Res>  {
  factory $AnnouncementReadCopyWith(AnnouncementRead value, $Res Function(AnnouncementRead) _then) = _$AnnouncementReadCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'id_announcement_read') int id,@JsonKey(name: 'id_announcement') int announcementId,@JsonKey(name: 'id_user') int userId
});




}
/// @nodoc
class _$AnnouncementReadCopyWithImpl<$Res>
    implements $AnnouncementReadCopyWith<$Res> {
  _$AnnouncementReadCopyWithImpl(this._self, this._then);

  final AnnouncementRead _self;
  final $Res Function(AnnouncementRead) _then;

/// Create a copy of AnnouncementRead
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? announcementId = null,Object? userId = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,announcementId: null == announcementId ? _self.announcementId : announcementId // ignore: cast_nullable_to_non_nullable
as int,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [AnnouncementRead].
extension AnnouncementReadPatterns on AnnouncementRead {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AnnouncementRead value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AnnouncementRead() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AnnouncementRead value)  $default,){
final _that = this;
switch (_that) {
case _AnnouncementRead():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AnnouncementRead value)?  $default,){
final _that = this;
switch (_that) {
case _AnnouncementRead() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'id_announcement_read')  int id, @JsonKey(name: 'id_announcement')  int announcementId, @JsonKey(name: 'id_user')  int userId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AnnouncementRead() when $default != null:
return $default(_that.id,_that.announcementId,_that.userId);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'id_announcement_read')  int id, @JsonKey(name: 'id_announcement')  int announcementId, @JsonKey(name: 'id_user')  int userId)  $default,) {final _that = this;
switch (_that) {
case _AnnouncementRead():
return $default(_that.id,_that.announcementId,_that.userId);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'id_announcement_read')  int id, @JsonKey(name: 'id_announcement')  int announcementId, @JsonKey(name: 'id_user')  int userId)?  $default,) {final _that = this;
switch (_that) {
case _AnnouncementRead() when $default != null:
return $default(_that.id,_that.announcementId,_that.userId);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AnnouncementRead implements AnnouncementRead {
  const _AnnouncementRead({@JsonKey(name: 'id_announcement_read') required this.id, @JsonKey(name: 'id_announcement') required this.announcementId, @JsonKey(name: 'id_user') required this.userId});
  factory _AnnouncementRead.fromJson(Map<String, dynamic> json) => _$AnnouncementReadFromJson(json);

@override@JsonKey(name: 'id_announcement_read') final  int id;
@override@JsonKey(name: 'id_announcement') final  int announcementId;
@override@JsonKey(name: 'id_user') final  int userId;

/// Create a copy of AnnouncementRead
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AnnouncementReadCopyWith<_AnnouncementRead> get copyWith => __$AnnouncementReadCopyWithImpl<_AnnouncementRead>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AnnouncementReadToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AnnouncementRead&&(identical(other.id, id) || other.id == id)&&(identical(other.announcementId, announcementId) || other.announcementId == announcementId)&&(identical(other.userId, userId) || other.userId == userId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,announcementId,userId);

@override
String toString() {
  return 'AnnouncementRead(id: $id, announcementId: $announcementId, userId: $userId)';
}


}

/// @nodoc
abstract mixin class _$AnnouncementReadCopyWith<$Res> implements $AnnouncementReadCopyWith<$Res> {
  factory _$AnnouncementReadCopyWith(_AnnouncementRead value, $Res Function(_AnnouncementRead) _then) = __$AnnouncementReadCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'id_announcement_read') int id,@JsonKey(name: 'id_announcement') int announcementId,@JsonKey(name: 'id_user') int userId
});




}
/// @nodoc
class __$AnnouncementReadCopyWithImpl<$Res>
    implements _$AnnouncementReadCopyWith<$Res> {
  __$AnnouncementReadCopyWithImpl(this._self, this._then);

  final _AnnouncementRead _self;
  final $Res Function(_AnnouncementRead) _then;

/// Create a copy of AnnouncementRead
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? announcementId = null,Object? userId = null,}) {
  return _then(_AnnouncementRead(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,announcementId: null == announcementId ? _self.announcementId : announcementId // ignore: cast_nullable_to_non_nullable
as int,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
