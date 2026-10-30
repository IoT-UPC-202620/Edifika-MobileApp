// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'session_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SessionState {

 SessionStatus get status; AuthenticatedUser? get user; Residence? get residence; bool get loadingResidence; String? get residenceError;/// Mensaje a mostrar en el login (p. ej. "tu sesión expiró").
 String? get notice;
/// Create a copy of SessionState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SessionStateCopyWith<SessionState> get copyWith => _$SessionStateCopyWithImpl<SessionState>(this as SessionState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SessionState&&(identical(other.status, status) || other.status == status)&&(identical(other.user, user) || other.user == user)&&(identical(other.residence, residence) || other.residence == residence)&&(identical(other.loadingResidence, loadingResidence) || other.loadingResidence == loadingResidence)&&(identical(other.residenceError, residenceError) || other.residenceError == residenceError)&&(identical(other.notice, notice) || other.notice == notice));
}


@override
int get hashCode => Object.hash(runtimeType,status,user,residence,loadingResidence,residenceError,notice);

@override
String toString() {
  return 'SessionState(status: $status, user: $user, residence: $residence, loadingResidence: $loadingResidence, residenceError: $residenceError, notice: $notice)';
}


}

/// @nodoc
abstract mixin class $SessionStateCopyWith<$Res>  {
  factory $SessionStateCopyWith(SessionState value, $Res Function(SessionState) _then) = _$SessionStateCopyWithImpl;
@useResult
$Res call({
 SessionStatus status, AuthenticatedUser? user, Residence? residence, bool loadingResidence, String? residenceError, String? notice
});


$AuthenticatedUserCopyWith<$Res>? get user;

}
/// @nodoc
class _$SessionStateCopyWithImpl<$Res>
    implements $SessionStateCopyWith<$Res> {
  _$SessionStateCopyWithImpl(this._self, this._then);

  final SessionState _self;
  final $Res Function(SessionState) _then;

/// Create a copy of SessionState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? user = freezed,Object? residence = freezed,Object? loadingResidence = null,Object? residenceError = freezed,Object? notice = freezed,}) {
  return _then(_self.copyWith(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as SessionStatus,user: freezed == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as AuthenticatedUser?,residence: freezed == residence ? _self.residence : residence // ignore: cast_nullable_to_non_nullable
as Residence?,loadingResidence: null == loadingResidence ? _self.loadingResidence : loadingResidence // ignore: cast_nullable_to_non_nullable
as bool,residenceError: freezed == residenceError ? _self.residenceError : residenceError // ignore: cast_nullable_to_non_nullable
as String?,notice: freezed == notice ? _self.notice : notice // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of SessionState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AuthenticatedUserCopyWith<$Res>? get user {
    if (_self.user == null) {
    return null;
  }

  return $AuthenticatedUserCopyWith<$Res>(_self.user!, (value) {
    return _then(_self.copyWith(user: value));
  });
}
}


/// Adds pattern-matching-related methods to [SessionState].
extension SessionStatePatterns on SessionState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SessionState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SessionState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SessionState value)  $default,){
final _that = this;
switch (_that) {
case _SessionState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SessionState value)?  $default,){
final _that = this;
switch (_that) {
case _SessionState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( SessionStatus status,  AuthenticatedUser? user,  Residence? residence,  bool loadingResidence,  String? residenceError,  String? notice)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SessionState() when $default != null:
return $default(_that.status,_that.user,_that.residence,_that.loadingResidence,_that.residenceError,_that.notice);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( SessionStatus status,  AuthenticatedUser? user,  Residence? residence,  bool loadingResidence,  String? residenceError,  String? notice)  $default,) {final _that = this;
switch (_that) {
case _SessionState():
return $default(_that.status,_that.user,_that.residence,_that.loadingResidence,_that.residenceError,_that.notice);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( SessionStatus status,  AuthenticatedUser? user,  Residence? residence,  bool loadingResidence,  String? residenceError,  String? notice)?  $default,) {final _that = this;
switch (_that) {
case _SessionState() when $default != null:
return $default(_that.status,_that.user,_that.residence,_that.loadingResidence,_that.residenceError,_that.notice);case _:
  return null;

}
}

}

/// @nodoc


class _SessionState implements SessionState {
  const _SessionState({this.status = SessionStatus.unknown, this.user, this.residence, this.loadingResidence = false, this.residenceError, this.notice});
  

@override@JsonKey() final  SessionStatus status;
@override final  AuthenticatedUser? user;
@override final  Residence? residence;
@override@JsonKey() final  bool loadingResidence;
@override final  String? residenceError;
/// Mensaje a mostrar en el login (p. ej. "tu sesión expiró").
@override final  String? notice;

/// Create a copy of SessionState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SessionStateCopyWith<_SessionState> get copyWith => __$SessionStateCopyWithImpl<_SessionState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SessionState&&(identical(other.status, status) || other.status == status)&&(identical(other.user, user) || other.user == user)&&(identical(other.residence, residence) || other.residence == residence)&&(identical(other.loadingResidence, loadingResidence) || other.loadingResidence == loadingResidence)&&(identical(other.residenceError, residenceError) || other.residenceError == residenceError)&&(identical(other.notice, notice) || other.notice == notice));
}


@override
int get hashCode => Object.hash(runtimeType,status,user,residence,loadingResidence,residenceError,notice);

@override
String toString() {
  return 'SessionState(status: $status, user: $user, residence: $residence, loadingResidence: $loadingResidence, residenceError: $residenceError, notice: $notice)';
}


}

/// @nodoc
abstract mixin class _$SessionStateCopyWith<$Res> implements $SessionStateCopyWith<$Res> {
  factory _$SessionStateCopyWith(_SessionState value, $Res Function(_SessionState) _then) = __$SessionStateCopyWithImpl;
@override @useResult
$Res call({
 SessionStatus status, AuthenticatedUser? user, Residence? residence, bool loadingResidence, String? residenceError, String? notice
});


@override $AuthenticatedUserCopyWith<$Res>? get user;

}
/// @nodoc
class __$SessionStateCopyWithImpl<$Res>
    implements _$SessionStateCopyWith<$Res> {
  __$SessionStateCopyWithImpl(this._self, this._then);

  final _SessionState _self;
  final $Res Function(_SessionState) _then;

/// Create a copy of SessionState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? user = freezed,Object? residence = freezed,Object? loadingResidence = null,Object? residenceError = freezed,Object? notice = freezed,}) {
  return _then(_SessionState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as SessionStatus,user: freezed == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as AuthenticatedUser?,residence: freezed == residence ? _self.residence : residence // ignore: cast_nullable_to_non_nullable
as Residence?,loadingResidence: null == loadingResidence ? _self.loadingResidence : loadingResidence // ignore: cast_nullable_to_non_nullable
as bool,residenceError: freezed == residenceError ? _self.residenceError : residenceError // ignore: cast_nullable_to_non_nullable
as String?,notice: freezed == notice ? _self.notice : notice // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of SessionState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AuthenticatedUserCopyWith<$Res>? get user {
    if (_self.user == null) {
    return null;
  }

  return $AuthenticatedUserCopyWith<$Res>(_self.user!, (value) {
    return _then(_self.copyWith(user: value));
  });
}
}

// dart format on
