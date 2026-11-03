// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'iot_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$IotGateway {

 int get id; String get gatewayCode; int get buildingId; String get name;/// `ONLINE`, `OFFLINE`, `PROVISIONED` o `DECOMMISSIONED`.
 String get status; int get syncVersion; String? get lastSyncAt; String? get createdAt;
/// Create a copy of IotGateway
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$IotGatewayCopyWith<IotGateway> get copyWith => _$IotGatewayCopyWithImpl<IotGateway>(this as IotGateway, _$identity);

  /// Serializes this IotGateway to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is IotGateway&&(identical(other.id, id) || other.id == id)&&(identical(other.gatewayCode, gatewayCode) || other.gatewayCode == gatewayCode)&&(identical(other.buildingId, buildingId) || other.buildingId == buildingId)&&(identical(other.name, name) || other.name == name)&&(identical(other.status, status) || other.status == status)&&(identical(other.syncVersion, syncVersion) || other.syncVersion == syncVersion)&&(identical(other.lastSyncAt, lastSyncAt) || other.lastSyncAt == lastSyncAt)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,gatewayCode,buildingId,name,status,syncVersion,lastSyncAt,createdAt);

@override
String toString() {
  return 'IotGateway(id: $id, gatewayCode: $gatewayCode, buildingId: $buildingId, name: $name, status: $status, syncVersion: $syncVersion, lastSyncAt: $lastSyncAt, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $IotGatewayCopyWith<$Res>  {
  factory $IotGatewayCopyWith(IotGateway value, $Res Function(IotGateway) _then) = _$IotGatewayCopyWithImpl;
@useResult
$Res call({
 int id, String gatewayCode, int buildingId, String name, String status, int syncVersion, String? lastSyncAt, String? createdAt
});




}
/// @nodoc
class _$IotGatewayCopyWithImpl<$Res>
    implements $IotGatewayCopyWith<$Res> {
  _$IotGatewayCopyWithImpl(this._self, this._then);

  final IotGateway _self;
  final $Res Function(IotGateway) _then;

/// Create a copy of IotGateway
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? gatewayCode = null,Object? buildingId = null,Object? name = null,Object? status = null,Object? syncVersion = null,Object? lastSyncAt = freezed,Object? createdAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,gatewayCode: null == gatewayCode ? _self.gatewayCode : gatewayCode // ignore: cast_nullable_to_non_nullable
as String,buildingId: null == buildingId ? _self.buildingId : buildingId // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,syncVersion: null == syncVersion ? _self.syncVersion : syncVersion // ignore: cast_nullable_to_non_nullable
as int,lastSyncAt: freezed == lastSyncAt ? _self.lastSyncAt : lastSyncAt // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [IotGateway].
extension IotGatewayPatterns on IotGateway {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _IotGateway value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _IotGateway() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _IotGateway value)  $default,){
final _that = this;
switch (_that) {
case _IotGateway():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _IotGateway value)?  $default,){
final _that = this;
switch (_that) {
case _IotGateway() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String gatewayCode,  int buildingId,  String name,  String status,  int syncVersion,  String? lastSyncAt,  String? createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _IotGateway() when $default != null:
return $default(_that.id,_that.gatewayCode,_that.buildingId,_that.name,_that.status,_that.syncVersion,_that.lastSyncAt,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String gatewayCode,  int buildingId,  String name,  String status,  int syncVersion,  String? lastSyncAt,  String? createdAt)  $default,) {final _that = this;
switch (_that) {
case _IotGateway():
return $default(_that.id,_that.gatewayCode,_that.buildingId,_that.name,_that.status,_that.syncVersion,_that.lastSyncAt,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String gatewayCode,  int buildingId,  String name,  String status,  int syncVersion,  String? lastSyncAt,  String? createdAt)?  $default,) {final _that = this;
switch (_that) {
case _IotGateway() when $default != null:
return $default(_that.id,_that.gatewayCode,_that.buildingId,_that.name,_that.status,_that.syncVersion,_that.lastSyncAt,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _IotGateway implements IotGateway {
  const _IotGateway({required this.id, required this.gatewayCode, required this.buildingId, required this.name, required this.status, this.syncVersion = 0, this.lastSyncAt, this.createdAt});
  factory _IotGateway.fromJson(Map<String, dynamic> json) => _$IotGatewayFromJson(json);

@override final  int id;
@override final  String gatewayCode;
@override final  int buildingId;
@override final  String name;
/// `ONLINE`, `OFFLINE`, `PROVISIONED` o `DECOMMISSIONED`.
@override final  String status;
@override@JsonKey() final  int syncVersion;
@override final  String? lastSyncAt;
@override final  String? createdAt;

/// Create a copy of IotGateway
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$IotGatewayCopyWith<_IotGateway> get copyWith => __$IotGatewayCopyWithImpl<_IotGateway>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$IotGatewayToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _IotGateway&&(identical(other.id, id) || other.id == id)&&(identical(other.gatewayCode, gatewayCode) || other.gatewayCode == gatewayCode)&&(identical(other.buildingId, buildingId) || other.buildingId == buildingId)&&(identical(other.name, name) || other.name == name)&&(identical(other.status, status) || other.status == status)&&(identical(other.syncVersion, syncVersion) || other.syncVersion == syncVersion)&&(identical(other.lastSyncAt, lastSyncAt) || other.lastSyncAt == lastSyncAt)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,gatewayCode,buildingId,name,status,syncVersion,lastSyncAt,createdAt);

@override
String toString() {
  return 'IotGateway(id: $id, gatewayCode: $gatewayCode, buildingId: $buildingId, name: $name, status: $status, syncVersion: $syncVersion, lastSyncAt: $lastSyncAt, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$IotGatewayCopyWith<$Res> implements $IotGatewayCopyWith<$Res> {
  factory _$IotGatewayCopyWith(_IotGateway value, $Res Function(_IotGateway) _then) = __$IotGatewayCopyWithImpl;
@override @useResult
$Res call({
 int id, String gatewayCode, int buildingId, String name, String status, int syncVersion, String? lastSyncAt, String? createdAt
});




}
/// @nodoc
class __$IotGatewayCopyWithImpl<$Res>
    implements _$IotGatewayCopyWith<$Res> {
  __$IotGatewayCopyWithImpl(this._self, this._then);

  final _IotGateway _self;
  final $Res Function(_IotGateway) _then;

/// Create a copy of IotGateway
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? gatewayCode = null,Object? buildingId = null,Object? name = null,Object? status = null,Object? syncVersion = null,Object? lastSyncAt = freezed,Object? createdAt = freezed,}) {
  return _then(_IotGateway(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,gatewayCode: null == gatewayCode ? _self.gatewayCode : gatewayCode // ignore: cast_nullable_to_non_nullable
as String,buildingId: null == buildingId ? _self.buildingId : buildingId // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,syncVersion: null == syncVersion ? _self.syncVersion : syncVersion // ignore: cast_nullable_to_non_nullable
as int,lastSyncAt: freezed == lastSyncAt ? _self.lastSyncAt : lastSyncAt // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$IotDevice {

 int get id; String get deviceCode; int get gatewayId; String get gatewayCode; int get buildingId; String get name; String get location; String get deviceType; List<String> get capabilities;/// `FREE_ACCESS` o `RESERVED`.
 String get accessMode; int? get activeReservationId; String? get ledColor; int get unlockSeconds; String? get firmwareVersion;/// `PROVISIONED`, `ACTIVE`, `MAINTENANCE`, `OFFLINE` o `DECOMMISSIONED`.
 String get status; String? get lastSeenAt; String? get createdAt;
/// Create a copy of IotDevice
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$IotDeviceCopyWith<IotDevice> get copyWith => _$IotDeviceCopyWithImpl<IotDevice>(this as IotDevice, _$identity);

  /// Serializes this IotDevice to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is IotDevice&&(identical(other.id, id) || other.id == id)&&(identical(other.deviceCode, deviceCode) || other.deviceCode == deviceCode)&&(identical(other.gatewayId, gatewayId) || other.gatewayId == gatewayId)&&(identical(other.gatewayCode, gatewayCode) || other.gatewayCode == gatewayCode)&&(identical(other.buildingId, buildingId) || other.buildingId == buildingId)&&(identical(other.name, name) || other.name == name)&&(identical(other.location, location) || other.location == location)&&(identical(other.deviceType, deviceType) || other.deviceType == deviceType)&&const DeepCollectionEquality().equals(other.capabilities, capabilities)&&(identical(other.accessMode, accessMode) || other.accessMode == accessMode)&&(identical(other.activeReservationId, activeReservationId) || other.activeReservationId == activeReservationId)&&(identical(other.ledColor, ledColor) || other.ledColor == ledColor)&&(identical(other.unlockSeconds, unlockSeconds) || other.unlockSeconds == unlockSeconds)&&(identical(other.firmwareVersion, firmwareVersion) || other.firmwareVersion == firmwareVersion)&&(identical(other.status, status) || other.status == status)&&(identical(other.lastSeenAt, lastSeenAt) || other.lastSeenAt == lastSeenAt)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,deviceCode,gatewayId,gatewayCode,buildingId,name,location,deviceType,const DeepCollectionEquality().hash(capabilities),accessMode,activeReservationId,ledColor,unlockSeconds,firmwareVersion,status,lastSeenAt,createdAt);

@override
String toString() {
  return 'IotDevice(id: $id, deviceCode: $deviceCode, gatewayId: $gatewayId, gatewayCode: $gatewayCode, buildingId: $buildingId, name: $name, location: $location, deviceType: $deviceType, capabilities: $capabilities, accessMode: $accessMode, activeReservationId: $activeReservationId, ledColor: $ledColor, unlockSeconds: $unlockSeconds, firmwareVersion: $firmwareVersion, status: $status, lastSeenAt: $lastSeenAt, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $IotDeviceCopyWith<$Res>  {
  factory $IotDeviceCopyWith(IotDevice value, $Res Function(IotDevice) _then) = _$IotDeviceCopyWithImpl;
@useResult
$Res call({
 int id, String deviceCode, int gatewayId, String gatewayCode, int buildingId, String name, String location, String deviceType, List<String> capabilities, String accessMode, int? activeReservationId, String? ledColor, int unlockSeconds, String? firmwareVersion, String status, String? lastSeenAt, String? createdAt
});




}
/// @nodoc
class _$IotDeviceCopyWithImpl<$Res>
    implements $IotDeviceCopyWith<$Res> {
  _$IotDeviceCopyWithImpl(this._self, this._then);

  final IotDevice _self;
  final $Res Function(IotDevice) _then;

/// Create a copy of IotDevice
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? deviceCode = null,Object? gatewayId = null,Object? gatewayCode = null,Object? buildingId = null,Object? name = null,Object? location = null,Object? deviceType = null,Object? capabilities = null,Object? accessMode = null,Object? activeReservationId = freezed,Object? ledColor = freezed,Object? unlockSeconds = null,Object? firmwareVersion = freezed,Object? status = null,Object? lastSeenAt = freezed,Object? createdAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,deviceCode: null == deviceCode ? _self.deviceCode : deviceCode // ignore: cast_nullable_to_non_nullable
as String,gatewayId: null == gatewayId ? _self.gatewayId : gatewayId // ignore: cast_nullable_to_non_nullable
as int,gatewayCode: null == gatewayCode ? _self.gatewayCode : gatewayCode // ignore: cast_nullable_to_non_nullable
as String,buildingId: null == buildingId ? _self.buildingId : buildingId // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String,deviceType: null == deviceType ? _self.deviceType : deviceType // ignore: cast_nullable_to_non_nullable
as String,capabilities: null == capabilities ? _self.capabilities : capabilities // ignore: cast_nullable_to_non_nullable
as List<String>,accessMode: null == accessMode ? _self.accessMode : accessMode // ignore: cast_nullable_to_non_nullable
as String,activeReservationId: freezed == activeReservationId ? _self.activeReservationId : activeReservationId // ignore: cast_nullable_to_non_nullable
as int?,ledColor: freezed == ledColor ? _self.ledColor : ledColor // ignore: cast_nullable_to_non_nullable
as String?,unlockSeconds: null == unlockSeconds ? _self.unlockSeconds : unlockSeconds // ignore: cast_nullable_to_non_nullable
as int,firmwareVersion: freezed == firmwareVersion ? _self.firmwareVersion : firmwareVersion // ignore: cast_nullable_to_non_nullable
as String?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,lastSeenAt: freezed == lastSeenAt ? _self.lastSeenAt : lastSeenAt // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [IotDevice].
extension IotDevicePatterns on IotDevice {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _IotDevice value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _IotDevice() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _IotDevice value)  $default,){
final _that = this;
switch (_that) {
case _IotDevice():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _IotDevice value)?  $default,){
final _that = this;
switch (_that) {
case _IotDevice() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String deviceCode,  int gatewayId,  String gatewayCode,  int buildingId,  String name,  String location,  String deviceType,  List<String> capabilities,  String accessMode,  int? activeReservationId,  String? ledColor,  int unlockSeconds,  String? firmwareVersion,  String status,  String? lastSeenAt,  String? createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _IotDevice() when $default != null:
return $default(_that.id,_that.deviceCode,_that.gatewayId,_that.gatewayCode,_that.buildingId,_that.name,_that.location,_that.deviceType,_that.capabilities,_that.accessMode,_that.activeReservationId,_that.ledColor,_that.unlockSeconds,_that.firmwareVersion,_that.status,_that.lastSeenAt,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String deviceCode,  int gatewayId,  String gatewayCode,  int buildingId,  String name,  String location,  String deviceType,  List<String> capabilities,  String accessMode,  int? activeReservationId,  String? ledColor,  int unlockSeconds,  String? firmwareVersion,  String status,  String? lastSeenAt,  String? createdAt)  $default,) {final _that = this;
switch (_that) {
case _IotDevice():
return $default(_that.id,_that.deviceCode,_that.gatewayId,_that.gatewayCode,_that.buildingId,_that.name,_that.location,_that.deviceType,_that.capabilities,_that.accessMode,_that.activeReservationId,_that.ledColor,_that.unlockSeconds,_that.firmwareVersion,_that.status,_that.lastSeenAt,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String deviceCode,  int gatewayId,  String gatewayCode,  int buildingId,  String name,  String location,  String deviceType,  List<String> capabilities,  String accessMode,  int? activeReservationId,  String? ledColor,  int unlockSeconds,  String? firmwareVersion,  String status,  String? lastSeenAt,  String? createdAt)?  $default,) {final _that = this;
switch (_that) {
case _IotDevice() when $default != null:
return $default(_that.id,_that.deviceCode,_that.gatewayId,_that.gatewayCode,_that.buildingId,_that.name,_that.location,_that.deviceType,_that.capabilities,_that.accessMode,_that.activeReservationId,_that.ledColor,_that.unlockSeconds,_that.firmwareVersion,_that.status,_that.lastSeenAt,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _IotDevice implements IotDevice {
  const _IotDevice({required this.id, required this.deviceCode, required this.gatewayId, this.gatewayCode = '', required this.buildingId, required this.name, this.location = '', this.deviceType = 'DOOR', final  List<String> capabilities = const <String>[], this.accessMode = 'FREE_ACCESS', this.activeReservationId, this.ledColor, this.unlockSeconds = 0, this.firmwareVersion, required this.status, this.lastSeenAt, this.createdAt}): _capabilities = capabilities;
  factory _IotDevice.fromJson(Map<String, dynamic> json) => _$IotDeviceFromJson(json);

@override final  int id;
@override final  String deviceCode;
@override final  int gatewayId;
@override@JsonKey() final  String gatewayCode;
@override final  int buildingId;
@override final  String name;
@override@JsonKey() final  String location;
@override@JsonKey() final  String deviceType;
 final  List<String> _capabilities;
@override@JsonKey() List<String> get capabilities {
  if (_capabilities is EqualUnmodifiableListView) return _capabilities;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_capabilities);
}

/// `FREE_ACCESS` o `RESERVED`.
@override@JsonKey() final  String accessMode;
@override final  int? activeReservationId;
@override final  String? ledColor;
@override@JsonKey() final  int unlockSeconds;
@override final  String? firmwareVersion;
/// `PROVISIONED`, `ACTIVE`, `MAINTENANCE`, `OFFLINE` o `DECOMMISSIONED`.
@override final  String status;
@override final  String? lastSeenAt;
@override final  String? createdAt;

/// Create a copy of IotDevice
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$IotDeviceCopyWith<_IotDevice> get copyWith => __$IotDeviceCopyWithImpl<_IotDevice>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$IotDeviceToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _IotDevice&&(identical(other.id, id) || other.id == id)&&(identical(other.deviceCode, deviceCode) || other.deviceCode == deviceCode)&&(identical(other.gatewayId, gatewayId) || other.gatewayId == gatewayId)&&(identical(other.gatewayCode, gatewayCode) || other.gatewayCode == gatewayCode)&&(identical(other.buildingId, buildingId) || other.buildingId == buildingId)&&(identical(other.name, name) || other.name == name)&&(identical(other.location, location) || other.location == location)&&(identical(other.deviceType, deviceType) || other.deviceType == deviceType)&&const DeepCollectionEquality().equals(other._capabilities, _capabilities)&&(identical(other.accessMode, accessMode) || other.accessMode == accessMode)&&(identical(other.activeReservationId, activeReservationId) || other.activeReservationId == activeReservationId)&&(identical(other.ledColor, ledColor) || other.ledColor == ledColor)&&(identical(other.unlockSeconds, unlockSeconds) || other.unlockSeconds == unlockSeconds)&&(identical(other.firmwareVersion, firmwareVersion) || other.firmwareVersion == firmwareVersion)&&(identical(other.status, status) || other.status == status)&&(identical(other.lastSeenAt, lastSeenAt) || other.lastSeenAt == lastSeenAt)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,deviceCode,gatewayId,gatewayCode,buildingId,name,location,deviceType,const DeepCollectionEquality().hash(_capabilities),accessMode,activeReservationId,ledColor,unlockSeconds,firmwareVersion,status,lastSeenAt,createdAt);

@override
String toString() {
  return 'IotDevice(id: $id, deviceCode: $deviceCode, gatewayId: $gatewayId, gatewayCode: $gatewayCode, buildingId: $buildingId, name: $name, location: $location, deviceType: $deviceType, capabilities: $capabilities, accessMode: $accessMode, activeReservationId: $activeReservationId, ledColor: $ledColor, unlockSeconds: $unlockSeconds, firmwareVersion: $firmwareVersion, status: $status, lastSeenAt: $lastSeenAt, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$IotDeviceCopyWith<$Res> implements $IotDeviceCopyWith<$Res> {
  factory _$IotDeviceCopyWith(_IotDevice value, $Res Function(_IotDevice) _then) = __$IotDeviceCopyWithImpl;
@override @useResult
$Res call({
 int id, String deviceCode, int gatewayId, String gatewayCode, int buildingId, String name, String location, String deviceType, List<String> capabilities, String accessMode, int? activeReservationId, String? ledColor, int unlockSeconds, String? firmwareVersion, String status, String? lastSeenAt, String? createdAt
});




}
/// @nodoc
class __$IotDeviceCopyWithImpl<$Res>
    implements _$IotDeviceCopyWith<$Res> {
  __$IotDeviceCopyWithImpl(this._self, this._then);

  final _IotDevice _self;
  final $Res Function(_IotDevice) _then;

/// Create a copy of IotDevice
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? deviceCode = null,Object? gatewayId = null,Object? gatewayCode = null,Object? buildingId = null,Object? name = null,Object? location = null,Object? deviceType = null,Object? capabilities = null,Object? accessMode = null,Object? activeReservationId = freezed,Object? ledColor = freezed,Object? unlockSeconds = null,Object? firmwareVersion = freezed,Object? status = null,Object? lastSeenAt = freezed,Object? createdAt = freezed,}) {
  return _then(_IotDevice(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,deviceCode: null == deviceCode ? _self.deviceCode : deviceCode // ignore: cast_nullable_to_non_nullable
as String,gatewayId: null == gatewayId ? _self.gatewayId : gatewayId // ignore: cast_nullable_to_non_nullable
as int,gatewayCode: null == gatewayCode ? _self.gatewayCode : gatewayCode // ignore: cast_nullable_to_non_nullable
as String,buildingId: null == buildingId ? _self.buildingId : buildingId // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String,deviceType: null == deviceType ? _self.deviceType : deviceType // ignore: cast_nullable_to_non_nullable
as String,capabilities: null == capabilities ? _self._capabilities : capabilities // ignore: cast_nullable_to_non_nullable
as List<String>,accessMode: null == accessMode ? _self.accessMode : accessMode // ignore: cast_nullable_to_non_nullable
as String,activeReservationId: freezed == activeReservationId ? _self.activeReservationId : activeReservationId // ignore: cast_nullable_to_non_nullable
as int?,ledColor: freezed == ledColor ? _self.ledColor : ledColor // ignore: cast_nullable_to_non_nullable
as String?,unlockSeconds: null == unlockSeconds ? _self.unlockSeconds : unlockSeconds // ignore: cast_nullable_to_non_nullable
as int,firmwareVersion: freezed == firmwareVersion ? _self.firmwareVersion : firmwareVersion // ignore: cast_nullable_to_non_nullable
as String?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,lastSeenAt: freezed == lastSeenAt ? _self.lastSeenAt : lastSeenAt // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$DoorReservation {

 int get id; int get deviceId; int get holderUserId; String get startsAt; String get endsAt;/// `SCHEDULED`, `ACTIVE`, `ENDED` o `CANCELLED`.
 String get status; List<int> get authorizedUserIds; int? get createdBy; String? get createdAt;
/// Create a copy of DoorReservation
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DoorReservationCopyWith<DoorReservation> get copyWith => _$DoorReservationCopyWithImpl<DoorReservation>(this as DoorReservation, _$identity);

  /// Serializes this DoorReservation to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DoorReservation&&(identical(other.id, id) || other.id == id)&&(identical(other.deviceId, deviceId) || other.deviceId == deviceId)&&(identical(other.holderUserId, holderUserId) || other.holderUserId == holderUserId)&&(identical(other.startsAt, startsAt) || other.startsAt == startsAt)&&(identical(other.endsAt, endsAt) || other.endsAt == endsAt)&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other.authorizedUserIds, authorizedUserIds)&&(identical(other.createdBy, createdBy) || other.createdBy == createdBy)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,deviceId,holderUserId,startsAt,endsAt,status,const DeepCollectionEquality().hash(authorizedUserIds),createdBy,createdAt);

@override
String toString() {
  return 'DoorReservation(id: $id, deviceId: $deviceId, holderUserId: $holderUserId, startsAt: $startsAt, endsAt: $endsAt, status: $status, authorizedUserIds: $authorizedUserIds, createdBy: $createdBy, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $DoorReservationCopyWith<$Res>  {
  factory $DoorReservationCopyWith(DoorReservation value, $Res Function(DoorReservation) _then) = _$DoorReservationCopyWithImpl;
@useResult
$Res call({
 int id, int deviceId, int holderUserId, String startsAt, String endsAt, String status, List<int> authorizedUserIds, int? createdBy, String? createdAt
});




}
/// @nodoc
class _$DoorReservationCopyWithImpl<$Res>
    implements $DoorReservationCopyWith<$Res> {
  _$DoorReservationCopyWithImpl(this._self, this._then);

  final DoorReservation _self;
  final $Res Function(DoorReservation) _then;

/// Create a copy of DoorReservation
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? deviceId = null,Object? holderUserId = null,Object? startsAt = null,Object? endsAt = null,Object? status = null,Object? authorizedUserIds = null,Object? createdBy = freezed,Object? createdAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,deviceId: null == deviceId ? _self.deviceId : deviceId // ignore: cast_nullable_to_non_nullable
as int,holderUserId: null == holderUserId ? _self.holderUserId : holderUserId // ignore: cast_nullable_to_non_nullable
as int,startsAt: null == startsAt ? _self.startsAt : startsAt // ignore: cast_nullable_to_non_nullable
as String,endsAt: null == endsAt ? _self.endsAt : endsAt // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,authorizedUserIds: null == authorizedUserIds ? _self.authorizedUserIds : authorizedUserIds // ignore: cast_nullable_to_non_nullable
as List<int>,createdBy: freezed == createdBy ? _self.createdBy : createdBy // ignore: cast_nullable_to_non_nullable
as int?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [DoorReservation].
extension DoorReservationPatterns on DoorReservation {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DoorReservation value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DoorReservation() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DoorReservation value)  $default,){
final _that = this;
switch (_that) {
case _DoorReservation():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DoorReservation value)?  $default,){
final _that = this;
switch (_that) {
case _DoorReservation() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  int deviceId,  int holderUserId,  String startsAt,  String endsAt,  String status,  List<int> authorizedUserIds,  int? createdBy,  String? createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DoorReservation() when $default != null:
return $default(_that.id,_that.deviceId,_that.holderUserId,_that.startsAt,_that.endsAt,_that.status,_that.authorizedUserIds,_that.createdBy,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  int deviceId,  int holderUserId,  String startsAt,  String endsAt,  String status,  List<int> authorizedUserIds,  int? createdBy,  String? createdAt)  $default,) {final _that = this;
switch (_that) {
case _DoorReservation():
return $default(_that.id,_that.deviceId,_that.holderUserId,_that.startsAt,_that.endsAt,_that.status,_that.authorizedUserIds,_that.createdBy,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  int deviceId,  int holderUserId,  String startsAt,  String endsAt,  String status,  List<int> authorizedUserIds,  int? createdBy,  String? createdAt)?  $default,) {final _that = this;
switch (_that) {
case _DoorReservation() when $default != null:
return $default(_that.id,_that.deviceId,_that.holderUserId,_that.startsAt,_that.endsAt,_that.status,_that.authorizedUserIds,_that.createdBy,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DoorReservation implements DoorReservation {
  const _DoorReservation({required this.id, required this.deviceId, required this.holderUserId, required this.startsAt, required this.endsAt, required this.status, final  List<int> authorizedUserIds = const <int>[], this.createdBy, this.createdAt}): _authorizedUserIds = authorizedUserIds;
  factory _DoorReservation.fromJson(Map<String, dynamic> json) => _$DoorReservationFromJson(json);

@override final  int id;
@override final  int deviceId;
@override final  int holderUserId;
@override final  String startsAt;
@override final  String endsAt;
/// `SCHEDULED`, `ACTIVE`, `ENDED` o `CANCELLED`.
@override final  String status;
 final  List<int> _authorizedUserIds;
@override@JsonKey() List<int> get authorizedUserIds {
  if (_authorizedUserIds is EqualUnmodifiableListView) return _authorizedUserIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_authorizedUserIds);
}

@override final  int? createdBy;
@override final  String? createdAt;

/// Create a copy of DoorReservation
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DoorReservationCopyWith<_DoorReservation> get copyWith => __$DoorReservationCopyWithImpl<_DoorReservation>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DoorReservationToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DoorReservation&&(identical(other.id, id) || other.id == id)&&(identical(other.deviceId, deviceId) || other.deviceId == deviceId)&&(identical(other.holderUserId, holderUserId) || other.holderUserId == holderUserId)&&(identical(other.startsAt, startsAt) || other.startsAt == startsAt)&&(identical(other.endsAt, endsAt) || other.endsAt == endsAt)&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other._authorizedUserIds, _authorizedUserIds)&&(identical(other.createdBy, createdBy) || other.createdBy == createdBy)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,deviceId,holderUserId,startsAt,endsAt,status,const DeepCollectionEquality().hash(_authorizedUserIds),createdBy,createdAt);

@override
String toString() {
  return 'DoorReservation(id: $id, deviceId: $deviceId, holderUserId: $holderUserId, startsAt: $startsAt, endsAt: $endsAt, status: $status, authorizedUserIds: $authorizedUserIds, createdBy: $createdBy, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$DoorReservationCopyWith<$Res> implements $DoorReservationCopyWith<$Res> {
  factory _$DoorReservationCopyWith(_DoorReservation value, $Res Function(_DoorReservation) _then) = __$DoorReservationCopyWithImpl;
@override @useResult
$Res call({
 int id, int deviceId, int holderUserId, String startsAt, String endsAt, String status, List<int> authorizedUserIds, int? createdBy, String? createdAt
});




}
/// @nodoc
class __$DoorReservationCopyWithImpl<$Res>
    implements _$DoorReservationCopyWith<$Res> {
  __$DoorReservationCopyWithImpl(this._self, this._then);

  final _DoorReservation _self;
  final $Res Function(_DoorReservation) _then;

/// Create a copy of DoorReservation
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? deviceId = null,Object? holderUserId = null,Object? startsAt = null,Object? endsAt = null,Object? status = null,Object? authorizedUserIds = null,Object? createdBy = freezed,Object? createdAt = freezed,}) {
  return _then(_DoorReservation(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,deviceId: null == deviceId ? _self.deviceId : deviceId // ignore: cast_nullable_to_non_nullable
as int,holderUserId: null == holderUserId ? _self.holderUserId : holderUserId // ignore: cast_nullable_to_non_nullable
as int,startsAt: null == startsAt ? _self.startsAt : startsAt // ignore: cast_nullable_to_non_nullable
as String,endsAt: null == endsAt ? _self.endsAt : endsAt // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,authorizedUserIds: null == authorizedUserIds ? _self._authorizedUserIds : authorizedUserIds // ignore: cast_nullable_to_non_nullable
as List<int>,createdBy: freezed == createdBy ? _self.createdBy : createdBy // ignore: cast_nullable_to_non_nullable
as int?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$DeviceCommand {

 String get commandId; int get deviceId;/// `SET_LED` o `ENROLL`.
 String get type; Map<String, dynamic> get params; String get status;/// Motivo que envía el nodo al rechazar (p. ej. `not reserved`).
 String? get detail; String? get requestedAt; String? get expiresAt; String? get resolvedAt;
/// Create a copy of DeviceCommand
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DeviceCommandCopyWith<DeviceCommand> get copyWith => _$DeviceCommandCopyWithImpl<DeviceCommand>(this as DeviceCommand, _$identity);

  /// Serializes this DeviceCommand to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DeviceCommand&&(identical(other.commandId, commandId) || other.commandId == commandId)&&(identical(other.deviceId, deviceId) || other.deviceId == deviceId)&&(identical(other.type, type) || other.type == type)&&const DeepCollectionEquality().equals(other.params, params)&&(identical(other.status, status) || other.status == status)&&(identical(other.detail, detail) || other.detail == detail)&&(identical(other.requestedAt, requestedAt) || other.requestedAt == requestedAt)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt)&&(identical(other.resolvedAt, resolvedAt) || other.resolvedAt == resolvedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,commandId,deviceId,type,const DeepCollectionEquality().hash(params),status,detail,requestedAt,expiresAt,resolvedAt);

@override
String toString() {
  return 'DeviceCommand(commandId: $commandId, deviceId: $deviceId, type: $type, params: $params, status: $status, detail: $detail, requestedAt: $requestedAt, expiresAt: $expiresAt, resolvedAt: $resolvedAt)';
}


}

/// @nodoc
abstract mixin class $DeviceCommandCopyWith<$Res>  {
  factory $DeviceCommandCopyWith(DeviceCommand value, $Res Function(DeviceCommand) _then) = _$DeviceCommandCopyWithImpl;
@useResult
$Res call({
 String commandId, int deviceId, String type, Map<String, dynamic> params, String status, String? detail, String? requestedAt, String? expiresAt, String? resolvedAt
});




}
/// @nodoc
class _$DeviceCommandCopyWithImpl<$Res>
    implements $DeviceCommandCopyWith<$Res> {
  _$DeviceCommandCopyWithImpl(this._self, this._then);

  final DeviceCommand _self;
  final $Res Function(DeviceCommand) _then;

/// Create a copy of DeviceCommand
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? commandId = null,Object? deviceId = null,Object? type = null,Object? params = null,Object? status = null,Object? detail = freezed,Object? requestedAt = freezed,Object? expiresAt = freezed,Object? resolvedAt = freezed,}) {
  return _then(_self.copyWith(
commandId: null == commandId ? _self.commandId : commandId // ignore: cast_nullable_to_non_nullable
as String,deviceId: null == deviceId ? _self.deviceId : deviceId // ignore: cast_nullable_to_non_nullable
as int,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,params: null == params ? _self.params : params // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,detail: freezed == detail ? _self.detail : detail // ignore: cast_nullable_to_non_nullable
as String?,requestedAt: freezed == requestedAt ? _self.requestedAt : requestedAt // ignore: cast_nullable_to_non_nullable
as String?,expiresAt: freezed == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as String?,resolvedAt: freezed == resolvedAt ? _self.resolvedAt : resolvedAt // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [DeviceCommand].
extension DeviceCommandPatterns on DeviceCommand {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DeviceCommand value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DeviceCommand() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DeviceCommand value)  $default,){
final _that = this;
switch (_that) {
case _DeviceCommand():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DeviceCommand value)?  $default,){
final _that = this;
switch (_that) {
case _DeviceCommand() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String commandId,  int deviceId,  String type,  Map<String, dynamic> params,  String status,  String? detail,  String? requestedAt,  String? expiresAt,  String? resolvedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DeviceCommand() when $default != null:
return $default(_that.commandId,_that.deviceId,_that.type,_that.params,_that.status,_that.detail,_that.requestedAt,_that.expiresAt,_that.resolvedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String commandId,  int deviceId,  String type,  Map<String, dynamic> params,  String status,  String? detail,  String? requestedAt,  String? expiresAt,  String? resolvedAt)  $default,) {final _that = this;
switch (_that) {
case _DeviceCommand():
return $default(_that.commandId,_that.deviceId,_that.type,_that.params,_that.status,_that.detail,_that.requestedAt,_that.expiresAt,_that.resolvedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String commandId,  int deviceId,  String type,  Map<String, dynamic> params,  String status,  String? detail,  String? requestedAt,  String? expiresAt,  String? resolvedAt)?  $default,) {final _that = this;
switch (_that) {
case _DeviceCommand() when $default != null:
return $default(_that.commandId,_that.deviceId,_that.type,_that.params,_that.status,_that.detail,_that.requestedAt,_that.expiresAt,_that.resolvedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DeviceCommand extends DeviceCommand {
  const _DeviceCommand({required this.commandId, required this.deviceId, required this.type, final  Map<String, dynamic> params = const <String, dynamic>{}, required this.status, this.detail, this.requestedAt, this.expiresAt, this.resolvedAt}): _params = params,super._();
  factory _DeviceCommand.fromJson(Map<String, dynamic> json) => _$DeviceCommandFromJson(json);

@override final  String commandId;
@override final  int deviceId;
/// `SET_LED` o `ENROLL`.
@override final  String type;
 final  Map<String, dynamic> _params;
@override@JsonKey() Map<String, dynamic> get params {
  if (_params is EqualUnmodifiableMapView) return _params;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_params);
}

@override final  String status;
/// Motivo que envía el nodo al rechazar (p. ej. `not reserved`).
@override final  String? detail;
@override final  String? requestedAt;
@override final  String? expiresAt;
@override final  String? resolvedAt;

/// Create a copy of DeviceCommand
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DeviceCommandCopyWith<_DeviceCommand> get copyWith => __$DeviceCommandCopyWithImpl<_DeviceCommand>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DeviceCommandToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DeviceCommand&&(identical(other.commandId, commandId) || other.commandId == commandId)&&(identical(other.deviceId, deviceId) || other.deviceId == deviceId)&&(identical(other.type, type) || other.type == type)&&const DeepCollectionEquality().equals(other._params, _params)&&(identical(other.status, status) || other.status == status)&&(identical(other.detail, detail) || other.detail == detail)&&(identical(other.requestedAt, requestedAt) || other.requestedAt == requestedAt)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt)&&(identical(other.resolvedAt, resolvedAt) || other.resolvedAt == resolvedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,commandId,deviceId,type,const DeepCollectionEquality().hash(_params),status,detail,requestedAt,expiresAt,resolvedAt);

@override
String toString() {
  return 'DeviceCommand(commandId: $commandId, deviceId: $deviceId, type: $type, params: $params, status: $status, detail: $detail, requestedAt: $requestedAt, expiresAt: $expiresAt, resolvedAt: $resolvedAt)';
}


}

/// @nodoc
abstract mixin class _$DeviceCommandCopyWith<$Res> implements $DeviceCommandCopyWith<$Res> {
  factory _$DeviceCommandCopyWith(_DeviceCommand value, $Res Function(_DeviceCommand) _then) = __$DeviceCommandCopyWithImpl;
@override @useResult
$Res call({
 String commandId, int deviceId, String type, Map<String, dynamic> params, String status, String? detail, String? requestedAt, String? expiresAt, String? resolvedAt
});




}
/// @nodoc
class __$DeviceCommandCopyWithImpl<$Res>
    implements _$DeviceCommandCopyWith<$Res> {
  __$DeviceCommandCopyWithImpl(this._self, this._then);

  final _DeviceCommand _self;
  final $Res Function(_DeviceCommand) _then;

/// Create a copy of DeviceCommand
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? commandId = null,Object? deviceId = null,Object? type = null,Object? params = null,Object? status = null,Object? detail = freezed,Object? requestedAt = freezed,Object? expiresAt = freezed,Object? resolvedAt = freezed,}) {
  return _then(_DeviceCommand(
commandId: null == commandId ? _self.commandId : commandId // ignore: cast_nullable_to_non_nullable
as String,deviceId: null == deviceId ? _self.deviceId : deviceId // ignore: cast_nullable_to_non_nullable
as int,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,params: null == params ? _self._params : params // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,detail: freezed == detail ? _self.detail : detail // ignore: cast_nullable_to_non_nullable
as String?,requestedAt: freezed == requestedAt ? _self.requestedAt : requestedAt // ignore: cast_nullable_to_non_nullable
as String?,expiresAt: freezed == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as String?,resolvedAt: freezed == resolvedAt ? _self.resolvedAt : resolvedAt // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$ExistingCardCredential {

 int get id; int? get userId; String? get holderName; String? get status;
/// Create a copy of ExistingCardCredential
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ExistingCardCredentialCopyWith<ExistingCardCredential> get copyWith => _$ExistingCardCredentialCopyWithImpl<ExistingCardCredential>(this as ExistingCardCredential, _$identity);

  /// Serializes this ExistingCardCredential to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ExistingCardCredential&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.holderName, holderName) || other.holderName == holderName)&&(identical(other.status, status) || other.status == status));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,userId,holderName,status);

@override
String toString() {
  return 'ExistingCardCredential(id: $id, userId: $userId, holderName: $holderName, status: $status)';
}


}

/// @nodoc
abstract mixin class $ExistingCardCredentialCopyWith<$Res>  {
  factory $ExistingCardCredentialCopyWith(ExistingCardCredential value, $Res Function(ExistingCardCredential) _then) = _$ExistingCardCredentialCopyWithImpl;
@useResult
$Res call({
 int id, int? userId, String? holderName, String? status
});




}
/// @nodoc
class _$ExistingCardCredentialCopyWithImpl<$Res>
    implements $ExistingCardCredentialCopyWith<$Res> {
  _$ExistingCardCredentialCopyWithImpl(this._self, this._then);

  final ExistingCardCredential _self;
  final $Res Function(ExistingCardCredential) _then;

/// Create a copy of ExistingCardCredential
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? userId = freezed,Object? holderName = freezed,Object? status = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,userId: freezed == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as int?,holderName: freezed == holderName ? _self.holderName : holderName // ignore: cast_nullable_to_non_nullable
as String?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [ExistingCardCredential].
extension ExistingCardCredentialPatterns on ExistingCardCredential {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ExistingCardCredential value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ExistingCardCredential() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ExistingCardCredential value)  $default,){
final _that = this;
switch (_that) {
case _ExistingCardCredential():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ExistingCardCredential value)?  $default,){
final _that = this;
switch (_that) {
case _ExistingCardCredential() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  int? userId,  String? holderName,  String? status)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ExistingCardCredential() when $default != null:
return $default(_that.id,_that.userId,_that.holderName,_that.status);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  int? userId,  String? holderName,  String? status)  $default,) {final _that = this;
switch (_that) {
case _ExistingCardCredential():
return $default(_that.id,_that.userId,_that.holderName,_that.status);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  int? userId,  String? holderName,  String? status)?  $default,) {final _that = this;
switch (_that) {
case _ExistingCardCredential() when $default != null:
return $default(_that.id,_that.userId,_that.holderName,_that.status);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ExistingCardCredential implements ExistingCardCredential {
  const _ExistingCardCredential({required this.id, this.userId, this.holderName, this.status});
  factory _ExistingCardCredential.fromJson(Map<String, dynamic> json) => _$ExistingCardCredentialFromJson(json);

@override final  int id;
@override final  int? userId;
@override final  String? holderName;
@override final  String? status;

/// Create a copy of ExistingCardCredential
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ExistingCardCredentialCopyWith<_ExistingCardCredential> get copyWith => __$ExistingCardCredentialCopyWithImpl<_ExistingCardCredential>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ExistingCardCredentialToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ExistingCardCredential&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.holderName, holderName) || other.holderName == holderName)&&(identical(other.status, status) || other.status == status));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,userId,holderName,status);

@override
String toString() {
  return 'ExistingCardCredential(id: $id, userId: $userId, holderName: $holderName, status: $status)';
}


}

/// @nodoc
abstract mixin class _$ExistingCardCredentialCopyWith<$Res> implements $ExistingCardCredentialCopyWith<$Res> {
  factory _$ExistingCardCredentialCopyWith(_ExistingCardCredential value, $Res Function(_ExistingCardCredential) _then) = __$ExistingCardCredentialCopyWithImpl;
@override @useResult
$Res call({
 int id, int? userId, String? holderName, String? status
});




}
/// @nodoc
class __$ExistingCardCredentialCopyWithImpl<$Res>
    implements _$ExistingCardCredentialCopyWith<$Res> {
  __$ExistingCardCredentialCopyWithImpl(this._self, this._then);

  final _ExistingCardCredential _self;
  final $Res Function(_ExistingCardCredential) _then;

/// Create a copy of ExistingCardCredential
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? userId = freezed,Object? holderName = freezed,Object? status = freezed,}) {
  return _then(_ExistingCardCredential(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,userId: freezed == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as int?,holderName: freezed == holderName ? _self.holderName : holderName // ignore: cast_nullable_to_non_nullable
as String?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$CardEnrollment {

 int get id; int get deviceId; String get deviceCode; int get buildingId;/// `ACTIVE`, `CAPTURED`, `CANCELLED` o `EXPIRED`.
 String get status; String get startedAt; String get expiresAt; String? get capturedUid; String? get capturedAt; ExistingCardCredential? get existingCredential;
/// Create a copy of CardEnrollment
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CardEnrollmentCopyWith<CardEnrollment> get copyWith => _$CardEnrollmentCopyWithImpl<CardEnrollment>(this as CardEnrollment, _$identity);

  /// Serializes this CardEnrollment to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CardEnrollment&&(identical(other.id, id) || other.id == id)&&(identical(other.deviceId, deviceId) || other.deviceId == deviceId)&&(identical(other.deviceCode, deviceCode) || other.deviceCode == deviceCode)&&(identical(other.buildingId, buildingId) || other.buildingId == buildingId)&&(identical(other.status, status) || other.status == status)&&(identical(other.startedAt, startedAt) || other.startedAt == startedAt)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt)&&(identical(other.capturedUid, capturedUid) || other.capturedUid == capturedUid)&&(identical(other.capturedAt, capturedAt) || other.capturedAt == capturedAt)&&(identical(other.existingCredential, existingCredential) || other.existingCredential == existingCredential));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,deviceId,deviceCode,buildingId,status,startedAt,expiresAt,capturedUid,capturedAt,existingCredential);

@override
String toString() {
  return 'CardEnrollment(id: $id, deviceId: $deviceId, deviceCode: $deviceCode, buildingId: $buildingId, status: $status, startedAt: $startedAt, expiresAt: $expiresAt, capturedUid: $capturedUid, capturedAt: $capturedAt, existingCredential: $existingCredential)';
}


}

/// @nodoc
abstract mixin class $CardEnrollmentCopyWith<$Res>  {
  factory $CardEnrollmentCopyWith(CardEnrollment value, $Res Function(CardEnrollment) _then) = _$CardEnrollmentCopyWithImpl;
@useResult
$Res call({
 int id, int deviceId, String deviceCode, int buildingId, String status, String startedAt, String expiresAt, String? capturedUid, String? capturedAt, ExistingCardCredential? existingCredential
});


$ExistingCardCredentialCopyWith<$Res>? get existingCredential;

}
/// @nodoc
class _$CardEnrollmentCopyWithImpl<$Res>
    implements $CardEnrollmentCopyWith<$Res> {
  _$CardEnrollmentCopyWithImpl(this._self, this._then);

  final CardEnrollment _self;
  final $Res Function(CardEnrollment) _then;

/// Create a copy of CardEnrollment
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? deviceId = null,Object? deviceCode = null,Object? buildingId = null,Object? status = null,Object? startedAt = null,Object? expiresAt = null,Object? capturedUid = freezed,Object? capturedAt = freezed,Object? existingCredential = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,deviceId: null == deviceId ? _self.deviceId : deviceId // ignore: cast_nullable_to_non_nullable
as int,deviceCode: null == deviceCode ? _self.deviceCode : deviceCode // ignore: cast_nullable_to_non_nullable
as String,buildingId: null == buildingId ? _self.buildingId : buildingId // ignore: cast_nullable_to_non_nullable
as int,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,startedAt: null == startedAt ? _self.startedAt : startedAt // ignore: cast_nullable_to_non_nullable
as String,expiresAt: null == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as String,capturedUid: freezed == capturedUid ? _self.capturedUid : capturedUid // ignore: cast_nullable_to_non_nullable
as String?,capturedAt: freezed == capturedAt ? _self.capturedAt : capturedAt // ignore: cast_nullable_to_non_nullable
as String?,existingCredential: freezed == existingCredential ? _self.existingCredential : existingCredential // ignore: cast_nullable_to_non_nullable
as ExistingCardCredential?,
  ));
}
/// Create a copy of CardEnrollment
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ExistingCardCredentialCopyWith<$Res>? get existingCredential {
    if (_self.existingCredential == null) {
    return null;
  }

  return $ExistingCardCredentialCopyWith<$Res>(_self.existingCredential!, (value) {
    return _then(_self.copyWith(existingCredential: value));
  });
}
}


/// Adds pattern-matching-related methods to [CardEnrollment].
extension CardEnrollmentPatterns on CardEnrollment {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CardEnrollment value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CardEnrollment() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CardEnrollment value)  $default,){
final _that = this;
switch (_that) {
case _CardEnrollment():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CardEnrollment value)?  $default,){
final _that = this;
switch (_that) {
case _CardEnrollment() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  int deviceId,  String deviceCode,  int buildingId,  String status,  String startedAt,  String expiresAt,  String? capturedUid,  String? capturedAt,  ExistingCardCredential? existingCredential)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CardEnrollment() when $default != null:
return $default(_that.id,_that.deviceId,_that.deviceCode,_that.buildingId,_that.status,_that.startedAt,_that.expiresAt,_that.capturedUid,_that.capturedAt,_that.existingCredential);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  int deviceId,  String deviceCode,  int buildingId,  String status,  String startedAt,  String expiresAt,  String? capturedUid,  String? capturedAt,  ExistingCardCredential? existingCredential)  $default,) {final _that = this;
switch (_that) {
case _CardEnrollment():
return $default(_that.id,_that.deviceId,_that.deviceCode,_that.buildingId,_that.status,_that.startedAt,_that.expiresAt,_that.capturedUid,_that.capturedAt,_that.existingCredential);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  int deviceId,  String deviceCode,  int buildingId,  String status,  String startedAt,  String expiresAt,  String? capturedUid,  String? capturedAt,  ExistingCardCredential? existingCredential)?  $default,) {final _that = this;
switch (_that) {
case _CardEnrollment() when $default != null:
return $default(_that.id,_that.deviceId,_that.deviceCode,_that.buildingId,_that.status,_that.startedAt,_that.expiresAt,_that.capturedUid,_that.capturedAt,_that.existingCredential);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CardEnrollment extends CardEnrollment {
  const _CardEnrollment({required this.id, required this.deviceId, required this.deviceCode, required this.buildingId, required this.status, required this.startedAt, required this.expiresAt, this.capturedUid, this.capturedAt, this.existingCredential}): super._();
  factory _CardEnrollment.fromJson(Map<String, dynamic> json) => _$CardEnrollmentFromJson(json);

@override final  int id;
@override final  int deviceId;
@override final  String deviceCode;
@override final  int buildingId;
/// `ACTIVE`, `CAPTURED`, `CANCELLED` o `EXPIRED`.
@override final  String status;
@override final  String startedAt;
@override final  String expiresAt;
@override final  String? capturedUid;
@override final  String? capturedAt;
@override final  ExistingCardCredential? existingCredential;

/// Create a copy of CardEnrollment
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CardEnrollmentCopyWith<_CardEnrollment> get copyWith => __$CardEnrollmentCopyWithImpl<_CardEnrollment>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CardEnrollmentToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CardEnrollment&&(identical(other.id, id) || other.id == id)&&(identical(other.deviceId, deviceId) || other.deviceId == deviceId)&&(identical(other.deviceCode, deviceCode) || other.deviceCode == deviceCode)&&(identical(other.buildingId, buildingId) || other.buildingId == buildingId)&&(identical(other.status, status) || other.status == status)&&(identical(other.startedAt, startedAt) || other.startedAt == startedAt)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt)&&(identical(other.capturedUid, capturedUid) || other.capturedUid == capturedUid)&&(identical(other.capturedAt, capturedAt) || other.capturedAt == capturedAt)&&(identical(other.existingCredential, existingCredential) || other.existingCredential == existingCredential));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,deviceId,deviceCode,buildingId,status,startedAt,expiresAt,capturedUid,capturedAt,existingCredential);

@override
String toString() {
  return 'CardEnrollment(id: $id, deviceId: $deviceId, deviceCode: $deviceCode, buildingId: $buildingId, status: $status, startedAt: $startedAt, expiresAt: $expiresAt, capturedUid: $capturedUid, capturedAt: $capturedAt, existingCredential: $existingCredential)';
}


}

/// @nodoc
abstract mixin class _$CardEnrollmentCopyWith<$Res> implements $CardEnrollmentCopyWith<$Res> {
  factory _$CardEnrollmentCopyWith(_CardEnrollment value, $Res Function(_CardEnrollment) _then) = __$CardEnrollmentCopyWithImpl;
@override @useResult
$Res call({
 int id, int deviceId, String deviceCode, int buildingId, String status, String startedAt, String expiresAt, String? capturedUid, String? capturedAt, ExistingCardCredential? existingCredential
});


@override $ExistingCardCredentialCopyWith<$Res>? get existingCredential;

}
/// @nodoc
class __$CardEnrollmentCopyWithImpl<$Res>
    implements _$CardEnrollmentCopyWith<$Res> {
  __$CardEnrollmentCopyWithImpl(this._self, this._then);

  final _CardEnrollment _self;
  final $Res Function(_CardEnrollment) _then;

/// Create a copy of CardEnrollment
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? deviceId = null,Object? deviceCode = null,Object? buildingId = null,Object? status = null,Object? startedAt = null,Object? expiresAt = null,Object? capturedUid = freezed,Object? capturedAt = freezed,Object? existingCredential = freezed,}) {
  return _then(_CardEnrollment(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,deviceId: null == deviceId ? _self.deviceId : deviceId // ignore: cast_nullable_to_non_nullable
as int,deviceCode: null == deviceCode ? _self.deviceCode : deviceCode // ignore: cast_nullable_to_non_nullable
as String,buildingId: null == buildingId ? _self.buildingId : buildingId // ignore: cast_nullable_to_non_nullable
as int,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,startedAt: null == startedAt ? _self.startedAt : startedAt // ignore: cast_nullable_to_non_nullable
as String,expiresAt: null == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as String,capturedUid: freezed == capturedUid ? _self.capturedUid : capturedUid // ignore: cast_nullable_to_non_nullable
as String?,capturedAt: freezed == capturedAt ? _self.capturedAt : capturedAt // ignore: cast_nullable_to_non_nullable
as String?,existingCredential: freezed == existingCredential ? _self.existingCredential : existingCredential // ignore: cast_nullable_to_non_nullable
as ExistingCardCredential?,
  ));
}

/// Create a copy of CardEnrollment
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ExistingCardCredentialCopyWith<$Res>? get existingCredential {
    if (_self.existingCredential == null) {
    return null;
  }

  return $ExistingCardCredentialCopyWith<$Res>(_self.existingCredential!, (value) {
    return _then(_self.copyWith(existingCredential: value));
  });
}
}


/// @nodoc
mixin _$AccessCredential {

 int get id; String get rfidUid; int get buildingId; int? get userId; String? get holderName; String get status; String? get suspensionReason; String? get validFrom; String? get validUntil; String? get origin; String? get createdAt; String? get updatedAt;
/// Create a copy of AccessCredential
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AccessCredentialCopyWith<AccessCredential> get copyWith => _$AccessCredentialCopyWithImpl<AccessCredential>(this as AccessCredential, _$identity);

  /// Serializes this AccessCredential to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AccessCredential&&(identical(other.id, id) || other.id == id)&&(identical(other.rfidUid, rfidUid) || other.rfidUid == rfidUid)&&(identical(other.buildingId, buildingId) || other.buildingId == buildingId)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.holderName, holderName) || other.holderName == holderName)&&(identical(other.status, status) || other.status == status)&&(identical(other.suspensionReason, suspensionReason) || other.suspensionReason == suspensionReason)&&(identical(other.validFrom, validFrom) || other.validFrom == validFrom)&&(identical(other.validUntil, validUntil) || other.validUntil == validUntil)&&(identical(other.origin, origin) || other.origin == origin)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,rfidUid,buildingId,userId,holderName,status,suspensionReason,validFrom,validUntil,origin,createdAt,updatedAt);

@override
String toString() {
  return 'AccessCredential(id: $id, rfidUid: $rfidUid, buildingId: $buildingId, userId: $userId, holderName: $holderName, status: $status, suspensionReason: $suspensionReason, validFrom: $validFrom, validUntil: $validUntil, origin: $origin, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $AccessCredentialCopyWith<$Res>  {
  factory $AccessCredentialCopyWith(AccessCredential value, $Res Function(AccessCredential) _then) = _$AccessCredentialCopyWithImpl;
@useResult
$Res call({
 int id, String rfidUid, int buildingId, int? userId, String? holderName, String status, String? suspensionReason, String? validFrom, String? validUntil, String? origin, String? createdAt, String? updatedAt
});




}
/// @nodoc
class _$AccessCredentialCopyWithImpl<$Res>
    implements $AccessCredentialCopyWith<$Res> {
  _$AccessCredentialCopyWithImpl(this._self, this._then);

  final AccessCredential _self;
  final $Res Function(AccessCredential) _then;

/// Create a copy of AccessCredential
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? rfidUid = null,Object? buildingId = null,Object? userId = freezed,Object? holderName = freezed,Object? status = null,Object? suspensionReason = freezed,Object? validFrom = freezed,Object? validUntil = freezed,Object? origin = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,rfidUid: null == rfidUid ? _self.rfidUid : rfidUid // ignore: cast_nullable_to_non_nullable
as String,buildingId: null == buildingId ? _self.buildingId : buildingId // ignore: cast_nullable_to_non_nullable
as int,userId: freezed == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as int?,holderName: freezed == holderName ? _self.holderName : holderName // ignore: cast_nullable_to_non_nullable
as String?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,suspensionReason: freezed == suspensionReason ? _self.suspensionReason : suspensionReason // ignore: cast_nullable_to_non_nullable
as String?,validFrom: freezed == validFrom ? _self.validFrom : validFrom // ignore: cast_nullable_to_non_nullable
as String?,validUntil: freezed == validUntil ? _self.validUntil : validUntil // ignore: cast_nullable_to_non_nullable
as String?,origin: freezed == origin ? _self.origin : origin // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [AccessCredential].
extension AccessCredentialPatterns on AccessCredential {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AccessCredential value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AccessCredential() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AccessCredential value)  $default,){
final _that = this;
switch (_that) {
case _AccessCredential():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AccessCredential value)?  $default,){
final _that = this;
switch (_that) {
case _AccessCredential() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String rfidUid,  int buildingId,  int? userId,  String? holderName,  String status,  String? suspensionReason,  String? validFrom,  String? validUntil,  String? origin,  String? createdAt,  String? updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AccessCredential() when $default != null:
return $default(_that.id,_that.rfidUid,_that.buildingId,_that.userId,_that.holderName,_that.status,_that.suspensionReason,_that.validFrom,_that.validUntil,_that.origin,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String rfidUid,  int buildingId,  int? userId,  String? holderName,  String status,  String? suspensionReason,  String? validFrom,  String? validUntil,  String? origin,  String? createdAt,  String? updatedAt)  $default,) {final _that = this;
switch (_that) {
case _AccessCredential():
return $default(_that.id,_that.rfidUid,_that.buildingId,_that.userId,_that.holderName,_that.status,_that.suspensionReason,_that.validFrom,_that.validUntil,_that.origin,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String rfidUid,  int buildingId,  int? userId,  String? holderName,  String status,  String? suspensionReason,  String? validFrom,  String? validUntil,  String? origin,  String? createdAt,  String? updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _AccessCredential() when $default != null:
return $default(_that.id,_that.rfidUid,_that.buildingId,_that.userId,_that.holderName,_that.status,_that.suspensionReason,_that.validFrom,_that.validUntil,_that.origin,_that.createdAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AccessCredential implements AccessCredential {
  const _AccessCredential({required this.id, required this.rfidUid, required this.buildingId, this.userId, this.holderName, required this.status, this.suspensionReason, this.validFrom, this.validUntil, this.origin, this.createdAt, this.updatedAt});
  factory _AccessCredential.fromJson(Map<String, dynamic> json) => _$AccessCredentialFromJson(json);

@override final  int id;
@override final  String rfidUid;
@override final  int buildingId;
@override final  int? userId;
@override final  String? holderName;
@override final  String status;
@override final  String? suspensionReason;
@override final  String? validFrom;
@override final  String? validUntil;
@override final  String? origin;
@override final  String? createdAt;
@override final  String? updatedAt;

/// Create a copy of AccessCredential
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AccessCredentialCopyWith<_AccessCredential> get copyWith => __$AccessCredentialCopyWithImpl<_AccessCredential>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AccessCredentialToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AccessCredential&&(identical(other.id, id) || other.id == id)&&(identical(other.rfidUid, rfidUid) || other.rfidUid == rfidUid)&&(identical(other.buildingId, buildingId) || other.buildingId == buildingId)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.holderName, holderName) || other.holderName == holderName)&&(identical(other.status, status) || other.status == status)&&(identical(other.suspensionReason, suspensionReason) || other.suspensionReason == suspensionReason)&&(identical(other.validFrom, validFrom) || other.validFrom == validFrom)&&(identical(other.validUntil, validUntil) || other.validUntil == validUntil)&&(identical(other.origin, origin) || other.origin == origin)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,rfidUid,buildingId,userId,holderName,status,suspensionReason,validFrom,validUntil,origin,createdAt,updatedAt);

@override
String toString() {
  return 'AccessCredential(id: $id, rfidUid: $rfidUid, buildingId: $buildingId, userId: $userId, holderName: $holderName, status: $status, suspensionReason: $suspensionReason, validFrom: $validFrom, validUntil: $validUntil, origin: $origin, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$AccessCredentialCopyWith<$Res> implements $AccessCredentialCopyWith<$Res> {
  factory _$AccessCredentialCopyWith(_AccessCredential value, $Res Function(_AccessCredential) _then) = __$AccessCredentialCopyWithImpl;
@override @useResult
$Res call({
 int id, String rfidUid, int buildingId, int? userId, String? holderName, String status, String? suspensionReason, String? validFrom, String? validUntil, String? origin, String? createdAt, String? updatedAt
});




}
/// @nodoc
class __$AccessCredentialCopyWithImpl<$Res>
    implements _$AccessCredentialCopyWith<$Res> {
  __$AccessCredentialCopyWithImpl(this._self, this._then);

  final _AccessCredential _self;
  final $Res Function(_AccessCredential) _then;

/// Create a copy of AccessCredential
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? rfidUid = null,Object? buildingId = null,Object? userId = freezed,Object? holderName = freezed,Object? status = null,Object? suspensionReason = freezed,Object? validFrom = freezed,Object? validUntil = freezed,Object? origin = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(_AccessCredential(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,rfidUid: null == rfidUid ? _self.rfidUid : rfidUid // ignore: cast_nullable_to_non_nullable
as String,buildingId: null == buildingId ? _self.buildingId : buildingId // ignore: cast_nullable_to_non_nullable
as int,userId: freezed == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as int?,holderName: freezed == holderName ? _self.holderName : holderName // ignore: cast_nullable_to_non_nullable
as String?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,suspensionReason: freezed == suspensionReason ? _self.suspensionReason : suspensionReason // ignore: cast_nullable_to_non_nullable
as String?,validFrom: freezed == validFrom ? _self.validFrom : validFrom // ignore: cast_nullable_to_non_nullable
as String?,validUntil: freezed == validUntil ? _self.validUntil : validUntil // ignore: cast_nullable_to_non_nullable
as String?,origin: freezed == origin ? _self.origin : origin // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$SensorReading {

/// `TEMPERATURE`, `HUMIDITY` o `ULTRASONIC`.
 String get magnitude; double? get value; String get unit; String? get capturedAt;
/// Create a copy of SensorReading
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SensorReadingCopyWith<SensorReading> get copyWith => _$SensorReadingCopyWithImpl<SensorReading>(this as SensorReading, _$identity);

  /// Serializes this SensorReading to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SensorReading&&(identical(other.magnitude, magnitude) || other.magnitude == magnitude)&&(identical(other.value, value) || other.value == value)&&(identical(other.unit, unit) || other.unit == unit)&&(identical(other.capturedAt, capturedAt) || other.capturedAt == capturedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,magnitude,value,unit,capturedAt);

@override
String toString() {
  return 'SensorReading(magnitude: $magnitude, value: $value, unit: $unit, capturedAt: $capturedAt)';
}


}

/// @nodoc
abstract mixin class $SensorReadingCopyWith<$Res>  {
  factory $SensorReadingCopyWith(SensorReading value, $Res Function(SensorReading) _then) = _$SensorReadingCopyWithImpl;
@useResult
$Res call({
 String magnitude, double? value, String unit, String? capturedAt
});




}
/// @nodoc
class _$SensorReadingCopyWithImpl<$Res>
    implements $SensorReadingCopyWith<$Res> {
  _$SensorReadingCopyWithImpl(this._self, this._then);

  final SensorReading _self;
  final $Res Function(SensorReading) _then;

/// Create a copy of SensorReading
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? magnitude = null,Object? value = freezed,Object? unit = null,Object? capturedAt = freezed,}) {
  return _then(_self.copyWith(
magnitude: null == magnitude ? _self.magnitude : magnitude // ignore: cast_nullable_to_non_nullable
as String,value: freezed == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as double?,unit: null == unit ? _self.unit : unit // ignore: cast_nullable_to_non_nullable
as String,capturedAt: freezed == capturedAt ? _self.capturedAt : capturedAt // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [SensorReading].
extension SensorReadingPatterns on SensorReading {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SensorReading value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SensorReading() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SensorReading value)  $default,){
final _that = this;
switch (_that) {
case _SensorReading():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SensorReading value)?  $default,){
final _that = this;
switch (_that) {
case _SensorReading() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String magnitude,  double? value,  String unit,  String? capturedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SensorReading() when $default != null:
return $default(_that.magnitude,_that.value,_that.unit,_that.capturedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String magnitude,  double? value,  String unit,  String? capturedAt)  $default,) {final _that = this;
switch (_that) {
case _SensorReading():
return $default(_that.magnitude,_that.value,_that.unit,_that.capturedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String magnitude,  double? value,  String unit,  String? capturedAt)?  $default,) {final _that = this;
switch (_that) {
case _SensorReading() when $default != null:
return $default(_that.magnitude,_that.value,_that.unit,_that.capturedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SensorReading implements SensorReading {
  const _SensorReading({required this.magnitude, this.value, this.unit = '', this.capturedAt});
  factory _SensorReading.fromJson(Map<String, dynamic> json) => _$SensorReadingFromJson(json);

/// `TEMPERATURE`, `HUMIDITY` o `ULTRASONIC`.
@override final  String magnitude;
@override final  double? value;
@override@JsonKey() final  String unit;
@override final  String? capturedAt;

/// Create a copy of SensorReading
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SensorReadingCopyWith<_SensorReading> get copyWith => __$SensorReadingCopyWithImpl<_SensorReading>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SensorReadingToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SensorReading&&(identical(other.magnitude, magnitude) || other.magnitude == magnitude)&&(identical(other.value, value) || other.value == value)&&(identical(other.unit, unit) || other.unit == unit)&&(identical(other.capturedAt, capturedAt) || other.capturedAt == capturedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,magnitude,value,unit,capturedAt);

@override
String toString() {
  return 'SensorReading(magnitude: $magnitude, value: $value, unit: $unit, capturedAt: $capturedAt)';
}


}

/// @nodoc
abstract mixin class _$SensorReadingCopyWith<$Res> implements $SensorReadingCopyWith<$Res> {
  factory _$SensorReadingCopyWith(_SensorReading value, $Res Function(_SensorReading) _then) = __$SensorReadingCopyWithImpl;
@override @useResult
$Res call({
 String magnitude, double? value, String unit, String? capturedAt
});




}
/// @nodoc
class __$SensorReadingCopyWithImpl<$Res>
    implements _$SensorReadingCopyWith<$Res> {
  __$SensorReadingCopyWithImpl(this._self, this._then);

  final _SensorReading _self;
  final $Res Function(_SensorReading) _then;

/// Create a copy of SensorReading
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? magnitude = null,Object? value = freezed,Object? unit = null,Object? capturedAt = freezed,}) {
  return _then(_SensorReading(
magnitude: null == magnitude ? _self.magnitude : magnitude // ignore: cast_nullable_to_non_nullable
as String,value: freezed == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as double?,unit: null == unit ? _self.unit : unit // ignore: cast_nullable_to_non_nullable
as String,capturedAt: freezed == capturedAt ? _self.capturedAt : capturedAt // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$DeviceTelemetry {

 String get deviceCode; int? get deviceId; String get name; int? get buildingId;/// `ACTIVE` u `OFFLINE`.
 String get connectionStatus; String? get lastHeartbeatAt; List<SensorReading> get latest;
/// Create a copy of DeviceTelemetry
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DeviceTelemetryCopyWith<DeviceTelemetry> get copyWith => _$DeviceTelemetryCopyWithImpl<DeviceTelemetry>(this as DeviceTelemetry, _$identity);

  /// Serializes this DeviceTelemetry to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DeviceTelemetry&&(identical(other.deviceCode, deviceCode) || other.deviceCode == deviceCode)&&(identical(other.deviceId, deviceId) || other.deviceId == deviceId)&&(identical(other.name, name) || other.name == name)&&(identical(other.buildingId, buildingId) || other.buildingId == buildingId)&&(identical(other.connectionStatus, connectionStatus) || other.connectionStatus == connectionStatus)&&(identical(other.lastHeartbeatAt, lastHeartbeatAt) || other.lastHeartbeatAt == lastHeartbeatAt)&&const DeepCollectionEquality().equals(other.latest, latest));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,deviceCode,deviceId,name,buildingId,connectionStatus,lastHeartbeatAt,const DeepCollectionEquality().hash(latest));

@override
String toString() {
  return 'DeviceTelemetry(deviceCode: $deviceCode, deviceId: $deviceId, name: $name, buildingId: $buildingId, connectionStatus: $connectionStatus, lastHeartbeatAt: $lastHeartbeatAt, latest: $latest)';
}


}

/// @nodoc
abstract mixin class $DeviceTelemetryCopyWith<$Res>  {
  factory $DeviceTelemetryCopyWith(DeviceTelemetry value, $Res Function(DeviceTelemetry) _then) = _$DeviceTelemetryCopyWithImpl;
@useResult
$Res call({
 String deviceCode, int? deviceId, String name, int? buildingId, String connectionStatus, String? lastHeartbeatAt, List<SensorReading> latest
});




}
/// @nodoc
class _$DeviceTelemetryCopyWithImpl<$Res>
    implements $DeviceTelemetryCopyWith<$Res> {
  _$DeviceTelemetryCopyWithImpl(this._self, this._then);

  final DeviceTelemetry _self;
  final $Res Function(DeviceTelemetry) _then;

/// Create a copy of DeviceTelemetry
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? deviceCode = null,Object? deviceId = freezed,Object? name = null,Object? buildingId = freezed,Object? connectionStatus = null,Object? lastHeartbeatAt = freezed,Object? latest = null,}) {
  return _then(_self.copyWith(
deviceCode: null == deviceCode ? _self.deviceCode : deviceCode // ignore: cast_nullable_to_non_nullable
as String,deviceId: freezed == deviceId ? _self.deviceId : deviceId // ignore: cast_nullable_to_non_nullable
as int?,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,buildingId: freezed == buildingId ? _self.buildingId : buildingId // ignore: cast_nullable_to_non_nullable
as int?,connectionStatus: null == connectionStatus ? _self.connectionStatus : connectionStatus // ignore: cast_nullable_to_non_nullable
as String,lastHeartbeatAt: freezed == lastHeartbeatAt ? _self.lastHeartbeatAt : lastHeartbeatAt // ignore: cast_nullable_to_non_nullable
as String?,latest: null == latest ? _self.latest : latest // ignore: cast_nullable_to_non_nullable
as List<SensorReading>,
  ));
}

}


/// Adds pattern-matching-related methods to [DeviceTelemetry].
extension DeviceTelemetryPatterns on DeviceTelemetry {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DeviceTelemetry value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DeviceTelemetry() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DeviceTelemetry value)  $default,){
final _that = this;
switch (_that) {
case _DeviceTelemetry():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DeviceTelemetry value)?  $default,){
final _that = this;
switch (_that) {
case _DeviceTelemetry() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String deviceCode,  int? deviceId,  String name,  int? buildingId,  String connectionStatus,  String? lastHeartbeatAt,  List<SensorReading> latest)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DeviceTelemetry() when $default != null:
return $default(_that.deviceCode,_that.deviceId,_that.name,_that.buildingId,_that.connectionStatus,_that.lastHeartbeatAt,_that.latest);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String deviceCode,  int? deviceId,  String name,  int? buildingId,  String connectionStatus,  String? lastHeartbeatAt,  List<SensorReading> latest)  $default,) {final _that = this;
switch (_that) {
case _DeviceTelemetry():
return $default(_that.deviceCode,_that.deviceId,_that.name,_that.buildingId,_that.connectionStatus,_that.lastHeartbeatAt,_that.latest);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String deviceCode,  int? deviceId,  String name,  int? buildingId,  String connectionStatus,  String? lastHeartbeatAt,  List<SensorReading> latest)?  $default,) {final _that = this;
switch (_that) {
case _DeviceTelemetry() when $default != null:
return $default(_that.deviceCode,_that.deviceId,_that.name,_that.buildingId,_that.connectionStatus,_that.lastHeartbeatAt,_that.latest);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DeviceTelemetry implements DeviceTelemetry {
  const _DeviceTelemetry({required this.deviceCode, this.deviceId, this.name = '', this.buildingId, this.connectionStatus = 'OFFLINE', this.lastHeartbeatAt, final  List<SensorReading> latest = const <SensorReading>[]}): _latest = latest;
  factory _DeviceTelemetry.fromJson(Map<String, dynamic> json) => _$DeviceTelemetryFromJson(json);

@override final  String deviceCode;
@override final  int? deviceId;
@override@JsonKey() final  String name;
@override final  int? buildingId;
/// `ACTIVE` u `OFFLINE`.
@override@JsonKey() final  String connectionStatus;
@override final  String? lastHeartbeatAt;
 final  List<SensorReading> _latest;
@override@JsonKey() List<SensorReading> get latest {
  if (_latest is EqualUnmodifiableListView) return _latest;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_latest);
}


/// Create a copy of DeviceTelemetry
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DeviceTelemetryCopyWith<_DeviceTelemetry> get copyWith => __$DeviceTelemetryCopyWithImpl<_DeviceTelemetry>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DeviceTelemetryToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DeviceTelemetry&&(identical(other.deviceCode, deviceCode) || other.deviceCode == deviceCode)&&(identical(other.deviceId, deviceId) || other.deviceId == deviceId)&&(identical(other.name, name) || other.name == name)&&(identical(other.buildingId, buildingId) || other.buildingId == buildingId)&&(identical(other.connectionStatus, connectionStatus) || other.connectionStatus == connectionStatus)&&(identical(other.lastHeartbeatAt, lastHeartbeatAt) || other.lastHeartbeatAt == lastHeartbeatAt)&&const DeepCollectionEquality().equals(other._latest, _latest));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,deviceCode,deviceId,name,buildingId,connectionStatus,lastHeartbeatAt,const DeepCollectionEquality().hash(_latest));

@override
String toString() {
  return 'DeviceTelemetry(deviceCode: $deviceCode, deviceId: $deviceId, name: $name, buildingId: $buildingId, connectionStatus: $connectionStatus, lastHeartbeatAt: $lastHeartbeatAt, latest: $latest)';
}


}

/// @nodoc
abstract mixin class _$DeviceTelemetryCopyWith<$Res> implements $DeviceTelemetryCopyWith<$Res> {
  factory _$DeviceTelemetryCopyWith(_DeviceTelemetry value, $Res Function(_DeviceTelemetry) _then) = __$DeviceTelemetryCopyWithImpl;
@override @useResult
$Res call({
 String deviceCode, int? deviceId, String name, int? buildingId, String connectionStatus, String? lastHeartbeatAt, List<SensorReading> latest
});




}
/// @nodoc
class __$DeviceTelemetryCopyWithImpl<$Res>
    implements _$DeviceTelemetryCopyWith<$Res> {
  __$DeviceTelemetryCopyWithImpl(this._self, this._then);

  final _DeviceTelemetry _self;
  final $Res Function(_DeviceTelemetry) _then;

/// Create a copy of DeviceTelemetry
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? deviceCode = null,Object? deviceId = freezed,Object? name = null,Object? buildingId = freezed,Object? connectionStatus = null,Object? lastHeartbeatAt = freezed,Object? latest = null,}) {
  return _then(_DeviceTelemetry(
deviceCode: null == deviceCode ? _self.deviceCode : deviceCode // ignore: cast_nullable_to_non_nullable
as String,deviceId: freezed == deviceId ? _self.deviceId : deviceId // ignore: cast_nullable_to_non_nullable
as int?,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,buildingId: freezed == buildingId ? _self.buildingId : buildingId // ignore: cast_nullable_to_non_nullable
as int?,connectionStatus: null == connectionStatus ? _self.connectionStatus : connectionStatus // ignore: cast_nullable_to_non_nullable
as String,lastHeartbeatAt: freezed == lastHeartbeatAt ? _self.lastHeartbeatAt : lastHeartbeatAt // ignore: cast_nullable_to_non_nullable
as String?,latest: null == latest ? _self._latest : latest // ignore: cast_nullable_to_non_nullable
as List<SensorReading>,
  ));
}


}

// dart format on
