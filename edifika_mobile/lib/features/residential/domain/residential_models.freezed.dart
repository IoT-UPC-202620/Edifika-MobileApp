// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'residential_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Building {

@JsonKey(readValue: _readBuildingId) int get id; String get name; String get address; String get district; String get city;
/// Create a copy of Building
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BuildingCopyWith<Building> get copyWith => _$BuildingCopyWithImpl<Building>(this as Building, _$identity);

  /// Serializes this Building to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Building&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.address, address) || other.address == address)&&(identical(other.district, district) || other.district == district)&&(identical(other.city, city) || other.city == city));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,address,district,city);

@override
String toString() {
  return 'Building(id: $id, name: $name, address: $address, district: $district, city: $city)';
}


}

/// @nodoc
abstract mixin class $BuildingCopyWith<$Res>  {
  factory $BuildingCopyWith(Building value, $Res Function(Building) _then) = _$BuildingCopyWithImpl;
@useResult
$Res call({
@JsonKey(readValue: _readBuildingId) int id, String name, String address, String district, String city
});




}
/// @nodoc
class _$BuildingCopyWithImpl<$Res>
    implements $BuildingCopyWith<$Res> {
  _$BuildingCopyWithImpl(this._self, this._then);

  final Building _self;
  final $Res Function(Building) _then;

/// Create a copy of Building
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? address = null,Object? district = null,Object? city = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,address: null == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String,district: null == district ? _self.district : district // ignore: cast_nullable_to_non_nullable
as String,city: null == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [Building].
extension BuildingPatterns on Building {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Building value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Building() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Building value)  $default,){
final _that = this;
switch (_that) {
case _Building():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Building value)?  $default,){
final _that = this;
switch (_that) {
case _Building() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(readValue: _readBuildingId)  int id,  String name,  String address,  String district,  String city)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Building() when $default != null:
return $default(_that.id,_that.name,_that.address,_that.district,_that.city);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(readValue: _readBuildingId)  int id,  String name,  String address,  String district,  String city)  $default,) {final _that = this;
switch (_that) {
case _Building():
return $default(_that.id,_that.name,_that.address,_that.district,_that.city);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(readValue: _readBuildingId)  int id,  String name,  String address,  String district,  String city)?  $default,) {final _that = this;
switch (_that) {
case _Building() when $default != null:
return $default(_that.id,_that.name,_that.address,_that.district,_that.city);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Building implements Building {
  const _Building({@JsonKey(readValue: _readBuildingId) required this.id, required this.name, this.address = '', this.district = '', this.city = ''});
  factory _Building.fromJson(Map<String, dynamic> json) => _$BuildingFromJson(json);

@override@JsonKey(readValue: _readBuildingId) final  int id;
@override final  String name;
@override@JsonKey() final  String address;
@override@JsonKey() final  String district;
@override@JsonKey() final  String city;

/// Create a copy of Building
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BuildingCopyWith<_Building> get copyWith => __$BuildingCopyWithImpl<_Building>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BuildingToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Building&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.address, address) || other.address == address)&&(identical(other.district, district) || other.district == district)&&(identical(other.city, city) || other.city == city));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,address,district,city);

@override
String toString() {
  return 'Building(id: $id, name: $name, address: $address, district: $district, city: $city)';
}


}

/// @nodoc
abstract mixin class _$BuildingCopyWith<$Res> implements $BuildingCopyWith<$Res> {
  factory _$BuildingCopyWith(_Building value, $Res Function(_Building) _then) = __$BuildingCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(readValue: _readBuildingId) int id, String name, String address, String district, String city
});




}
/// @nodoc
class __$BuildingCopyWithImpl<$Res>
    implements _$BuildingCopyWith<$Res> {
  __$BuildingCopyWithImpl(this._self, this._then);

  final _Building _self;
  final $Res Function(_Building) _then;

/// Create a copy of Building
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? address = null,Object? district = null,Object? city = null,}) {
  return _then(_Building(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,address: null == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String,district: null == district ? _self.district : district // ignore: cast_nullable_to_non_nullable
as String,city: null == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$Unit {

@JsonKey(readValue: _readUnitId) int get id; int get idBuilding; int get unitNumber; int get floor; double get coveredArea; double get totalArea; double get participationPercentage; String get status;
/// Create a copy of Unit
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UnitCopyWith<Unit> get copyWith => _$UnitCopyWithImpl<Unit>(this as Unit, _$identity);

  /// Serializes this Unit to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Unit&&(identical(other.id, id) || other.id == id)&&(identical(other.idBuilding, idBuilding) || other.idBuilding == idBuilding)&&(identical(other.unitNumber, unitNumber) || other.unitNumber == unitNumber)&&(identical(other.floor, floor) || other.floor == floor)&&(identical(other.coveredArea, coveredArea) || other.coveredArea == coveredArea)&&(identical(other.totalArea, totalArea) || other.totalArea == totalArea)&&(identical(other.participationPercentage, participationPercentage) || other.participationPercentage == participationPercentage)&&(identical(other.status, status) || other.status == status));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,idBuilding,unitNumber,floor,coveredArea,totalArea,participationPercentage,status);

@override
String toString() {
  return 'Unit(id: $id, idBuilding: $idBuilding, unitNumber: $unitNumber, floor: $floor, coveredArea: $coveredArea, totalArea: $totalArea, participationPercentage: $participationPercentage, status: $status)';
}


}

/// @nodoc
abstract mixin class $UnitCopyWith<$Res>  {
  factory $UnitCopyWith(Unit value, $Res Function(Unit) _then) = _$UnitCopyWithImpl;
@useResult
$Res call({
@JsonKey(readValue: _readUnitId) int id, int idBuilding, int unitNumber, int floor, double coveredArea, double totalArea, double participationPercentage, String status
});




}
/// @nodoc
class _$UnitCopyWithImpl<$Res>
    implements $UnitCopyWith<$Res> {
  _$UnitCopyWithImpl(this._self, this._then);

  final Unit _self;
  final $Res Function(Unit) _then;

/// Create a copy of Unit
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? idBuilding = null,Object? unitNumber = null,Object? floor = null,Object? coveredArea = null,Object? totalArea = null,Object? participationPercentage = null,Object? status = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,idBuilding: null == idBuilding ? _self.idBuilding : idBuilding // ignore: cast_nullable_to_non_nullable
as int,unitNumber: null == unitNumber ? _self.unitNumber : unitNumber // ignore: cast_nullable_to_non_nullable
as int,floor: null == floor ? _self.floor : floor // ignore: cast_nullable_to_non_nullable
as int,coveredArea: null == coveredArea ? _self.coveredArea : coveredArea // ignore: cast_nullable_to_non_nullable
as double,totalArea: null == totalArea ? _self.totalArea : totalArea // ignore: cast_nullable_to_non_nullable
as double,participationPercentage: null == participationPercentage ? _self.participationPercentage : participationPercentage // ignore: cast_nullable_to_non_nullable
as double,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [Unit].
extension UnitPatterns on Unit {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Unit value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Unit() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Unit value)  $default,){
final _that = this;
switch (_that) {
case _Unit():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Unit value)?  $default,){
final _that = this;
switch (_that) {
case _Unit() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(readValue: _readUnitId)  int id,  int idBuilding,  int unitNumber,  int floor,  double coveredArea,  double totalArea,  double participationPercentage,  String status)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Unit() when $default != null:
return $default(_that.id,_that.idBuilding,_that.unitNumber,_that.floor,_that.coveredArea,_that.totalArea,_that.participationPercentage,_that.status);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(readValue: _readUnitId)  int id,  int idBuilding,  int unitNumber,  int floor,  double coveredArea,  double totalArea,  double participationPercentage,  String status)  $default,) {final _that = this;
switch (_that) {
case _Unit():
return $default(_that.id,_that.idBuilding,_that.unitNumber,_that.floor,_that.coveredArea,_that.totalArea,_that.participationPercentage,_that.status);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(readValue: _readUnitId)  int id,  int idBuilding,  int unitNumber,  int floor,  double coveredArea,  double totalArea,  double participationPercentage,  String status)?  $default,) {final _that = this;
switch (_that) {
case _Unit() when $default != null:
return $default(_that.id,_that.idBuilding,_that.unitNumber,_that.floor,_that.coveredArea,_that.totalArea,_that.participationPercentage,_that.status);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Unit implements Unit {
  const _Unit({@JsonKey(readValue: _readUnitId) required this.id, required this.idBuilding, required this.unitNumber, required this.floor, this.coveredArea = 0, this.totalArea = 0, this.participationPercentage = 0, this.status = ''});
  factory _Unit.fromJson(Map<String, dynamic> json) => _$UnitFromJson(json);

@override@JsonKey(readValue: _readUnitId) final  int id;
@override final  int idBuilding;
@override final  int unitNumber;
@override final  int floor;
@override@JsonKey() final  double coveredArea;
@override@JsonKey() final  double totalArea;
@override@JsonKey() final  double participationPercentage;
@override@JsonKey() final  String status;

/// Create a copy of Unit
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UnitCopyWith<_Unit> get copyWith => __$UnitCopyWithImpl<_Unit>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UnitToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Unit&&(identical(other.id, id) || other.id == id)&&(identical(other.idBuilding, idBuilding) || other.idBuilding == idBuilding)&&(identical(other.unitNumber, unitNumber) || other.unitNumber == unitNumber)&&(identical(other.floor, floor) || other.floor == floor)&&(identical(other.coveredArea, coveredArea) || other.coveredArea == coveredArea)&&(identical(other.totalArea, totalArea) || other.totalArea == totalArea)&&(identical(other.participationPercentage, participationPercentage) || other.participationPercentage == participationPercentage)&&(identical(other.status, status) || other.status == status));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,idBuilding,unitNumber,floor,coveredArea,totalArea,participationPercentage,status);

@override
String toString() {
  return 'Unit(id: $id, idBuilding: $idBuilding, unitNumber: $unitNumber, floor: $floor, coveredArea: $coveredArea, totalArea: $totalArea, participationPercentage: $participationPercentage, status: $status)';
}


}

/// @nodoc
abstract mixin class _$UnitCopyWith<$Res> implements $UnitCopyWith<$Res> {
  factory _$UnitCopyWith(_Unit value, $Res Function(_Unit) _then) = __$UnitCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(readValue: _readUnitId) int id, int idBuilding, int unitNumber, int floor, double coveredArea, double totalArea, double participationPercentage, String status
});




}
/// @nodoc
class __$UnitCopyWithImpl<$Res>
    implements _$UnitCopyWith<$Res> {
  __$UnitCopyWithImpl(this._self, this._then);

  final _Unit _self;
  final $Res Function(_Unit) _then;

/// Create a copy of Unit
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? idBuilding = null,Object? unitNumber = null,Object? floor = null,Object? coveredArea = null,Object? totalArea = null,Object? participationPercentage = null,Object? status = null,}) {
  return _then(_Unit(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,idBuilding: null == idBuilding ? _self.idBuilding : idBuilding // ignore: cast_nullable_to_non_nullable
as int,unitNumber: null == unitNumber ? _self.unitNumber : unitNumber // ignore: cast_nullable_to_non_nullable
as int,floor: null == floor ? _self.floor : floor // ignore: cast_nullable_to_non_nullable
as int,coveredArea: null == coveredArea ? _self.coveredArea : coveredArea // ignore: cast_nullable_to_non_nullable
as double,totalArea: null == totalArea ? _self.totalArea : totalArea // ignore: cast_nullable_to_non_nullable
as double,participationPercentage: null == participationPercentage ? _self.participationPercentage : participationPercentage // ignore: cast_nullable_to_non_nullable
as double,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$UserUnit {

@JsonKey(readValue: _readUserUnitId) int get id; int get idUnit; int get idUser; int? get idBuilding; String? get startDate; String? get endDate; String get status;
/// Create a copy of UserUnit
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserUnitCopyWith<UserUnit> get copyWith => _$UserUnitCopyWithImpl<UserUnit>(this as UserUnit, _$identity);

  /// Serializes this UserUnit to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserUnit&&(identical(other.id, id) || other.id == id)&&(identical(other.idUnit, idUnit) || other.idUnit == idUnit)&&(identical(other.idUser, idUser) || other.idUser == idUser)&&(identical(other.idBuilding, idBuilding) || other.idBuilding == idBuilding)&&(identical(other.startDate, startDate) || other.startDate == startDate)&&(identical(other.endDate, endDate) || other.endDate == endDate)&&(identical(other.status, status) || other.status == status));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,idUnit,idUser,idBuilding,startDate,endDate,status);

@override
String toString() {
  return 'UserUnit(id: $id, idUnit: $idUnit, idUser: $idUser, idBuilding: $idBuilding, startDate: $startDate, endDate: $endDate, status: $status)';
}


}

/// @nodoc
abstract mixin class $UserUnitCopyWith<$Res>  {
  factory $UserUnitCopyWith(UserUnit value, $Res Function(UserUnit) _then) = _$UserUnitCopyWithImpl;
@useResult
$Res call({
@JsonKey(readValue: _readUserUnitId) int id, int idUnit, int idUser, int? idBuilding, String? startDate, String? endDate, String status
});




}
/// @nodoc
class _$UserUnitCopyWithImpl<$Res>
    implements $UserUnitCopyWith<$Res> {
  _$UserUnitCopyWithImpl(this._self, this._then);

  final UserUnit _self;
  final $Res Function(UserUnit) _then;

/// Create a copy of UserUnit
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? idUnit = null,Object? idUser = null,Object? idBuilding = freezed,Object? startDate = freezed,Object? endDate = freezed,Object? status = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,idUnit: null == idUnit ? _self.idUnit : idUnit // ignore: cast_nullable_to_non_nullable
as int,idUser: null == idUser ? _self.idUser : idUser // ignore: cast_nullable_to_non_nullable
as int,idBuilding: freezed == idBuilding ? _self.idBuilding : idBuilding // ignore: cast_nullable_to_non_nullable
as int?,startDate: freezed == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as String?,endDate: freezed == endDate ? _self.endDate : endDate // ignore: cast_nullable_to_non_nullable
as String?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [UserUnit].
extension UserUnitPatterns on UserUnit {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UserUnit value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UserUnit() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UserUnit value)  $default,){
final _that = this;
switch (_that) {
case _UserUnit():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UserUnit value)?  $default,){
final _that = this;
switch (_that) {
case _UserUnit() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(readValue: _readUserUnitId)  int id,  int idUnit,  int idUser,  int? idBuilding,  String? startDate,  String? endDate,  String status)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UserUnit() when $default != null:
return $default(_that.id,_that.idUnit,_that.idUser,_that.idBuilding,_that.startDate,_that.endDate,_that.status);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(readValue: _readUserUnitId)  int id,  int idUnit,  int idUser,  int? idBuilding,  String? startDate,  String? endDate,  String status)  $default,) {final _that = this;
switch (_that) {
case _UserUnit():
return $default(_that.id,_that.idUnit,_that.idUser,_that.idBuilding,_that.startDate,_that.endDate,_that.status);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(readValue: _readUserUnitId)  int id,  int idUnit,  int idUser,  int? idBuilding,  String? startDate,  String? endDate,  String status)?  $default,) {final _that = this;
switch (_that) {
case _UserUnit() when $default != null:
return $default(_that.id,_that.idUnit,_that.idUser,_that.idBuilding,_that.startDate,_that.endDate,_that.status);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UserUnit extends UserUnit {
  const _UserUnit({@JsonKey(readValue: _readUserUnitId) required this.id, required this.idUnit, required this.idUser, this.idBuilding, this.startDate, this.endDate, this.status = ''}): super._();
  factory _UserUnit.fromJson(Map<String, dynamic> json) => _$UserUnitFromJson(json);

@override@JsonKey(readValue: _readUserUnitId) final  int id;
@override final  int idUnit;
@override final  int idUser;
@override final  int? idBuilding;
@override final  String? startDate;
@override final  String? endDate;
@override@JsonKey() final  String status;

/// Create a copy of UserUnit
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserUnitCopyWith<_UserUnit> get copyWith => __$UserUnitCopyWithImpl<_UserUnit>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UserUnitToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserUnit&&(identical(other.id, id) || other.id == id)&&(identical(other.idUnit, idUnit) || other.idUnit == idUnit)&&(identical(other.idUser, idUser) || other.idUser == idUser)&&(identical(other.idBuilding, idBuilding) || other.idBuilding == idBuilding)&&(identical(other.startDate, startDate) || other.startDate == startDate)&&(identical(other.endDate, endDate) || other.endDate == endDate)&&(identical(other.status, status) || other.status == status));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,idUnit,idUser,idBuilding,startDate,endDate,status);

@override
String toString() {
  return 'UserUnit(id: $id, idUnit: $idUnit, idUser: $idUser, idBuilding: $idBuilding, startDate: $startDate, endDate: $endDate, status: $status)';
}


}

/// @nodoc
abstract mixin class _$UserUnitCopyWith<$Res> implements $UserUnitCopyWith<$Res> {
  factory _$UserUnitCopyWith(_UserUnit value, $Res Function(_UserUnit) _then) = __$UserUnitCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(readValue: _readUserUnitId) int id, int idUnit, int idUser, int? idBuilding, String? startDate, String? endDate, String status
});




}
/// @nodoc
class __$UserUnitCopyWithImpl<$Res>
    implements _$UserUnitCopyWith<$Res> {
  __$UserUnitCopyWithImpl(this._self, this._then);

  final _UserUnit _self;
  final $Res Function(_UserUnit) _then;

/// Create a copy of UserUnit
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? idUnit = null,Object? idUser = null,Object? idBuilding = freezed,Object? startDate = freezed,Object? endDate = freezed,Object? status = null,}) {
  return _then(_UserUnit(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,idUnit: null == idUnit ? _self.idUnit : idUnit // ignore: cast_nullable_to_non_nullable
as int,idUser: null == idUser ? _self.idUser : idUser // ignore: cast_nullable_to_non_nullable
as int,idBuilding: freezed == idBuilding ? _self.idBuilding : idBuilding // ignore: cast_nullable_to_non_nullable
as int?,startDate: freezed == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as String?,endDate: freezed == endDate ? _self.endDate : endDate // ignore: cast_nullable_to_non_nullable
as String?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
