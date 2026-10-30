// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'account_cubits.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$DebtsState {

 LoadStatus get status; String? get error;/// Solo deudas pendientes, de la que vence primero a la última.
 List<Debt> get debts;
/// Create a copy of DebtsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DebtsStateCopyWith<DebtsState> get copyWith => _$DebtsStateCopyWithImpl<DebtsState>(this as DebtsState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DebtsState&&(identical(other.status, status) || other.status == status)&&(identical(other.error, error) || other.error == error)&&const DeepCollectionEquality().equals(other.debts, debts));
}


@override
int get hashCode => Object.hash(runtimeType,status,error,const DeepCollectionEquality().hash(debts));

@override
String toString() {
  return 'DebtsState(status: $status, error: $error, debts: $debts)';
}


}

/// @nodoc
abstract mixin class $DebtsStateCopyWith<$Res>  {
  factory $DebtsStateCopyWith(DebtsState value, $Res Function(DebtsState) _then) = _$DebtsStateCopyWithImpl;
@useResult
$Res call({
 LoadStatus status, String? error, List<Debt> debts
});




}
/// @nodoc
class _$DebtsStateCopyWithImpl<$Res>
    implements $DebtsStateCopyWith<$Res> {
  _$DebtsStateCopyWithImpl(this._self, this._then);

  final DebtsState _self;
  final $Res Function(DebtsState) _then;

/// Create a copy of DebtsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? error = freezed,Object? debts = null,}) {
  return _then(_self.copyWith(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as LoadStatus,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,debts: null == debts ? _self.debts : debts // ignore: cast_nullable_to_non_nullable
as List<Debt>,
  ));
}

}


/// Adds pattern-matching-related methods to [DebtsState].
extension DebtsStatePatterns on DebtsState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DebtsState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DebtsState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DebtsState value)  $default,){
final _that = this;
switch (_that) {
case _DebtsState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DebtsState value)?  $default,){
final _that = this;
switch (_that) {
case _DebtsState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( LoadStatus status,  String? error,  List<Debt> debts)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DebtsState() when $default != null:
return $default(_that.status,_that.error,_that.debts);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( LoadStatus status,  String? error,  List<Debt> debts)  $default,) {final _that = this;
switch (_that) {
case _DebtsState():
return $default(_that.status,_that.error,_that.debts);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( LoadStatus status,  String? error,  List<Debt> debts)?  $default,) {final _that = this;
switch (_that) {
case _DebtsState() when $default != null:
return $default(_that.status,_that.error,_that.debts);case _:
  return null;

}
}

}

/// @nodoc


class _DebtsState extends DebtsState {
  const _DebtsState({this.status = LoadStatus.loading, this.error, final  List<Debt> debts = const <Debt>[]}): _debts = debts,super._();
  

@override@JsonKey() final  LoadStatus status;
@override final  String? error;
/// Solo deudas pendientes, de la que vence primero a la última.
 final  List<Debt> _debts;
/// Solo deudas pendientes, de la que vence primero a la última.
@override@JsonKey() List<Debt> get debts {
  if (_debts is EqualUnmodifiableListView) return _debts;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_debts);
}


/// Create a copy of DebtsState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DebtsStateCopyWith<_DebtsState> get copyWith => __$DebtsStateCopyWithImpl<_DebtsState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DebtsState&&(identical(other.status, status) || other.status == status)&&(identical(other.error, error) || other.error == error)&&const DeepCollectionEquality().equals(other._debts, _debts));
}


@override
int get hashCode => Object.hash(runtimeType,status,error,const DeepCollectionEquality().hash(_debts));

@override
String toString() {
  return 'DebtsState(status: $status, error: $error, debts: $debts)';
}


}

/// @nodoc
abstract mixin class _$DebtsStateCopyWith<$Res> implements $DebtsStateCopyWith<$Res> {
  factory _$DebtsStateCopyWith(_DebtsState value, $Res Function(_DebtsState) _then) = __$DebtsStateCopyWithImpl;
@override @useResult
$Res call({
 LoadStatus status, String? error, List<Debt> debts
});




}
/// @nodoc
class __$DebtsStateCopyWithImpl<$Res>
    implements _$DebtsStateCopyWith<$Res> {
  __$DebtsStateCopyWithImpl(this._self, this._then);

  final _DebtsState _self;
  final $Res Function(_DebtsState) _then;

/// Create a copy of DebtsState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? error = freezed,Object? debts = null,}) {
  return _then(_DebtsState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as LoadStatus,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,debts: null == debts ? _self._debts : debts // ignore: cast_nullable_to_non_nullable
as List<Debt>,
  ));
}


}

/// @nodoc
mixin _$PaymentsState {

 LoadStatus get status; String? get error;/// Todos los pagos del residente, del más reciente al más antiguo.
 List<Payment> get payments;/// Concepto de cada deuda pagada (el pago solo trae `debtId`).
 Map<int, String> get conceptByDebtId; int? get year;
/// Create a copy of PaymentsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PaymentsStateCopyWith<PaymentsState> get copyWith => _$PaymentsStateCopyWithImpl<PaymentsState>(this as PaymentsState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PaymentsState&&(identical(other.status, status) || other.status == status)&&(identical(other.error, error) || other.error == error)&&const DeepCollectionEquality().equals(other.payments, payments)&&const DeepCollectionEquality().equals(other.conceptByDebtId, conceptByDebtId)&&(identical(other.year, year) || other.year == year));
}


@override
int get hashCode => Object.hash(runtimeType,status,error,const DeepCollectionEquality().hash(payments),const DeepCollectionEquality().hash(conceptByDebtId),year);

@override
String toString() {
  return 'PaymentsState(status: $status, error: $error, payments: $payments, conceptByDebtId: $conceptByDebtId, year: $year)';
}


}

/// @nodoc
abstract mixin class $PaymentsStateCopyWith<$Res>  {
  factory $PaymentsStateCopyWith(PaymentsState value, $Res Function(PaymentsState) _then) = _$PaymentsStateCopyWithImpl;
@useResult
$Res call({
 LoadStatus status, String? error, List<Payment> payments, Map<int, String> conceptByDebtId, int? year
});




}
/// @nodoc
class _$PaymentsStateCopyWithImpl<$Res>
    implements $PaymentsStateCopyWith<$Res> {
  _$PaymentsStateCopyWithImpl(this._self, this._then);

  final PaymentsState _self;
  final $Res Function(PaymentsState) _then;

/// Create a copy of PaymentsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? error = freezed,Object? payments = null,Object? conceptByDebtId = null,Object? year = freezed,}) {
  return _then(_self.copyWith(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as LoadStatus,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,payments: null == payments ? _self.payments : payments // ignore: cast_nullable_to_non_nullable
as List<Payment>,conceptByDebtId: null == conceptByDebtId ? _self.conceptByDebtId : conceptByDebtId // ignore: cast_nullable_to_non_nullable
as Map<int, String>,year: freezed == year ? _self.year : year // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [PaymentsState].
extension PaymentsStatePatterns on PaymentsState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PaymentsState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PaymentsState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PaymentsState value)  $default,){
final _that = this;
switch (_that) {
case _PaymentsState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PaymentsState value)?  $default,){
final _that = this;
switch (_that) {
case _PaymentsState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( LoadStatus status,  String? error,  List<Payment> payments,  Map<int, String> conceptByDebtId,  int? year)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PaymentsState() when $default != null:
return $default(_that.status,_that.error,_that.payments,_that.conceptByDebtId,_that.year);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( LoadStatus status,  String? error,  List<Payment> payments,  Map<int, String> conceptByDebtId,  int? year)  $default,) {final _that = this;
switch (_that) {
case _PaymentsState():
return $default(_that.status,_that.error,_that.payments,_that.conceptByDebtId,_that.year);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( LoadStatus status,  String? error,  List<Payment> payments,  Map<int, String> conceptByDebtId,  int? year)?  $default,) {final _that = this;
switch (_that) {
case _PaymentsState() when $default != null:
return $default(_that.status,_that.error,_that.payments,_that.conceptByDebtId,_that.year);case _:
  return null;

}
}

}

/// @nodoc


class _PaymentsState extends PaymentsState {
  const _PaymentsState({this.status = LoadStatus.loading, this.error, final  List<Payment> payments = const <Payment>[], final  Map<int, String> conceptByDebtId = const <int, String>{}, this.year}): _payments = payments,_conceptByDebtId = conceptByDebtId,super._();
  

@override@JsonKey() final  LoadStatus status;
@override final  String? error;
/// Todos los pagos del residente, del más reciente al más antiguo.
 final  List<Payment> _payments;
/// Todos los pagos del residente, del más reciente al más antiguo.
@override@JsonKey() List<Payment> get payments {
  if (_payments is EqualUnmodifiableListView) return _payments;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_payments);
}

/// Concepto de cada deuda pagada (el pago solo trae `debtId`).
 final  Map<int, String> _conceptByDebtId;
/// Concepto de cada deuda pagada (el pago solo trae `debtId`).
@override@JsonKey() Map<int, String> get conceptByDebtId {
  if (_conceptByDebtId is EqualUnmodifiableMapView) return _conceptByDebtId;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_conceptByDebtId);
}

@override final  int? year;

/// Create a copy of PaymentsState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PaymentsStateCopyWith<_PaymentsState> get copyWith => __$PaymentsStateCopyWithImpl<_PaymentsState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PaymentsState&&(identical(other.status, status) || other.status == status)&&(identical(other.error, error) || other.error == error)&&const DeepCollectionEquality().equals(other._payments, _payments)&&const DeepCollectionEquality().equals(other._conceptByDebtId, _conceptByDebtId)&&(identical(other.year, year) || other.year == year));
}


@override
int get hashCode => Object.hash(runtimeType,status,error,const DeepCollectionEquality().hash(_payments),const DeepCollectionEquality().hash(_conceptByDebtId),year);

@override
String toString() {
  return 'PaymentsState(status: $status, error: $error, payments: $payments, conceptByDebtId: $conceptByDebtId, year: $year)';
}


}

/// @nodoc
abstract mixin class _$PaymentsStateCopyWith<$Res> implements $PaymentsStateCopyWith<$Res> {
  factory _$PaymentsStateCopyWith(_PaymentsState value, $Res Function(_PaymentsState) _then) = __$PaymentsStateCopyWithImpl;
@override @useResult
$Res call({
 LoadStatus status, String? error, List<Payment> payments, Map<int, String> conceptByDebtId, int? year
});




}
/// @nodoc
class __$PaymentsStateCopyWithImpl<$Res>
    implements _$PaymentsStateCopyWith<$Res> {
  __$PaymentsStateCopyWithImpl(this._self, this._then);

  final _PaymentsState _self;
  final $Res Function(_PaymentsState) _then;

/// Create a copy of PaymentsState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? error = freezed,Object? payments = null,Object? conceptByDebtId = null,Object? year = freezed,}) {
  return _then(_PaymentsState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as LoadStatus,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,payments: null == payments ? _self._payments : payments // ignore: cast_nullable_to_non_nullable
as List<Payment>,conceptByDebtId: null == conceptByDebtId ? _self._conceptByDebtId : conceptByDebtId // ignore: cast_nullable_to_non_nullable
as Map<int, String>,year: freezed == year ? _self.year : year // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

// dart format on
