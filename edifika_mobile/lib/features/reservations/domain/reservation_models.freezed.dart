// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'reservation_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CommonAreaRule {

 int get maxReservationHours; bool get requiresPayment; double get price; bool get requiresGuarantee; double get guaranteeAmount; bool get allowCancellation; int get penaltyHoursBefore; double get penaltyAmount; bool get requiresApproval;
/// Create a copy of CommonAreaRule
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CommonAreaRuleCopyWith<CommonAreaRule> get copyWith => _$CommonAreaRuleCopyWithImpl<CommonAreaRule>(this as CommonAreaRule, _$identity);

  /// Serializes this CommonAreaRule to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CommonAreaRule&&(identical(other.maxReservationHours, maxReservationHours) || other.maxReservationHours == maxReservationHours)&&(identical(other.requiresPayment, requiresPayment) || other.requiresPayment == requiresPayment)&&(identical(other.price, price) || other.price == price)&&(identical(other.requiresGuarantee, requiresGuarantee) || other.requiresGuarantee == requiresGuarantee)&&(identical(other.guaranteeAmount, guaranteeAmount) || other.guaranteeAmount == guaranteeAmount)&&(identical(other.allowCancellation, allowCancellation) || other.allowCancellation == allowCancellation)&&(identical(other.penaltyHoursBefore, penaltyHoursBefore) || other.penaltyHoursBefore == penaltyHoursBefore)&&(identical(other.penaltyAmount, penaltyAmount) || other.penaltyAmount == penaltyAmount)&&(identical(other.requiresApproval, requiresApproval) || other.requiresApproval == requiresApproval));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,maxReservationHours,requiresPayment,price,requiresGuarantee,guaranteeAmount,allowCancellation,penaltyHoursBefore,penaltyAmount,requiresApproval);

@override
String toString() {
  return 'CommonAreaRule(maxReservationHours: $maxReservationHours, requiresPayment: $requiresPayment, price: $price, requiresGuarantee: $requiresGuarantee, guaranteeAmount: $guaranteeAmount, allowCancellation: $allowCancellation, penaltyHoursBefore: $penaltyHoursBefore, penaltyAmount: $penaltyAmount, requiresApproval: $requiresApproval)';
}


}

/// @nodoc
abstract mixin class $CommonAreaRuleCopyWith<$Res>  {
  factory $CommonAreaRuleCopyWith(CommonAreaRule value, $Res Function(CommonAreaRule) _then) = _$CommonAreaRuleCopyWithImpl;
@useResult
$Res call({
 int maxReservationHours, bool requiresPayment, double price, bool requiresGuarantee, double guaranteeAmount, bool allowCancellation, int penaltyHoursBefore, double penaltyAmount, bool requiresApproval
});




}
/// @nodoc
class _$CommonAreaRuleCopyWithImpl<$Res>
    implements $CommonAreaRuleCopyWith<$Res> {
  _$CommonAreaRuleCopyWithImpl(this._self, this._then);

  final CommonAreaRule _self;
  final $Res Function(CommonAreaRule) _then;

/// Create a copy of CommonAreaRule
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? maxReservationHours = null,Object? requiresPayment = null,Object? price = null,Object? requiresGuarantee = null,Object? guaranteeAmount = null,Object? allowCancellation = null,Object? penaltyHoursBefore = null,Object? penaltyAmount = null,Object? requiresApproval = null,}) {
  return _then(_self.copyWith(
maxReservationHours: null == maxReservationHours ? _self.maxReservationHours : maxReservationHours // ignore: cast_nullable_to_non_nullable
as int,requiresPayment: null == requiresPayment ? _self.requiresPayment : requiresPayment // ignore: cast_nullable_to_non_nullable
as bool,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as double,requiresGuarantee: null == requiresGuarantee ? _self.requiresGuarantee : requiresGuarantee // ignore: cast_nullable_to_non_nullable
as bool,guaranteeAmount: null == guaranteeAmount ? _self.guaranteeAmount : guaranteeAmount // ignore: cast_nullable_to_non_nullable
as double,allowCancellation: null == allowCancellation ? _self.allowCancellation : allowCancellation // ignore: cast_nullable_to_non_nullable
as bool,penaltyHoursBefore: null == penaltyHoursBefore ? _self.penaltyHoursBefore : penaltyHoursBefore // ignore: cast_nullable_to_non_nullable
as int,penaltyAmount: null == penaltyAmount ? _self.penaltyAmount : penaltyAmount // ignore: cast_nullable_to_non_nullable
as double,requiresApproval: null == requiresApproval ? _self.requiresApproval : requiresApproval // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [CommonAreaRule].
extension CommonAreaRulePatterns on CommonAreaRule {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CommonAreaRule value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CommonAreaRule() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CommonAreaRule value)  $default,){
final _that = this;
switch (_that) {
case _CommonAreaRule():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CommonAreaRule value)?  $default,){
final _that = this;
switch (_that) {
case _CommonAreaRule() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int maxReservationHours,  bool requiresPayment,  double price,  bool requiresGuarantee,  double guaranteeAmount,  bool allowCancellation,  int penaltyHoursBefore,  double penaltyAmount,  bool requiresApproval)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CommonAreaRule() when $default != null:
return $default(_that.maxReservationHours,_that.requiresPayment,_that.price,_that.requiresGuarantee,_that.guaranteeAmount,_that.allowCancellation,_that.penaltyHoursBefore,_that.penaltyAmount,_that.requiresApproval);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int maxReservationHours,  bool requiresPayment,  double price,  bool requiresGuarantee,  double guaranteeAmount,  bool allowCancellation,  int penaltyHoursBefore,  double penaltyAmount,  bool requiresApproval)  $default,) {final _that = this;
switch (_that) {
case _CommonAreaRule():
return $default(_that.maxReservationHours,_that.requiresPayment,_that.price,_that.requiresGuarantee,_that.guaranteeAmount,_that.allowCancellation,_that.penaltyHoursBefore,_that.penaltyAmount,_that.requiresApproval);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int maxReservationHours,  bool requiresPayment,  double price,  bool requiresGuarantee,  double guaranteeAmount,  bool allowCancellation,  int penaltyHoursBefore,  double penaltyAmount,  bool requiresApproval)?  $default,) {final _that = this;
switch (_that) {
case _CommonAreaRule() when $default != null:
return $default(_that.maxReservationHours,_that.requiresPayment,_that.price,_that.requiresGuarantee,_that.guaranteeAmount,_that.allowCancellation,_that.penaltyHoursBefore,_that.penaltyAmount,_that.requiresApproval);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CommonAreaRule implements CommonAreaRule {
  const _CommonAreaRule({this.maxReservationHours = 0, this.requiresPayment = false, this.price = 0, this.requiresGuarantee = false, this.guaranteeAmount = 0, this.allowCancellation = true, this.penaltyHoursBefore = 0, this.penaltyAmount = 0, this.requiresApproval = false});
  factory _CommonAreaRule.fromJson(Map<String, dynamic> json) => _$CommonAreaRuleFromJson(json);

@override@JsonKey() final  int maxReservationHours;
@override@JsonKey() final  bool requiresPayment;
@override@JsonKey() final  double price;
@override@JsonKey() final  bool requiresGuarantee;
@override@JsonKey() final  double guaranteeAmount;
@override@JsonKey() final  bool allowCancellation;
@override@JsonKey() final  int penaltyHoursBefore;
@override@JsonKey() final  double penaltyAmount;
@override@JsonKey() final  bool requiresApproval;

/// Create a copy of CommonAreaRule
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CommonAreaRuleCopyWith<_CommonAreaRule> get copyWith => __$CommonAreaRuleCopyWithImpl<_CommonAreaRule>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CommonAreaRuleToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CommonAreaRule&&(identical(other.maxReservationHours, maxReservationHours) || other.maxReservationHours == maxReservationHours)&&(identical(other.requiresPayment, requiresPayment) || other.requiresPayment == requiresPayment)&&(identical(other.price, price) || other.price == price)&&(identical(other.requiresGuarantee, requiresGuarantee) || other.requiresGuarantee == requiresGuarantee)&&(identical(other.guaranteeAmount, guaranteeAmount) || other.guaranteeAmount == guaranteeAmount)&&(identical(other.allowCancellation, allowCancellation) || other.allowCancellation == allowCancellation)&&(identical(other.penaltyHoursBefore, penaltyHoursBefore) || other.penaltyHoursBefore == penaltyHoursBefore)&&(identical(other.penaltyAmount, penaltyAmount) || other.penaltyAmount == penaltyAmount)&&(identical(other.requiresApproval, requiresApproval) || other.requiresApproval == requiresApproval));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,maxReservationHours,requiresPayment,price,requiresGuarantee,guaranteeAmount,allowCancellation,penaltyHoursBefore,penaltyAmount,requiresApproval);

@override
String toString() {
  return 'CommonAreaRule(maxReservationHours: $maxReservationHours, requiresPayment: $requiresPayment, price: $price, requiresGuarantee: $requiresGuarantee, guaranteeAmount: $guaranteeAmount, allowCancellation: $allowCancellation, penaltyHoursBefore: $penaltyHoursBefore, penaltyAmount: $penaltyAmount, requiresApproval: $requiresApproval)';
}


}

/// @nodoc
abstract mixin class _$CommonAreaRuleCopyWith<$Res> implements $CommonAreaRuleCopyWith<$Res> {
  factory _$CommonAreaRuleCopyWith(_CommonAreaRule value, $Res Function(_CommonAreaRule) _then) = __$CommonAreaRuleCopyWithImpl;
@override @useResult
$Res call({
 int maxReservationHours, bool requiresPayment, double price, bool requiresGuarantee, double guaranteeAmount, bool allowCancellation, int penaltyHoursBefore, double penaltyAmount, bool requiresApproval
});




}
/// @nodoc
class __$CommonAreaRuleCopyWithImpl<$Res>
    implements _$CommonAreaRuleCopyWith<$Res> {
  __$CommonAreaRuleCopyWithImpl(this._self, this._then);

  final _CommonAreaRule _self;
  final $Res Function(_CommonAreaRule) _then;

/// Create a copy of CommonAreaRule
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? maxReservationHours = null,Object? requiresPayment = null,Object? price = null,Object? requiresGuarantee = null,Object? guaranteeAmount = null,Object? allowCancellation = null,Object? penaltyHoursBefore = null,Object? penaltyAmount = null,Object? requiresApproval = null,}) {
  return _then(_CommonAreaRule(
maxReservationHours: null == maxReservationHours ? _self.maxReservationHours : maxReservationHours // ignore: cast_nullable_to_non_nullable
as int,requiresPayment: null == requiresPayment ? _self.requiresPayment : requiresPayment // ignore: cast_nullable_to_non_nullable
as bool,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as double,requiresGuarantee: null == requiresGuarantee ? _self.requiresGuarantee : requiresGuarantee // ignore: cast_nullable_to_non_nullable
as bool,guaranteeAmount: null == guaranteeAmount ? _self.guaranteeAmount : guaranteeAmount // ignore: cast_nullable_to_non_nullable
as double,allowCancellation: null == allowCancellation ? _self.allowCancellation : allowCancellation // ignore: cast_nullable_to_non_nullable
as bool,penaltyHoursBefore: null == penaltyHoursBefore ? _self.penaltyHoursBefore : penaltyHoursBefore // ignore: cast_nullable_to_non_nullable
as int,penaltyAmount: null == penaltyAmount ? _self.penaltyAmount : penaltyAmount // ignore: cast_nullable_to_non_nullable
as double,requiresApproval: null == requiresApproval ? _self.requiresApproval : requiresApproval // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$CommonArea {

 int get id; String get name; String get type; String get status; int get maxCapacity; String get bookingType; CommonAreaRule? get rules;
/// Create a copy of CommonArea
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CommonAreaCopyWith<CommonArea> get copyWith => _$CommonAreaCopyWithImpl<CommonArea>(this as CommonArea, _$identity);

  /// Serializes this CommonArea to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CommonArea&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.type, type) || other.type == type)&&(identical(other.status, status) || other.status == status)&&(identical(other.maxCapacity, maxCapacity) || other.maxCapacity == maxCapacity)&&(identical(other.bookingType, bookingType) || other.bookingType == bookingType)&&(identical(other.rules, rules) || other.rules == rules));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,type,status,maxCapacity,bookingType,rules);

@override
String toString() {
  return 'CommonArea(id: $id, name: $name, type: $type, status: $status, maxCapacity: $maxCapacity, bookingType: $bookingType, rules: $rules)';
}


}

/// @nodoc
abstract mixin class $CommonAreaCopyWith<$Res>  {
  factory $CommonAreaCopyWith(CommonArea value, $Res Function(CommonArea) _then) = _$CommonAreaCopyWithImpl;
@useResult
$Res call({
 int id, String name, String type, String status, int maxCapacity, String bookingType, CommonAreaRule? rules
});


$CommonAreaRuleCopyWith<$Res>? get rules;

}
/// @nodoc
class _$CommonAreaCopyWithImpl<$Res>
    implements $CommonAreaCopyWith<$Res> {
  _$CommonAreaCopyWithImpl(this._self, this._then);

  final CommonArea _self;
  final $Res Function(CommonArea) _then;

/// Create a copy of CommonArea
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? type = null,Object? status = null,Object? maxCapacity = null,Object? bookingType = null,Object? rules = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,maxCapacity: null == maxCapacity ? _self.maxCapacity : maxCapacity // ignore: cast_nullable_to_non_nullable
as int,bookingType: null == bookingType ? _self.bookingType : bookingType // ignore: cast_nullable_to_non_nullable
as String,rules: freezed == rules ? _self.rules : rules // ignore: cast_nullable_to_non_nullable
as CommonAreaRule?,
  ));
}
/// Create a copy of CommonArea
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CommonAreaRuleCopyWith<$Res>? get rules {
    if (_self.rules == null) {
    return null;
  }

  return $CommonAreaRuleCopyWith<$Res>(_self.rules!, (value) {
    return _then(_self.copyWith(rules: value));
  });
}
}


/// Adds pattern-matching-related methods to [CommonArea].
extension CommonAreaPatterns on CommonArea {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CommonArea value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CommonArea() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CommonArea value)  $default,){
final _that = this;
switch (_that) {
case _CommonArea():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CommonArea value)?  $default,){
final _that = this;
switch (_that) {
case _CommonArea() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String name,  String type,  String status,  int maxCapacity,  String bookingType,  CommonAreaRule? rules)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CommonArea() when $default != null:
return $default(_that.id,_that.name,_that.type,_that.status,_that.maxCapacity,_that.bookingType,_that.rules);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String name,  String type,  String status,  int maxCapacity,  String bookingType,  CommonAreaRule? rules)  $default,) {final _that = this;
switch (_that) {
case _CommonArea():
return $default(_that.id,_that.name,_that.type,_that.status,_that.maxCapacity,_that.bookingType,_that.rules);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String name,  String type,  String status,  int maxCapacity,  String bookingType,  CommonAreaRule? rules)?  $default,) {final _that = this;
switch (_that) {
case _CommonArea() when $default != null:
return $default(_that.id,_that.name,_that.type,_that.status,_that.maxCapacity,_that.bookingType,_that.rules);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CommonArea extends CommonArea {
  const _CommonArea({required this.id, required this.name, required this.type, required this.status, this.maxCapacity = 0, this.bookingType = 'SHARED', this.rules}): super._();
  factory _CommonArea.fromJson(Map<String, dynamic> json) => _$CommonAreaFromJson(json);

@override final  int id;
@override final  String name;
@override final  String type;
@override final  String status;
@override@JsonKey() final  int maxCapacity;
@override@JsonKey() final  String bookingType;
@override final  CommonAreaRule? rules;

/// Create a copy of CommonArea
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CommonAreaCopyWith<_CommonArea> get copyWith => __$CommonAreaCopyWithImpl<_CommonArea>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CommonAreaToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CommonArea&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.type, type) || other.type == type)&&(identical(other.status, status) || other.status == status)&&(identical(other.maxCapacity, maxCapacity) || other.maxCapacity == maxCapacity)&&(identical(other.bookingType, bookingType) || other.bookingType == bookingType)&&(identical(other.rules, rules) || other.rules == rules));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,type,status,maxCapacity,bookingType,rules);

@override
String toString() {
  return 'CommonArea(id: $id, name: $name, type: $type, status: $status, maxCapacity: $maxCapacity, bookingType: $bookingType, rules: $rules)';
}


}

/// @nodoc
abstract mixin class _$CommonAreaCopyWith<$Res> implements $CommonAreaCopyWith<$Res> {
  factory _$CommonAreaCopyWith(_CommonArea value, $Res Function(_CommonArea) _then) = __$CommonAreaCopyWithImpl;
@override @useResult
$Res call({
 int id, String name, String type, String status, int maxCapacity, String bookingType, CommonAreaRule? rules
});


@override $CommonAreaRuleCopyWith<$Res>? get rules;

}
/// @nodoc
class __$CommonAreaCopyWithImpl<$Res>
    implements _$CommonAreaCopyWith<$Res> {
  __$CommonAreaCopyWithImpl(this._self, this._then);

  final _CommonArea _self;
  final $Res Function(_CommonArea) _then;

/// Create a copy of CommonArea
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? type = null,Object? status = null,Object? maxCapacity = null,Object? bookingType = null,Object? rules = freezed,}) {
  return _then(_CommonArea(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,maxCapacity: null == maxCapacity ? _self.maxCapacity : maxCapacity // ignore: cast_nullable_to_non_nullable
as int,bookingType: null == bookingType ? _self.bookingType : bookingType // ignore: cast_nullable_to_non_nullable
as String,rules: freezed == rules ? _self.rules : rules // ignore: cast_nullable_to_non_nullable
as CommonAreaRule?,
  ));
}

/// Create a copy of CommonArea
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CommonAreaRuleCopyWith<$Res>? get rules {
    if (_self.rules == null) {
    return null;
  }

  return $CommonAreaRuleCopyWith<$Res>(_self.rules!, (value) {
    return _then(_self.copyWith(rules: value));
  });
}
}


/// @nodoc
mixin _$Reservation {

 int get id; int get residentId; int get commonAreaId;/// `yyyy-MM-dd`
 String get reservationDate;/// Hora de inicio (0-23).
 int get timeSlot; int get numberOfGuests; String get status; String get qrCodeAccess; bool get penaltyApplied;
/// Create a copy of Reservation
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReservationCopyWith<Reservation> get copyWith => _$ReservationCopyWithImpl<Reservation>(this as Reservation, _$identity);

  /// Serializes this Reservation to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Reservation&&(identical(other.id, id) || other.id == id)&&(identical(other.residentId, residentId) || other.residentId == residentId)&&(identical(other.commonAreaId, commonAreaId) || other.commonAreaId == commonAreaId)&&(identical(other.reservationDate, reservationDate) || other.reservationDate == reservationDate)&&(identical(other.timeSlot, timeSlot) || other.timeSlot == timeSlot)&&(identical(other.numberOfGuests, numberOfGuests) || other.numberOfGuests == numberOfGuests)&&(identical(other.status, status) || other.status == status)&&(identical(other.qrCodeAccess, qrCodeAccess) || other.qrCodeAccess == qrCodeAccess)&&(identical(other.penaltyApplied, penaltyApplied) || other.penaltyApplied == penaltyApplied));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,residentId,commonAreaId,reservationDate,timeSlot,numberOfGuests,status,qrCodeAccess,penaltyApplied);

@override
String toString() {
  return 'Reservation(id: $id, residentId: $residentId, commonAreaId: $commonAreaId, reservationDate: $reservationDate, timeSlot: $timeSlot, numberOfGuests: $numberOfGuests, status: $status, qrCodeAccess: $qrCodeAccess, penaltyApplied: $penaltyApplied)';
}


}

/// @nodoc
abstract mixin class $ReservationCopyWith<$Res>  {
  factory $ReservationCopyWith(Reservation value, $Res Function(Reservation) _then) = _$ReservationCopyWithImpl;
@useResult
$Res call({
 int id, int residentId, int commonAreaId, String reservationDate, int timeSlot, int numberOfGuests, String status, String qrCodeAccess, bool penaltyApplied
});




}
/// @nodoc
class _$ReservationCopyWithImpl<$Res>
    implements $ReservationCopyWith<$Res> {
  _$ReservationCopyWithImpl(this._self, this._then);

  final Reservation _self;
  final $Res Function(Reservation) _then;

/// Create a copy of Reservation
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? residentId = null,Object? commonAreaId = null,Object? reservationDate = null,Object? timeSlot = null,Object? numberOfGuests = null,Object? status = null,Object? qrCodeAccess = null,Object? penaltyApplied = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,residentId: null == residentId ? _self.residentId : residentId // ignore: cast_nullable_to_non_nullable
as int,commonAreaId: null == commonAreaId ? _self.commonAreaId : commonAreaId // ignore: cast_nullable_to_non_nullable
as int,reservationDate: null == reservationDate ? _self.reservationDate : reservationDate // ignore: cast_nullable_to_non_nullable
as String,timeSlot: null == timeSlot ? _self.timeSlot : timeSlot // ignore: cast_nullable_to_non_nullable
as int,numberOfGuests: null == numberOfGuests ? _self.numberOfGuests : numberOfGuests // ignore: cast_nullable_to_non_nullable
as int,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,qrCodeAccess: null == qrCodeAccess ? _self.qrCodeAccess : qrCodeAccess // ignore: cast_nullable_to_non_nullable
as String,penaltyApplied: null == penaltyApplied ? _self.penaltyApplied : penaltyApplied // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [Reservation].
extension ReservationPatterns on Reservation {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Reservation value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Reservation() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Reservation value)  $default,){
final _that = this;
switch (_that) {
case _Reservation():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Reservation value)?  $default,){
final _that = this;
switch (_that) {
case _Reservation() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  int residentId,  int commonAreaId,  String reservationDate,  int timeSlot,  int numberOfGuests,  String status,  String qrCodeAccess,  bool penaltyApplied)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Reservation() when $default != null:
return $default(_that.id,_that.residentId,_that.commonAreaId,_that.reservationDate,_that.timeSlot,_that.numberOfGuests,_that.status,_that.qrCodeAccess,_that.penaltyApplied);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  int residentId,  int commonAreaId,  String reservationDate,  int timeSlot,  int numberOfGuests,  String status,  String qrCodeAccess,  bool penaltyApplied)  $default,) {final _that = this;
switch (_that) {
case _Reservation():
return $default(_that.id,_that.residentId,_that.commonAreaId,_that.reservationDate,_that.timeSlot,_that.numberOfGuests,_that.status,_that.qrCodeAccess,_that.penaltyApplied);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  int residentId,  int commonAreaId,  String reservationDate,  int timeSlot,  int numberOfGuests,  String status,  String qrCodeAccess,  bool penaltyApplied)?  $default,) {final _that = this;
switch (_that) {
case _Reservation() when $default != null:
return $default(_that.id,_that.residentId,_that.commonAreaId,_that.reservationDate,_that.timeSlot,_that.numberOfGuests,_that.status,_that.qrCodeAccess,_that.penaltyApplied);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Reservation extends Reservation {
  const _Reservation({required this.id, required this.residentId, required this.commonAreaId, required this.reservationDate, required this.timeSlot, this.numberOfGuests = 1, required this.status, this.qrCodeAccess = '', this.penaltyApplied = false}): super._();
  factory _Reservation.fromJson(Map<String, dynamic> json) => _$ReservationFromJson(json);

@override final  int id;
@override final  int residentId;
@override final  int commonAreaId;
/// `yyyy-MM-dd`
@override final  String reservationDate;
/// Hora de inicio (0-23).
@override final  int timeSlot;
@override@JsonKey() final  int numberOfGuests;
@override final  String status;
@override@JsonKey() final  String qrCodeAccess;
@override@JsonKey() final  bool penaltyApplied;

/// Create a copy of Reservation
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ReservationCopyWith<_Reservation> get copyWith => __$ReservationCopyWithImpl<_Reservation>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ReservationToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Reservation&&(identical(other.id, id) || other.id == id)&&(identical(other.residentId, residentId) || other.residentId == residentId)&&(identical(other.commonAreaId, commonAreaId) || other.commonAreaId == commonAreaId)&&(identical(other.reservationDate, reservationDate) || other.reservationDate == reservationDate)&&(identical(other.timeSlot, timeSlot) || other.timeSlot == timeSlot)&&(identical(other.numberOfGuests, numberOfGuests) || other.numberOfGuests == numberOfGuests)&&(identical(other.status, status) || other.status == status)&&(identical(other.qrCodeAccess, qrCodeAccess) || other.qrCodeAccess == qrCodeAccess)&&(identical(other.penaltyApplied, penaltyApplied) || other.penaltyApplied == penaltyApplied));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,residentId,commonAreaId,reservationDate,timeSlot,numberOfGuests,status,qrCodeAccess,penaltyApplied);

@override
String toString() {
  return 'Reservation(id: $id, residentId: $residentId, commonAreaId: $commonAreaId, reservationDate: $reservationDate, timeSlot: $timeSlot, numberOfGuests: $numberOfGuests, status: $status, qrCodeAccess: $qrCodeAccess, penaltyApplied: $penaltyApplied)';
}


}

/// @nodoc
abstract mixin class _$ReservationCopyWith<$Res> implements $ReservationCopyWith<$Res> {
  factory _$ReservationCopyWith(_Reservation value, $Res Function(_Reservation) _then) = __$ReservationCopyWithImpl;
@override @useResult
$Res call({
 int id, int residentId, int commonAreaId, String reservationDate, int timeSlot, int numberOfGuests, String status, String qrCodeAccess, bool penaltyApplied
});




}
/// @nodoc
class __$ReservationCopyWithImpl<$Res>
    implements _$ReservationCopyWith<$Res> {
  __$ReservationCopyWithImpl(this._self, this._then);

  final _Reservation _self;
  final $Res Function(_Reservation) _then;

/// Create a copy of Reservation
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? residentId = null,Object? commonAreaId = null,Object? reservationDate = null,Object? timeSlot = null,Object? numberOfGuests = null,Object? status = null,Object? qrCodeAccess = null,Object? penaltyApplied = null,}) {
  return _then(_Reservation(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,residentId: null == residentId ? _self.residentId : residentId // ignore: cast_nullable_to_non_nullable
as int,commonAreaId: null == commonAreaId ? _self.commonAreaId : commonAreaId // ignore: cast_nullable_to_non_nullable
as int,reservationDate: null == reservationDate ? _self.reservationDate : reservationDate // ignore: cast_nullable_to_non_nullable
as String,timeSlot: null == timeSlot ? _self.timeSlot : timeSlot // ignore: cast_nullable_to_non_nullable
as int,numberOfGuests: null == numberOfGuests ? _self.numberOfGuests : numberOfGuests // ignore: cast_nullable_to_non_nullable
as int,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,qrCodeAccess: null == qrCodeAccess ? _self.qrCodeAccess : qrCodeAccess // ignore: cast_nullable_to_non_nullable
as String,penaltyApplied: null == penaltyApplied ? _self.penaltyApplied : penaltyApplied // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
