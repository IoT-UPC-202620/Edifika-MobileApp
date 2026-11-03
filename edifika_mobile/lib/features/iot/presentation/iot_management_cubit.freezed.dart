// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'iot_management_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$IotManagementState {

/// Carga de la lista de edificios.
 LoadStatus get buildingsStatus; List<Building> get buildings; int? get selectedBuildingId;/// Carga de gateways y dispositivos del edificio elegido.
 LoadStatus get status; String? get error; List<IotGateway> get gateways; List<IotDevice> get devices;/// Telemetría por `deviceCode`. Es complementaria: si el servicio falla,
/// los dispositivos se muestran igual y se avisa con [telemetryUnavailable].
 Map<String, DeviceTelemetry> get telemetry; bool get telemetryUnavailable;/// Momento de la última carga exitosa (para "Actualizado hace X s").
 DateTime? get updatedAt;
/// Create a copy of IotManagementState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$IotManagementStateCopyWith<IotManagementState> get copyWith => _$IotManagementStateCopyWithImpl<IotManagementState>(this as IotManagementState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is IotManagementState&&(identical(other.buildingsStatus, buildingsStatus) || other.buildingsStatus == buildingsStatus)&&const DeepCollectionEquality().equals(other.buildings, buildings)&&(identical(other.selectedBuildingId, selectedBuildingId) || other.selectedBuildingId == selectedBuildingId)&&(identical(other.status, status) || other.status == status)&&(identical(other.error, error) || other.error == error)&&const DeepCollectionEquality().equals(other.gateways, gateways)&&const DeepCollectionEquality().equals(other.devices, devices)&&const DeepCollectionEquality().equals(other.telemetry, telemetry)&&(identical(other.telemetryUnavailable, telemetryUnavailable) || other.telemetryUnavailable == telemetryUnavailable)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}


@override
int get hashCode => Object.hash(runtimeType,buildingsStatus,const DeepCollectionEquality().hash(buildings),selectedBuildingId,status,error,const DeepCollectionEquality().hash(gateways),const DeepCollectionEquality().hash(devices),const DeepCollectionEquality().hash(telemetry),telemetryUnavailable,updatedAt);

@override
String toString() {
  return 'IotManagementState(buildingsStatus: $buildingsStatus, buildings: $buildings, selectedBuildingId: $selectedBuildingId, status: $status, error: $error, gateways: $gateways, devices: $devices, telemetry: $telemetry, telemetryUnavailable: $telemetryUnavailable, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $IotManagementStateCopyWith<$Res>  {
  factory $IotManagementStateCopyWith(IotManagementState value, $Res Function(IotManagementState) _then) = _$IotManagementStateCopyWithImpl;
@useResult
$Res call({
 LoadStatus buildingsStatus, List<Building> buildings, int? selectedBuildingId, LoadStatus status, String? error, List<IotGateway> gateways, List<IotDevice> devices, Map<String, DeviceTelemetry> telemetry, bool telemetryUnavailable, DateTime? updatedAt
});




}
/// @nodoc
class _$IotManagementStateCopyWithImpl<$Res>
    implements $IotManagementStateCopyWith<$Res> {
  _$IotManagementStateCopyWithImpl(this._self, this._then);

  final IotManagementState _self;
  final $Res Function(IotManagementState) _then;

/// Create a copy of IotManagementState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? buildingsStatus = null,Object? buildings = null,Object? selectedBuildingId = freezed,Object? status = null,Object? error = freezed,Object? gateways = null,Object? devices = null,Object? telemetry = null,Object? telemetryUnavailable = null,Object? updatedAt = freezed,}) {
  return _then(_self.copyWith(
buildingsStatus: null == buildingsStatus ? _self.buildingsStatus : buildingsStatus // ignore: cast_nullable_to_non_nullable
as LoadStatus,buildings: null == buildings ? _self.buildings : buildings // ignore: cast_nullable_to_non_nullable
as List<Building>,selectedBuildingId: freezed == selectedBuildingId ? _self.selectedBuildingId : selectedBuildingId // ignore: cast_nullable_to_non_nullable
as int?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as LoadStatus,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,gateways: null == gateways ? _self.gateways : gateways // ignore: cast_nullable_to_non_nullable
as List<IotGateway>,devices: null == devices ? _self.devices : devices // ignore: cast_nullable_to_non_nullable
as List<IotDevice>,telemetry: null == telemetry ? _self.telemetry : telemetry // ignore: cast_nullable_to_non_nullable
as Map<String, DeviceTelemetry>,telemetryUnavailable: null == telemetryUnavailable ? _self.telemetryUnavailable : telemetryUnavailable // ignore: cast_nullable_to_non_nullable
as bool,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [IotManagementState].
extension IotManagementStatePatterns on IotManagementState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _IotManagementState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _IotManagementState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _IotManagementState value)  $default,){
final _that = this;
switch (_that) {
case _IotManagementState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _IotManagementState value)?  $default,){
final _that = this;
switch (_that) {
case _IotManagementState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( LoadStatus buildingsStatus,  List<Building> buildings,  int? selectedBuildingId,  LoadStatus status,  String? error,  List<IotGateway> gateways,  List<IotDevice> devices,  Map<String, DeviceTelemetry> telemetry,  bool telemetryUnavailable,  DateTime? updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _IotManagementState() when $default != null:
return $default(_that.buildingsStatus,_that.buildings,_that.selectedBuildingId,_that.status,_that.error,_that.gateways,_that.devices,_that.telemetry,_that.telemetryUnavailable,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( LoadStatus buildingsStatus,  List<Building> buildings,  int? selectedBuildingId,  LoadStatus status,  String? error,  List<IotGateway> gateways,  List<IotDevice> devices,  Map<String, DeviceTelemetry> telemetry,  bool telemetryUnavailable,  DateTime? updatedAt)  $default,) {final _that = this;
switch (_that) {
case _IotManagementState():
return $default(_that.buildingsStatus,_that.buildings,_that.selectedBuildingId,_that.status,_that.error,_that.gateways,_that.devices,_that.telemetry,_that.telemetryUnavailable,_that.updatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( LoadStatus buildingsStatus,  List<Building> buildings,  int? selectedBuildingId,  LoadStatus status,  String? error,  List<IotGateway> gateways,  List<IotDevice> devices,  Map<String, DeviceTelemetry> telemetry,  bool telemetryUnavailable,  DateTime? updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _IotManagementState() when $default != null:
return $default(_that.buildingsStatus,_that.buildings,_that.selectedBuildingId,_that.status,_that.error,_that.gateways,_that.devices,_that.telemetry,_that.telemetryUnavailable,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc


class _IotManagementState extends IotManagementState {
  const _IotManagementState({this.buildingsStatus = LoadStatus.loading, final  List<Building> buildings = const <Building>[], this.selectedBuildingId, this.status = LoadStatus.loading, this.error, final  List<IotGateway> gateways = const <IotGateway>[], final  List<IotDevice> devices = const <IotDevice>[], final  Map<String, DeviceTelemetry> telemetry = const <String, DeviceTelemetry>{}, this.telemetryUnavailable = false, this.updatedAt}): _buildings = buildings,_gateways = gateways,_devices = devices,_telemetry = telemetry,super._();
  

/// Carga de la lista de edificios.
@override@JsonKey() final  LoadStatus buildingsStatus;
 final  List<Building> _buildings;
@override@JsonKey() List<Building> get buildings {
  if (_buildings is EqualUnmodifiableListView) return _buildings;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_buildings);
}

@override final  int? selectedBuildingId;
/// Carga de gateways y dispositivos del edificio elegido.
@override@JsonKey() final  LoadStatus status;
@override final  String? error;
 final  List<IotGateway> _gateways;
@override@JsonKey() List<IotGateway> get gateways {
  if (_gateways is EqualUnmodifiableListView) return _gateways;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_gateways);
}

 final  List<IotDevice> _devices;
@override@JsonKey() List<IotDevice> get devices {
  if (_devices is EqualUnmodifiableListView) return _devices;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_devices);
}

/// Telemetría por `deviceCode`. Es complementaria: si el servicio falla,
/// los dispositivos se muestran igual y se avisa con [telemetryUnavailable].
 final  Map<String, DeviceTelemetry> _telemetry;
/// Telemetría por `deviceCode`. Es complementaria: si el servicio falla,
/// los dispositivos se muestran igual y se avisa con [telemetryUnavailable].
@override@JsonKey() Map<String, DeviceTelemetry> get telemetry {
  if (_telemetry is EqualUnmodifiableMapView) return _telemetry;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_telemetry);
}

@override@JsonKey() final  bool telemetryUnavailable;
/// Momento de la última carga exitosa (para "Actualizado hace X s").
@override final  DateTime? updatedAt;

/// Create a copy of IotManagementState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$IotManagementStateCopyWith<_IotManagementState> get copyWith => __$IotManagementStateCopyWithImpl<_IotManagementState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _IotManagementState&&(identical(other.buildingsStatus, buildingsStatus) || other.buildingsStatus == buildingsStatus)&&const DeepCollectionEquality().equals(other._buildings, _buildings)&&(identical(other.selectedBuildingId, selectedBuildingId) || other.selectedBuildingId == selectedBuildingId)&&(identical(other.status, status) || other.status == status)&&(identical(other.error, error) || other.error == error)&&const DeepCollectionEquality().equals(other._gateways, _gateways)&&const DeepCollectionEquality().equals(other._devices, _devices)&&const DeepCollectionEquality().equals(other._telemetry, _telemetry)&&(identical(other.telemetryUnavailable, telemetryUnavailable) || other.telemetryUnavailable == telemetryUnavailable)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}


@override
int get hashCode => Object.hash(runtimeType,buildingsStatus,const DeepCollectionEquality().hash(_buildings),selectedBuildingId,status,error,const DeepCollectionEquality().hash(_gateways),const DeepCollectionEquality().hash(_devices),const DeepCollectionEquality().hash(_telemetry),telemetryUnavailable,updatedAt);

@override
String toString() {
  return 'IotManagementState(buildingsStatus: $buildingsStatus, buildings: $buildings, selectedBuildingId: $selectedBuildingId, status: $status, error: $error, gateways: $gateways, devices: $devices, telemetry: $telemetry, telemetryUnavailable: $telemetryUnavailable, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$IotManagementStateCopyWith<$Res> implements $IotManagementStateCopyWith<$Res> {
  factory _$IotManagementStateCopyWith(_IotManagementState value, $Res Function(_IotManagementState) _then) = __$IotManagementStateCopyWithImpl;
@override @useResult
$Res call({
 LoadStatus buildingsStatus, List<Building> buildings, int? selectedBuildingId, LoadStatus status, String? error, List<IotGateway> gateways, List<IotDevice> devices, Map<String, DeviceTelemetry> telemetry, bool telemetryUnavailable, DateTime? updatedAt
});




}
/// @nodoc
class __$IotManagementStateCopyWithImpl<$Res>
    implements _$IotManagementStateCopyWith<$Res> {
  __$IotManagementStateCopyWithImpl(this._self, this._then);

  final _IotManagementState _self;
  final $Res Function(_IotManagementState) _then;

/// Create a copy of IotManagementState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? buildingsStatus = null,Object? buildings = null,Object? selectedBuildingId = freezed,Object? status = null,Object? error = freezed,Object? gateways = null,Object? devices = null,Object? telemetry = null,Object? telemetryUnavailable = null,Object? updatedAt = freezed,}) {
  return _then(_IotManagementState(
buildingsStatus: null == buildingsStatus ? _self.buildingsStatus : buildingsStatus // ignore: cast_nullable_to_non_nullable
as LoadStatus,buildings: null == buildings ? _self._buildings : buildings // ignore: cast_nullable_to_non_nullable
as List<Building>,selectedBuildingId: freezed == selectedBuildingId ? _self.selectedBuildingId : selectedBuildingId // ignore: cast_nullable_to_non_nullable
as int?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as LoadStatus,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,gateways: null == gateways ? _self._gateways : gateways // ignore: cast_nullable_to_non_nullable
as List<IotGateway>,devices: null == devices ? _self._devices : devices // ignore: cast_nullable_to_non_nullable
as List<IotDevice>,telemetry: null == telemetry ? _self._telemetry : telemetry // ignore: cast_nullable_to_non_nullable
as Map<String, DeviceTelemetry>,telemetryUnavailable: null == telemetryUnavailable ? _self.telemetryUnavailable : telemetryUnavailable // ignore: cast_nullable_to_non_nullable
as bool,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
