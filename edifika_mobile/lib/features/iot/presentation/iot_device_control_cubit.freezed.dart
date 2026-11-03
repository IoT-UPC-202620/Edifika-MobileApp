// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'iot_device_control_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$IotDeviceControlState {

 IotDevice get device;/// Últimas lecturas del dispositivo; se refrescan mientras la pantalla está abierta.
 DeviceTelemetry? get telemetry;/// Momento de la última actualización exitosa del dispositivo.
 DateTime? get updatedAt;/// Última reserva creada desde esta pantalla.
 DoorReservation? get reservation; bool get reserving; LedCommandStatus get ledStatus; String? get requestedColor;/// Motivo cuando el backend o el nodo rechazan el color.
 String? get ledError;/// Sesión de modo registro en el lector (`ACTIVE`, `CAPTURED`, `EXPIRED` o `CANCELLED`).
 CardEnrollment? get enrollment; bool get enrolling; int get enrollmentSecondsLeft; List<UserProfile> get residents; bool get loadingResidents; int? get selectedResidentId; bool get creatingCredential; AccessCredential? get createdCredential; String? get enrollmentError;/// Aviso puntual para un SnackBar.
 String? get message;
/// Create a copy of IotDeviceControlState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$IotDeviceControlStateCopyWith<IotDeviceControlState> get copyWith => _$IotDeviceControlStateCopyWithImpl<IotDeviceControlState>(this as IotDeviceControlState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is IotDeviceControlState&&(identical(other.device, device) || other.device == device)&&(identical(other.telemetry, telemetry) || other.telemetry == telemetry)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.reservation, reservation) || other.reservation == reservation)&&(identical(other.reserving, reserving) || other.reserving == reserving)&&(identical(other.ledStatus, ledStatus) || other.ledStatus == ledStatus)&&(identical(other.requestedColor, requestedColor) || other.requestedColor == requestedColor)&&(identical(other.ledError, ledError) || other.ledError == ledError)&&(identical(other.enrollment, enrollment) || other.enrollment == enrollment)&&(identical(other.enrolling, enrolling) || other.enrolling == enrolling)&&(identical(other.enrollmentSecondsLeft, enrollmentSecondsLeft) || other.enrollmentSecondsLeft == enrollmentSecondsLeft)&&const DeepCollectionEquality().equals(other.residents, residents)&&(identical(other.loadingResidents, loadingResidents) || other.loadingResidents == loadingResidents)&&(identical(other.selectedResidentId, selectedResidentId) || other.selectedResidentId == selectedResidentId)&&(identical(other.creatingCredential, creatingCredential) || other.creatingCredential == creatingCredential)&&(identical(other.createdCredential, createdCredential) || other.createdCredential == createdCredential)&&(identical(other.enrollmentError, enrollmentError) || other.enrollmentError == enrollmentError)&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,device,telemetry,updatedAt,reservation,reserving,ledStatus,requestedColor,ledError,enrollment,enrolling,enrollmentSecondsLeft,const DeepCollectionEquality().hash(residents),loadingResidents,selectedResidentId,creatingCredential,createdCredential,enrollmentError,message);

@override
String toString() {
  return 'IotDeviceControlState(device: $device, telemetry: $telemetry, updatedAt: $updatedAt, reservation: $reservation, reserving: $reserving, ledStatus: $ledStatus, requestedColor: $requestedColor, ledError: $ledError, enrollment: $enrollment, enrolling: $enrolling, enrollmentSecondsLeft: $enrollmentSecondsLeft, residents: $residents, loadingResidents: $loadingResidents, selectedResidentId: $selectedResidentId, creatingCredential: $creatingCredential, createdCredential: $createdCredential, enrollmentError: $enrollmentError, message: $message)';
}


}

/// @nodoc
abstract mixin class $IotDeviceControlStateCopyWith<$Res>  {
  factory $IotDeviceControlStateCopyWith(IotDeviceControlState value, $Res Function(IotDeviceControlState) _then) = _$IotDeviceControlStateCopyWithImpl;
@useResult
$Res call({
 IotDevice device, DeviceTelemetry? telemetry, DateTime? updatedAt, DoorReservation? reservation, bool reserving, LedCommandStatus ledStatus, String? requestedColor, String? ledError, CardEnrollment? enrollment, bool enrolling, int enrollmentSecondsLeft, List<UserProfile> residents, bool loadingResidents, int? selectedResidentId, bool creatingCredential, AccessCredential? createdCredential, String? enrollmentError, String? message
});


$IotDeviceCopyWith<$Res> get device;$DeviceTelemetryCopyWith<$Res>? get telemetry;$DoorReservationCopyWith<$Res>? get reservation;$CardEnrollmentCopyWith<$Res>? get enrollment;$AccessCredentialCopyWith<$Res>? get createdCredential;

}
/// @nodoc
class _$IotDeviceControlStateCopyWithImpl<$Res>
    implements $IotDeviceControlStateCopyWith<$Res> {
  _$IotDeviceControlStateCopyWithImpl(this._self, this._then);

  final IotDeviceControlState _self;
  final $Res Function(IotDeviceControlState) _then;

/// Create a copy of IotDeviceControlState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? device = null,Object? telemetry = freezed,Object? updatedAt = freezed,Object? reservation = freezed,Object? reserving = null,Object? ledStatus = null,Object? requestedColor = freezed,Object? ledError = freezed,Object? enrollment = freezed,Object? enrolling = null,Object? enrollmentSecondsLeft = null,Object? residents = null,Object? loadingResidents = null,Object? selectedResidentId = freezed,Object? creatingCredential = null,Object? createdCredential = freezed,Object? enrollmentError = freezed,Object? message = freezed,}) {
  return _then(_self.copyWith(
device: null == device ? _self.device : device // ignore: cast_nullable_to_non_nullable
as IotDevice,telemetry: freezed == telemetry ? _self.telemetry : telemetry // ignore: cast_nullable_to_non_nullable
as DeviceTelemetry?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,reservation: freezed == reservation ? _self.reservation : reservation // ignore: cast_nullable_to_non_nullable
as DoorReservation?,reserving: null == reserving ? _self.reserving : reserving // ignore: cast_nullable_to_non_nullable
as bool,ledStatus: null == ledStatus ? _self.ledStatus : ledStatus // ignore: cast_nullable_to_non_nullable
as LedCommandStatus,requestedColor: freezed == requestedColor ? _self.requestedColor : requestedColor // ignore: cast_nullable_to_non_nullable
as String?,ledError: freezed == ledError ? _self.ledError : ledError // ignore: cast_nullable_to_non_nullable
as String?,enrollment: freezed == enrollment ? _self.enrollment : enrollment // ignore: cast_nullable_to_non_nullable
as CardEnrollment?,enrolling: null == enrolling ? _self.enrolling : enrolling // ignore: cast_nullable_to_non_nullable
as bool,enrollmentSecondsLeft: null == enrollmentSecondsLeft ? _self.enrollmentSecondsLeft : enrollmentSecondsLeft // ignore: cast_nullable_to_non_nullable
as int,residents: null == residents ? _self.residents : residents // ignore: cast_nullable_to_non_nullable
as List<UserProfile>,loadingResidents: null == loadingResidents ? _self.loadingResidents : loadingResidents // ignore: cast_nullable_to_non_nullable
as bool,selectedResidentId: freezed == selectedResidentId ? _self.selectedResidentId : selectedResidentId // ignore: cast_nullable_to_non_nullable
as int?,creatingCredential: null == creatingCredential ? _self.creatingCredential : creatingCredential // ignore: cast_nullable_to_non_nullable
as bool,createdCredential: freezed == createdCredential ? _self.createdCredential : createdCredential // ignore: cast_nullable_to_non_nullable
as AccessCredential?,enrollmentError: freezed == enrollmentError ? _self.enrollmentError : enrollmentError // ignore: cast_nullable_to_non_nullable
as String?,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of IotDeviceControlState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$IotDeviceCopyWith<$Res> get device {
  
  return $IotDeviceCopyWith<$Res>(_self.device, (value) {
    return _then(_self.copyWith(device: value));
  });
}/// Create a copy of IotDeviceControlState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DeviceTelemetryCopyWith<$Res>? get telemetry {
    if (_self.telemetry == null) {
    return null;
  }

  return $DeviceTelemetryCopyWith<$Res>(_self.telemetry!, (value) {
    return _then(_self.copyWith(telemetry: value));
  });
}/// Create a copy of IotDeviceControlState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DoorReservationCopyWith<$Res>? get reservation {
    if (_self.reservation == null) {
    return null;
  }

  return $DoorReservationCopyWith<$Res>(_self.reservation!, (value) {
    return _then(_self.copyWith(reservation: value));
  });
}/// Create a copy of IotDeviceControlState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CardEnrollmentCopyWith<$Res>? get enrollment {
    if (_self.enrollment == null) {
    return null;
  }

  return $CardEnrollmentCopyWith<$Res>(_self.enrollment!, (value) {
    return _then(_self.copyWith(enrollment: value));
  });
}/// Create a copy of IotDeviceControlState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AccessCredentialCopyWith<$Res>? get createdCredential {
    if (_self.createdCredential == null) {
    return null;
  }

  return $AccessCredentialCopyWith<$Res>(_self.createdCredential!, (value) {
    return _then(_self.copyWith(createdCredential: value));
  });
}
}


/// Adds pattern-matching-related methods to [IotDeviceControlState].
extension IotDeviceControlStatePatterns on IotDeviceControlState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _IotDeviceControlState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _IotDeviceControlState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _IotDeviceControlState value)  $default,){
final _that = this;
switch (_that) {
case _IotDeviceControlState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _IotDeviceControlState value)?  $default,){
final _that = this;
switch (_that) {
case _IotDeviceControlState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( IotDevice device,  DeviceTelemetry? telemetry,  DateTime? updatedAt,  DoorReservation? reservation,  bool reserving,  LedCommandStatus ledStatus,  String? requestedColor,  String? ledError,  CardEnrollment? enrollment,  bool enrolling,  int enrollmentSecondsLeft,  List<UserProfile> residents,  bool loadingResidents,  int? selectedResidentId,  bool creatingCredential,  AccessCredential? createdCredential,  String? enrollmentError,  String? message)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _IotDeviceControlState() when $default != null:
return $default(_that.device,_that.telemetry,_that.updatedAt,_that.reservation,_that.reserving,_that.ledStatus,_that.requestedColor,_that.ledError,_that.enrollment,_that.enrolling,_that.enrollmentSecondsLeft,_that.residents,_that.loadingResidents,_that.selectedResidentId,_that.creatingCredential,_that.createdCredential,_that.enrollmentError,_that.message);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( IotDevice device,  DeviceTelemetry? telemetry,  DateTime? updatedAt,  DoorReservation? reservation,  bool reserving,  LedCommandStatus ledStatus,  String? requestedColor,  String? ledError,  CardEnrollment? enrollment,  bool enrolling,  int enrollmentSecondsLeft,  List<UserProfile> residents,  bool loadingResidents,  int? selectedResidentId,  bool creatingCredential,  AccessCredential? createdCredential,  String? enrollmentError,  String? message)  $default,) {final _that = this;
switch (_that) {
case _IotDeviceControlState():
return $default(_that.device,_that.telemetry,_that.updatedAt,_that.reservation,_that.reserving,_that.ledStatus,_that.requestedColor,_that.ledError,_that.enrollment,_that.enrolling,_that.enrollmentSecondsLeft,_that.residents,_that.loadingResidents,_that.selectedResidentId,_that.creatingCredential,_that.createdCredential,_that.enrollmentError,_that.message);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( IotDevice device,  DeviceTelemetry? telemetry,  DateTime? updatedAt,  DoorReservation? reservation,  bool reserving,  LedCommandStatus ledStatus,  String? requestedColor,  String? ledError,  CardEnrollment? enrollment,  bool enrolling,  int enrollmentSecondsLeft,  List<UserProfile> residents,  bool loadingResidents,  int? selectedResidentId,  bool creatingCredential,  AccessCredential? createdCredential,  String? enrollmentError,  String? message)?  $default,) {final _that = this;
switch (_that) {
case _IotDeviceControlState() when $default != null:
return $default(_that.device,_that.telemetry,_that.updatedAt,_that.reservation,_that.reserving,_that.ledStatus,_that.requestedColor,_that.ledError,_that.enrollment,_that.enrolling,_that.enrollmentSecondsLeft,_that.residents,_that.loadingResidents,_that.selectedResidentId,_that.creatingCredential,_that.createdCredential,_that.enrollmentError,_that.message);case _:
  return null;

}
}

}

/// @nodoc


class _IotDeviceControlState extends IotDeviceControlState {
  const _IotDeviceControlState({required this.device, this.telemetry, this.updatedAt, this.reservation, this.reserving = false, this.ledStatus = LedCommandStatus.idle, this.requestedColor, this.ledError, this.enrollment, this.enrolling = false, this.enrollmentSecondsLeft = 0, final  List<UserProfile> residents = const <UserProfile>[], this.loadingResidents = false, this.selectedResidentId, this.creatingCredential = false, this.createdCredential, this.enrollmentError, this.message}): _residents = residents,super._();
  

@override final  IotDevice device;
/// Últimas lecturas del dispositivo; se refrescan mientras la pantalla está abierta.
@override final  DeviceTelemetry? telemetry;
/// Momento de la última actualización exitosa del dispositivo.
@override final  DateTime? updatedAt;
/// Última reserva creada desde esta pantalla.
@override final  DoorReservation? reservation;
@override@JsonKey() final  bool reserving;
@override@JsonKey() final  LedCommandStatus ledStatus;
@override final  String? requestedColor;
/// Motivo cuando el backend o el nodo rechazan el color.
@override final  String? ledError;
/// Sesión de modo registro en el lector (`ACTIVE`, `CAPTURED`, `EXPIRED` o `CANCELLED`).
@override final  CardEnrollment? enrollment;
@override@JsonKey() final  bool enrolling;
@override@JsonKey() final  int enrollmentSecondsLeft;
 final  List<UserProfile> _residents;
@override@JsonKey() List<UserProfile> get residents {
  if (_residents is EqualUnmodifiableListView) return _residents;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_residents);
}

@override@JsonKey() final  bool loadingResidents;
@override final  int? selectedResidentId;
@override@JsonKey() final  bool creatingCredential;
@override final  AccessCredential? createdCredential;
@override final  String? enrollmentError;
/// Aviso puntual para un SnackBar.
@override final  String? message;

/// Create a copy of IotDeviceControlState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$IotDeviceControlStateCopyWith<_IotDeviceControlState> get copyWith => __$IotDeviceControlStateCopyWithImpl<_IotDeviceControlState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _IotDeviceControlState&&(identical(other.device, device) || other.device == device)&&(identical(other.telemetry, telemetry) || other.telemetry == telemetry)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.reservation, reservation) || other.reservation == reservation)&&(identical(other.reserving, reserving) || other.reserving == reserving)&&(identical(other.ledStatus, ledStatus) || other.ledStatus == ledStatus)&&(identical(other.requestedColor, requestedColor) || other.requestedColor == requestedColor)&&(identical(other.ledError, ledError) || other.ledError == ledError)&&(identical(other.enrollment, enrollment) || other.enrollment == enrollment)&&(identical(other.enrolling, enrolling) || other.enrolling == enrolling)&&(identical(other.enrollmentSecondsLeft, enrollmentSecondsLeft) || other.enrollmentSecondsLeft == enrollmentSecondsLeft)&&const DeepCollectionEquality().equals(other._residents, _residents)&&(identical(other.loadingResidents, loadingResidents) || other.loadingResidents == loadingResidents)&&(identical(other.selectedResidentId, selectedResidentId) || other.selectedResidentId == selectedResidentId)&&(identical(other.creatingCredential, creatingCredential) || other.creatingCredential == creatingCredential)&&(identical(other.createdCredential, createdCredential) || other.createdCredential == createdCredential)&&(identical(other.enrollmentError, enrollmentError) || other.enrollmentError == enrollmentError)&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,device,telemetry,updatedAt,reservation,reserving,ledStatus,requestedColor,ledError,enrollment,enrolling,enrollmentSecondsLeft,const DeepCollectionEquality().hash(_residents),loadingResidents,selectedResidentId,creatingCredential,createdCredential,enrollmentError,message);

@override
String toString() {
  return 'IotDeviceControlState(device: $device, telemetry: $telemetry, updatedAt: $updatedAt, reservation: $reservation, reserving: $reserving, ledStatus: $ledStatus, requestedColor: $requestedColor, ledError: $ledError, enrollment: $enrollment, enrolling: $enrolling, enrollmentSecondsLeft: $enrollmentSecondsLeft, residents: $residents, loadingResidents: $loadingResidents, selectedResidentId: $selectedResidentId, creatingCredential: $creatingCredential, createdCredential: $createdCredential, enrollmentError: $enrollmentError, message: $message)';
}


}

/// @nodoc
abstract mixin class _$IotDeviceControlStateCopyWith<$Res> implements $IotDeviceControlStateCopyWith<$Res> {
  factory _$IotDeviceControlStateCopyWith(_IotDeviceControlState value, $Res Function(_IotDeviceControlState) _then) = __$IotDeviceControlStateCopyWithImpl;
@override @useResult
$Res call({
 IotDevice device, DeviceTelemetry? telemetry, DateTime? updatedAt, DoorReservation? reservation, bool reserving, LedCommandStatus ledStatus, String? requestedColor, String? ledError, CardEnrollment? enrollment, bool enrolling, int enrollmentSecondsLeft, List<UserProfile> residents, bool loadingResidents, int? selectedResidentId, bool creatingCredential, AccessCredential? createdCredential, String? enrollmentError, String? message
});


@override $IotDeviceCopyWith<$Res> get device;@override $DeviceTelemetryCopyWith<$Res>? get telemetry;@override $DoorReservationCopyWith<$Res>? get reservation;@override $CardEnrollmentCopyWith<$Res>? get enrollment;@override $AccessCredentialCopyWith<$Res>? get createdCredential;

}
/// @nodoc
class __$IotDeviceControlStateCopyWithImpl<$Res>
    implements _$IotDeviceControlStateCopyWith<$Res> {
  __$IotDeviceControlStateCopyWithImpl(this._self, this._then);

  final _IotDeviceControlState _self;
  final $Res Function(_IotDeviceControlState) _then;

/// Create a copy of IotDeviceControlState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? device = null,Object? telemetry = freezed,Object? updatedAt = freezed,Object? reservation = freezed,Object? reserving = null,Object? ledStatus = null,Object? requestedColor = freezed,Object? ledError = freezed,Object? enrollment = freezed,Object? enrolling = null,Object? enrollmentSecondsLeft = null,Object? residents = null,Object? loadingResidents = null,Object? selectedResidentId = freezed,Object? creatingCredential = null,Object? createdCredential = freezed,Object? enrollmentError = freezed,Object? message = freezed,}) {
  return _then(_IotDeviceControlState(
device: null == device ? _self.device : device // ignore: cast_nullable_to_non_nullable
as IotDevice,telemetry: freezed == telemetry ? _self.telemetry : telemetry // ignore: cast_nullable_to_non_nullable
as DeviceTelemetry?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,reservation: freezed == reservation ? _self.reservation : reservation // ignore: cast_nullable_to_non_nullable
as DoorReservation?,reserving: null == reserving ? _self.reserving : reserving // ignore: cast_nullable_to_non_nullable
as bool,ledStatus: null == ledStatus ? _self.ledStatus : ledStatus // ignore: cast_nullable_to_non_nullable
as LedCommandStatus,requestedColor: freezed == requestedColor ? _self.requestedColor : requestedColor // ignore: cast_nullable_to_non_nullable
as String?,ledError: freezed == ledError ? _self.ledError : ledError // ignore: cast_nullable_to_non_nullable
as String?,enrollment: freezed == enrollment ? _self.enrollment : enrollment // ignore: cast_nullable_to_non_nullable
as CardEnrollment?,enrolling: null == enrolling ? _self.enrolling : enrolling // ignore: cast_nullable_to_non_nullable
as bool,enrollmentSecondsLeft: null == enrollmentSecondsLeft ? _self.enrollmentSecondsLeft : enrollmentSecondsLeft // ignore: cast_nullable_to_non_nullable
as int,residents: null == residents ? _self._residents : residents // ignore: cast_nullable_to_non_nullable
as List<UserProfile>,loadingResidents: null == loadingResidents ? _self.loadingResidents : loadingResidents // ignore: cast_nullable_to_non_nullable
as bool,selectedResidentId: freezed == selectedResidentId ? _self.selectedResidentId : selectedResidentId // ignore: cast_nullable_to_non_nullable
as int?,creatingCredential: null == creatingCredential ? _self.creatingCredential : creatingCredential // ignore: cast_nullable_to_non_nullable
as bool,createdCredential: freezed == createdCredential ? _self.createdCredential : createdCredential // ignore: cast_nullable_to_non_nullable
as AccessCredential?,enrollmentError: freezed == enrollmentError ? _self.enrollmentError : enrollmentError // ignore: cast_nullable_to_non_nullable
as String?,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of IotDeviceControlState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$IotDeviceCopyWith<$Res> get device {
  
  return $IotDeviceCopyWith<$Res>(_self.device, (value) {
    return _then(_self.copyWith(device: value));
  });
}/// Create a copy of IotDeviceControlState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DeviceTelemetryCopyWith<$Res>? get telemetry {
    if (_self.telemetry == null) {
    return null;
  }

  return $DeviceTelemetryCopyWith<$Res>(_self.telemetry!, (value) {
    return _then(_self.copyWith(telemetry: value));
  });
}/// Create a copy of IotDeviceControlState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DoorReservationCopyWith<$Res>? get reservation {
    if (_self.reservation == null) {
    return null;
  }

  return $DoorReservationCopyWith<$Res>(_self.reservation!, (value) {
    return _then(_self.copyWith(reservation: value));
  });
}/// Create a copy of IotDeviceControlState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CardEnrollmentCopyWith<$Res>? get enrollment {
    if (_self.enrollment == null) {
    return null;
  }

  return $CardEnrollmentCopyWith<$Res>(_self.enrollment!, (value) {
    return _then(_self.copyWith(enrollment: value));
  });
}/// Create a copy of IotDeviceControlState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AccessCredentialCopyWith<$Res>? get createdCredential {
    if (_self.createdCredential == null) {
    return null;
  }

  return $AccessCredentialCopyWith<$Res>(_self.createdCredential!, (value) {
    return _then(_self.copyWith(createdCredential: value));
  });
}
}

// dart format on
