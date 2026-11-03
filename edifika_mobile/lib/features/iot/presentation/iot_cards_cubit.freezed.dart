// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'iot_cards_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$IotCardsState {

 LoadStatus get status; String? get error; List<AccessCredential> get credentials;/// Usuarios del IAM por id, para mostrar email y rol del titular.
 Map<int, UserProfile> get users; CardFilter get filter;/// Tarjeta con un cambio de estado en curso.
 int? get busyCredentialId;/// Aviso puntual para un SnackBar.
 String? get message;
/// Create a copy of IotCardsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$IotCardsStateCopyWith<IotCardsState> get copyWith => _$IotCardsStateCopyWithImpl<IotCardsState>(this as IotCardsState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is IotCardsState&&(identical(other.status, status) || other.status == status)&&(identical(other.error, error) || other.error == error)&&const DeepCollectionEquality().equals(other.credentials, credentials)&&const DeepCollectionEquality().equals(other.users, users)&&(identical(other.filter, filter) || other.filter == filter)&&(identical(other.busyCredentialId, busyCredentialId) || other.busyCredentialId == busyCredentialId)&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,status,error,const DeepCollectionEquality().hash(credentials),const DeepCollectionEquality().hash(users),filter,busyCredentialId,message);

@override
String toString() {
  return 'IotCardsState(status: $status, error: $error, credentials: $credentials, users: $users, filter: $filter, busyCredentialId: $busyCredentialId, message: $message)';
}


}

/// @nodoc
abstract mixin class $IotCardsStateCopyWith<$Res>  {
  factory $IotCardsStateCopyWith(IotCardsState value, $Res Function(IotCardsState) _then) = _$IotCardsStateCopyWithImpl;
@useResult
$Res call({
 LoadStatus status, String? error, List<AccessCredential> credentials, Map<int, UserProfile> users, CardFilter filter, int? busyCredentialId, String? message
});




}
/// @nodoc
class _$IotCardsStateCopyWithImpl<$Res>
    implements $IotCardsStateCopyWith<$Res> {
  _$IotCardsStateCopyWithImpl(this._self, this._then);

  final IotCardsState _self;
  final $Res Function(IotCardsState) _then;

/// Create a copy of IotCardsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? error = freezed,Object? credentials = null,Object? users = null,Object? filter = null,Object? busyCredentialId = freezed,Object? message = freezed,}) {
  return _then(_self.copyWith(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as LoadStatus,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,credentials: null == credentials ? _self.credentials : credentials // ignore: cast_nullable_to_non_nullable
as List<AccessCredential>,users: null == users ? _self.users : users // ignore: cast_nullable_to_non_nullable
as Map<int, UserProfile>,filter: null == filter ? _self.filter : filter // ignore: cast_nullable_to_non_nullable
as CardFilter,busyCredentialId: freezed == busyCredentialId ? _self.busyCredentialId : busyCredentialId // ignore: cast_nullable_to_non_nullable
as int?,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [IotCardsState].
extension IotCardsStatePatterns on IotCardsState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _IotCardsState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _IotCardsState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _IotCardsState value)  $default,){
final _that = this;
switch (_that) {
case _IotCardsState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _IotCardsState value)?  $default,){
final _that = this;
switch (_that) {
case _IotCardsState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( LoadStatus status,  String? error,  List<AccessCredential> credentials,  Map<int, UserProfile> users,  CardFilter filter,  int? busyCredentialId,  String? message)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _IotCardsState() when $default != null:
return $default(_that.status,_that.error,_that.credentials,_that.users,_that.filter,_that.busyCredentialId,_that.message);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( LoadStatus status,  String? error,  List<AccessCredential> credentials,  Map<int, UserProfile> users,  CardFilter filter,  int? busyCredentialId,  String? message)  $default,) {final _that = this;
switch (_that) {
case _IotCardsState():
return $default(_that.status,_that.error,_that.credentials,_that.users,_that.filter,_that.busyCredentialId,_that.message);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( LoadStatus status,  String? error,  List<AccessCredential> credentials,  Map<int, UserProfile> users,  CardFilter filter,  int? busyCredentialId,  String? message)?  $default,) {final _that = this;
switch (_that) {
case _IotCardsState() when $default != null:
return $default(_that.status,_that.error,_that.credentials,_that.users,_that.filter,_that.busyCredentialId,_that.message);case _:
  return null;

}
}

}

/// @nodoc


class _IotCardsState extends IotCardsState {
  const _IotCardsState({this.status = LoadStatus.loading, this.error, final  List<AccessCredential> credentials = const <AccessCredential>[], final  Map<int, UserProfile> users = const <int, UserProfile>{}, this.filter = CardFilter.all, this.busyCredentialId, this.message}): _credentials = credentials,_users = users,super._();
  

@override@JsonKey() final  LoadStatus status;
@override final  String? error;
 final  List<AccessCredential> _credentials;
@override@JsonKey() List<AccessCredential> get credentials {
  if (_credentials is EqualUnmodifiableListView) return _credentials;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_credentials);
}

/// Usuarios del IAM por id, para mostrar email y rol del titular.
 final  Map<int, UserProfile> _users;
/// Usuarios del IAM por id, para mostrar email y rol del titular.
@override@JsonKey() Map<int, UserProfile> get users {
  if (_users is EqualUnmodifiableMapView) return _users;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_users);
}

@override@JsonKey() final  CardFilter filter;
/// Tarjeta con un cambio de estado en curso.
@override final  int? busyCredentialId;
/// Aviso puntual para un SnackBar.
@override final  String? message;

/// Create a copy of IotCardsState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$IotCardsStateCopyWith<_IotCardsState> get copyWith => __$IotCardsStateCopyWithImpl<_IotCardsState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _IotCardsState&&(identical(other.status, status) || other.status == status)&&(identical(other.error, error) || other.error == error)&&const DeepCollectionEquality().equals(other._credentials, _credentials)&&const DeepCollectionEquality().equals(other._users, _users)&&(identical(other.filter, filter) || other.filter == filter)&&(identical(other.busyCredentialId, busyCredentialId) || other.busyCredentialId == busyCredentialId)&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,status,error,const DeepCollectionEquality().hash(_credentials),const DeepCollectionEquality().hash(_users),filter,busyCredentialId,message);

@override
String toString() {
  return 'IotCardsState(status: $status, error: $error, credentials: $credentials, users: $users, filter: $filter, busyCredentialId: $busyCredentialId, message: $message)';
}


}

/// @nodoc
abstract mixin class _$IotCardsStateCopyWith<$Res> implements $IotCardsStateCopyWith<$Res> {
  factory _$IotCardsStateCopyWith(_IotCardsState value, $Res Function(_IotCardsState) _then) = __$IotCardsStateCopyWithImpl;
@override @useResult
$Res call({
 LoadStatus status, String? error, List<AccessCredential> credentials, Map<int, UserProfile> users, CardFilter filter, int? busyCredentialId, String? message
});




}
/// @nodoc
class __$IotCardsStateCopyWithImpl<$Res>
    implements _$IotCardsStateCopyWith<$Res> {
  __$IotCardsStateCopyWithImpl(this._self, this._then);

  final _IotCardsState _self;
  final $Res Function(_IotCardsState) _then;

/// Create a copy of IotCardsState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? error = freezed,Object? credentials = null,Object? users = null,Object? filter = null,Object? busyCredentialId = freezed,Object? message = freezed,}) {
  return _then(_IotCardsState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as LoadStatus,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,credentials: null == credentials ? _self._credentials : credentials // ignore: cast_nullable_to_non_nullable
as List<AccessCredential>,users: null == users ? _self._users : users // ignore: cast_nullable_to_non_nullable
as Map<int, UserProfile>,filter: null == filter ? _self.filter : filter // ignore: cast_nullable_to_non_nullable
as CardFilter,busyCredentialId: freezed == busyCredentialId ? _self.busyCredentialId : busyCredentialId // ignore: cast_nullable_to_non_nullable
as int?,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
