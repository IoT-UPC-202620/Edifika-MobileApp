// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'iot_discovery_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$IotDiscoveryState {

 LoadStatus get status; String? get error; List<DiscoveredDevice> get devices;/// Aviso puntual para un SnackBar.
 String? get message;
/// Create a copy of IotDiscoveryState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$IotDiscoveryStateCopyWith<IotDiscoveryState> get copyWith => _$IotDiscoveryStateCopyWithImpl<IotDiscoveryState>(this as IotDiscoveryState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is IotDiscoveryState&&(identical(other.status, status) || other.status == status)&&(identical(other.error, error) || other.error == error)&&const DeepCollectionEquality().equals(other.devices, devices)&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,status,error,const DeepCollectionEquality().hash(devices),message);

@override
String toString() {
  return 'IotDiscoveryState(status: $status, error: $error, devices: $devices, message: $message)';
}


}

/// @nodoc
abstract mixin class $IotDiscoveryStateCopyWith<$Res>  {
  factory $IotDiscoveryStateCopyWith(IotDiscoveryState value, $Res Function(IotDiscoveryState) _then) = _$IotDiscoveryStateCopyWithImpl;
@useResult
$Res call({
 LoadStatus status, String? error, List<DiscoveredDevice> devices, String? message
});




}
/// @nodoc
class _$IotDiscoveryStateCopyWithImpl<$Res>
    implements $IotDiscoveryStateCopyWith<$Res> {
  _$IotDiscoveryStateCopyWithImpl(this._self, this._then);

  final IotDiscoveryState _self;
  final $Res Function(IotDiscoveryState) _then;

/// Create a copy of IotDiscoveryState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? error = freezed,Object? devices = null,Object? message = freezed,}) {
  return _then(_self.copyWith(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as LoadStatus,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,devices: null == devices ? _self.devices : devices // ignore: cast_nullable_to_non_nullable
as List<DiscoveredDevice>,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [IotDiscoveryState].
extension IotDiscoveryStatePatterns on IotDiscoveryState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _IotDiscoveryState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _IotDiscoveryState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _IotDiscoveryState value)  $default,){
final _that = this;
switch (_that) {
case _IotDiscoveryState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _IotDiscoveryState value)?  $default,){
final _that = this;
switch (_that) {
case _IotDiscoveryState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( LoadStatus status,  String? error,  List<DiscoveredDevice> devices,  String? message)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _IotDiscoveryState() when $default != null:
return $default(_that.status,_that.error,_that.devices,_that.message);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( LoadStatus status,  String? error,  List<DiscoveredDevice> devices,  String? message)  $default,) {final _that = this;
switch (_that) {
case _IotDiscoveryState():
return $default(_that.status,_that.error,_that.devices,_that.message);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( LoadStatus status,  String? error,  List<DiscoveredDevice> devices,  String? message)?  $default,) {final _that = this;
switch (_that) {
case _IotDiscoveryState() when $default != null:
return $default(_that.status,_that.error,_that.devices,_that.message);case _:
  return null;

}
}

}

/// @nodoc


class _IotDiscoveryState implements IotDiscoveryState {
  const _IotDiscoveryState({this.status = LoadStatus.loading, this.error, final  List<DiscoveredDevice> devices = const <DiscoveredDevice>[], this.message}): _devices = devices;
  

@override@JsonKey() final  LoadStatus status;
@override final  String? error;
 final  List<DiscoveredDevice> _devices;
@override@JsonKey() List<DiscoveredDevice> get devices {
  if (_devices is EqualUnmodifiableListView) return _devices;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_devices);
}

/// Aviso puntual para un SnackBar.
@override final  String? message;

/// Create a copy of IotDiscoveryState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$IotDiscoveryStateCopyWith<_IotDiscoveryState> get copyWith => __$IotDiscoveryStateCopyWithImpl<_IotDiscoveryState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _IotDiscoveryState&&(identical(other.status, status) || other.status == status)&&(identical(other.error, error) || other.error == error)&&const DeepCollectionEquality().equals(other._devices, _devices)&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,status,error,const DeepCollectionEquality().hash(_devices),message);

@override
String toString() {
  return 'IotDiscoveryState(status: $status, error: $error, devices: $devices, message: $message)';
}


}

/// @nodoc
abstract mixin class _$IotDiscoveryStateCopyWith<$Res> implements $IotDiscoveryStateCopyWith<$Res> {
  factory _$IotDiscoveryStateCopyWith(_IotDiscoveryState value, $Res Function(_IotDiscoveryState) _then) = __$IotDiscoveryStateCopyWithImpl;
@override @useResult
$Res call({
 LoadStatus status, String? error, List<DiscoveredDevice> devices, String? message
});




}
/// @nodoc
class __$IotDiscoveryStateCopyWithImpl<$Res>
    implements _$IotDiscoveryStateCopyWith<$Res> {
  __$IotDiscoveryStateCopyWithImpl(this._self, this._then);

  final _IotDiscoveryState _self;
  final $Res Function(_IotDiscoveryState) _then;

/// Create a copy of IotDiscoveryState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? error = freezed,Object? devices = null,Object? message = freezed,}) {
  return _then(_IotDiscoveryState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as LoadStatus,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,devices: null == devices ? _self._devices : devices // ignore: cast_nullable_to_non_nullable
as List<DiscoveredDevice>,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc
mixin _$IotAdoptState {

 DiscoveredDevice get discovered; AdoptAction get action;/// Dispositivo creado al adoptar; la pantalla se cierra al recibirlo.
 IotDevice? get adopted; bool get ignored; String? get error;/// Aviso puntual para un SnackBar.
 String? get message;
/// Create a copy of IotAdoptState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$IotAdoptStateCopyWith<IotAdoptState> get copyWith => _$IotAdoptStateCopyWithImpl<IotAdoptState>(this as IotAdoptState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is IotAdoptState&&(identical(other.discovered, discovered) || other.discovered == discovered)&&(identical(other.action, action) || other.action == action)&&(identical(other.adopted, adopted) || other.adopted == adopted)&&(identical(other.ignored, ignored) || other.ignored == ignored)&&(identical(other.error, error) || other.error == error)&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,discovered,action,adopted,ignored,error,message);

@override
String toString() {
  return 'IotAdoptState(discovered: $discovered, action: $action, adopted: $adopted, ignored: $ignored, error: $error, message: $message)';
}


}

/// @nodoc
abstract mixin class $IotAdoptStateCopyWith<$Res>  {
  factory $IotAdoptStateCopyWith(IotAdoptState value, $Res Function(IotAdoptState) _then) = _$IotAdoptStateCopyWithImpl;
@useResult
$Res call({
 DiscoveredDevice discovered, AdoptAction action, IotDevice? adopted, bool ignored, String? error, String? message
});


$DiscoveredDeviceCopyWith<$Res> get discovered;$IotDeviceCopyWith<$Res>? get adopted;

}
/// @nodoc
class _$IotAdoptStateCopyWithImpl<$Res>
    implements $IotAdoptStateCopyWith<$Res> {
  _$IotAdoptStateCopyWithImpl(this._self, this._then);

  final IotAdoptState _self;
  final $Res Function(IotAdoptState) _then;

/// Create a copy of IotAdoptState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? discovered = null,Object? action = null,Object? adopted = freezed,Object? ignored = null,Object? error = freezed,Object? message = freezed,}) {
  return _then(_self.copyWith(
discovered: null == discovered ? _self.discovered : discovered // ignore: cast_nullable_to_non_nullable
as DiscoveredDevice,action: null == action ? _self.action : action // ignore: cast_nullable_to_non_nullable
as AdoptAction,adopted: freezed == adopted ? _self.adopted : adopted // ignore: cast_nullable_to_non_nullable
as IotDevice?,ignored: null == ignored ? _self.ignored : ignored // ignore: cast_nullable_to_non_nullable
as bool,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of IotAdoptState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DiscoveredDeviceCopyWith<$Res> get discovered {
  
  return $DiscoveredDeviceCopyWith<$Res>(_self.discovered, (value) {
    return _then(_self.copyWith(discovered: value));
  });
}/// Create a copy of IotAdoptState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$IotDeviceCopyWith<$Res>? get adopted {
    if (_self.adopted == null) {
    return null;
  }

  return $IotDeviceCopyWith<$Res>(_self.adopted!, (value) {
    return _then(_self.copyWith(adopted: value));
  });
}
}


/// Adds pattern-matching-related methods to [IotAdoptState].
extension IotAdoptStatePatterns on IotAdoptState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _IotAdoptState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _IotAdoptState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _IotAdoptState value)  $default,){
final _that = this;
switch (_that) {
case _IotAdoptState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _IotAdoptState value)?  $default,){
final _that = this;
switch (_that) {
case _IotAdoptState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( DiscoveredDevice discovered,  AdoptAction action,  IotDevice? adopted,  bool ignored,  String? error,  String? message)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _IotAdoptState() when $default != null:
return $default(_that.discovered,_that.action,_that.adopted,_that.ignored,_that.error,_that.message);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( DiscoveredDevice discovered,  AdoptAction action,  IotDevice? adopted,  bool ignored,  String? error,  String? message)  $default,) {final _that = this;
switch (_that) {
case _IotAdoptState():
return $default(_that.discovered,_that.action,_that.adopted,_that.ignored,_that.error,_that.message);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( DiscoveredDevice discovered,  AdoptAction action,  IotDevice? adopted,  bool ignored,  String? error,  String? message)?  $default,) {final _that = this;
switch (_that) {
case _IotAdoptState() when $default != null:
return $default(_that.discovered,_that.action,_that.adopted,_that.ignored,_that.error,_that.message);case _:
  return null;

}
}

}

/// @nodoc


class _IotAdoptState extends IotAdoptState {
  const _IotAdoptState({required this.discovered, this.action = AdoptAction.none, this.adopted, this.ignored = false, this.error, this.message}): super._();
  

@override final  DiscoveredDevice discovered;
@override@JsonKey() final  AdoptAction action;
/// Dispositivo creado al adoptar; la pantalla se cierra al recibirlo.
@override final  IotDevice? adopted;
@override@JsonKey() final  bool ignored;
@override final  String? error;
/// Aviso puntual para un SnackBar.
@override final  String? message;

/// Create a copy of IotAdoptState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$IotAdoptStateCopyWith<_IotAdoptState> get copyWith => __$IotAdoptStateCopyWithImpl<_IotAdoptState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _IotAdoptState&&(identical(other.discovered, discovered) || other.discovered == discovered)&&(identical(other.action, action) || other.action == action)&&(identical(other.adopted, adopted) || other.adopted == adopted)&&(identical(other.ignored, ignored) || other.ignored == ignored)&&(identical(other.error, error) || other.error == error)&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,discovered,action,adopted,ignored,error,message);

@override
String toString() {
  return 'IotAdoptState(discovered: $discovered, action: $action, adopted: $adopted, ignored: $ignored, error: $error, message: $message)';
}


}

/// @nodoc
abstract mixin class _$IotAdoptStateCopyWith<$Res> implements $IotAdoptStateCopyWith<$Res> {
  factory _$IotAdoptStateCopyWith(_IotAdoptState value, $Res Function(_IotAdoptState) _then) = __$IotAdoptStateCopyWithImpl;
@override @useResult
$Res call({
 DiscoveredDevice discovered, AdoptAction action, IotDevice? adopted, bool ignored, String? error, String? message
});


@override $DiscoveredDeviceCopyWith<$Res> get discovered;@override $IotDeviceCopyWith<$Res>? get adopted;

}
/// @nodoc
class __$IotAdoptStateCopyWithImpl<$Res>
    implements _$IotAdoptStateCopyWith<$Res> {
  __$IotAdoptStateCopyWithImpl(this._self, this._then);

  final _IotAdoptState _self;
  final $Res Function(_IotAdoptState) _then;

/// Create a copy of IotAdoptState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? discovered = null,Object? action = null,Object? adopted = freezed,Object? ignored = null,Object? error = freezed,Object? message = freezed,}) {
  return _then(_IotAdoptState(
discovered: null == discovered ? _self.discovered : discovered // ignore: cast_nullable_to_non_nullable
as DiscoveredDevice,action: null == action ? _self.action : action // ignore: cast_nullable_to_non_nullable
as AdoptAction,adopted: freezed == adopted ? _self.adopted : adopted // ignore: cast_nullable_to_non_nullable
as IotDevice?,ignored: null == ignored ? _self.ignored : ignored // ignore: cast_nullable_to_non_nullable
as bool,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of IotAdoptState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DiscoveredDeviceCopyWith<$Res> get discovered {
  
  return $DiscoveredDeviceCopyWith<$Res>(_self.discovered, (value) {
    return _then(_self.copyWith(discovered: value));
  });
}/// Create a copy of IotAdoptState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$IotDeviceCopyWith<$Res>? get adopted {
    if (_self.adopted == null) {
    return null;
  }

  return $IotDeviceCopyWith<$Res>(_self.adopted!, (value) {
    return _then(_self.copyWith(adopted: value));
  });
}
}

// dart format on
