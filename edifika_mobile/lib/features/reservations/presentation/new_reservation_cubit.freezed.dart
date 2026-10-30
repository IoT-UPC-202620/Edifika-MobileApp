// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'new_reservation_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$NewReservationState {

 List<CommonArea> get areas; List<Reservation> get reservations; int? get areaId; DateTime get date; int get fromHour; int get toHour; int get guests; bool get acceptedRules; bool get submitting; String? get error; ReservationBlock? get created;
/// Create a copy of NewReservationState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NewReservationStateCopyWith<NewReservationState> get copyWith => _$NewReservationStateCopyWithImpl<NewReservationState>(this as NewReservationState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NewReservationState&&const DeepCollectionEquality().equals(other.areas, areas)&&const DeepCollectionEquality().equals(other.reservations, reservations)&&(identical(other.areaId, areaId) || other.areaId == areaId)&&(identical(other.date, date) || other.date == date)&&(identical(other.fromHour, fromHour) || other.fromHour == fromHour)&&(identical(other.toHour, toHour) || other.toHour == toHour)&&(identical(other.guests, guests) || other.guests == guests)&&(identical(other.acceptedRules, acceptedRules) || other.acceptedRules == acceptedRules)&&(identical(other.submitting, submitting) || other.submitting == submitting)&&(identical(other.error, error) || other.error == error)&&(identical(other.created, created) || other.created == created));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(areas),const DeepCollectionEquality().hash(reservations),areaId,date,fromHour,toHour,guests,acceptedRules,submitting,error,created);

@override
String toString() {
  return 'NewReservationState(areas: $areas, reservations: $reservations, areaId: $areaId, date: $date, fromHour: $fromHour, toHour: $toHour, guests: $guests, acceptedRules: $acceptedRules, submitting: $submitting, error: $error, created: $created)';
}


}

/// @nodoc
abstract mixin class $NewReservationStateCopyWith<$Res>  {
  factory $NewReservationStateCopyWith(NewReservationState value, $Res Function(NewReservationState) _then) = _$NewReservationStateCopyWithImpl;
@useResult
$Res call({
 List<CommonArea> areas, List<Reservation> reservations, int? areaId, DateTime date, int fromHour, int toHour, int guests, bool acceptedRules, bool submitting, String? error, ReservationBlock? created
});




}
/// @nodoc
class _$NewReservationStateCopyWithImpl<$Res>
    implements $NewReservationStateCopyWith<$Res> {
  _$NewReservationStateCopyWithImpl(this._self, this._then);

  final NewReservationState _self;
  final $Res Function(NewReservationState) _then;

/// Create a copy of NewReservationState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? areas = null,Object? reservations = null,Object? areaId = freezed,Object? date = null,Object? fromHour = null,Object? toHour = null,Object? guests = null,Object? acceptedRules = null,Object? submitting = null,Object? error = freezed,Object? created = freezed,}) {
  return _then(_self.copyWith(
areas: null == areas ? _self.areas : areas // ignore: cast_nullable_to_non_nullable
as List<CommonArea>,reservations: null == reservations ? _self.reservations : reservations // ignore: cast_nullable_to_non_nullable
as List<Reservation>,areaId: freezed == areaId ? _self.areaId : areaId // ignore: cast_nullable_to_non_nullable
as int?,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,fromHour: null == fromHour ? _self.fromHour : fromHour // ignore: cast_nullable_to_non_nullable
as int,toHour: null == toHour ? _self.toHour : toHour // ignore: cast_nullable_to_non_nullable
as int,guests: null == guests ? _self.guests : guests // ignore: cast_nullable_to_non_nullable
as int,acceptedRules: null == acceptedRules ? _self.acceptedRules : acceptedRules // ignore: cast_nullable_to_non_nullable
as bool,submitting: null == submitting ? _self.submitting : submitting // ignore: cast_nullable_to_non_nullable
as bool,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,created: freezed == created ? _self.created : created // ignore: cast_nullable_to_non_nullable
as ReservationBlock?,
  ));
}

}


/// Adds pattern-matching-related methods to [NewReservationState].
extension NewReservationStatePatterns on NewReservationState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _NewReservationState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NewReservationState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _NewReservationState value)  $default,){
final _that = this;
switch (_that) {
case _NewReservationState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _NewReservationState value)?  $default,){
final _that = this;
switch (_that) {
case _NewReservationState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<CommonArea> areas,  List<Reservation> reservations,  int? areaId,  DateTime date,  int fromHour,  int toHour,  int guests,  bool acceptedRules,  bool submitting,  String? error,  ReservationBlock? created)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _NewReservationState() when $default != null:
return $default(_that.areas,_that.reservations,_that.areaId,_that.date,_that.fromHour,_that.toHour,_that.guests,_that.acceptedRules,_that.submitting,_that.error,_that.created);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<CommonArea> areas,  List<Reservation> reservations,  int? areaId,  DateTime date,  int fromHour,  int toHour,  int guests,  bool acceptedRules,  bool submitting,  String? error,  ReservationBlock? created)  $default,) {final _that = this;
switch (_that) {
case _NewReservationState():
return $default(_that.areas,_that.reservations,_that.areaId,_that.date,_that.fromHour,_that.toHour,_that.guests,_that.acceptedRules,_that.submitting,_that.error,_that.created);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<CommonArea> areas,  List<Reservation> reservations,  int? areaId,  DateTime date,  int fromHour,  int toHour,  int guests,  bool acceptedRules,  bool submitting,  String? error,  ReservationBlock? created)?  $default,) {final _that = this;
switch (_that) {
case _NewReservationState() when $default != null:
return $default(_that.areas,_that.reservations,_that.areaId,_that.date,_that.fromHour,_that.toHour,_that.guests,_that.acceptedRules,_that.submitting,_that.error,_that.created);case _:
  return null;

}
}

}

/// @nodoc


class _NewReservationState extends NewReservationState {
  const _NewReservationState({required final  List<CommonArea> areas, required final  List<Reservation> reservations, this.areaId, required this.date, this.fromHour = 10, this.toHour = 11, this.guests = 1, this.acceptedRules = false, this.submitting = false, this.error, this.created}): _areas = areas,_reservations = reservations,super._();
  

 final  List<CommonArea> _areas;
@override List<CommonArea> get areas {
  if (_areas is EqualUnmodifiableListView) return _areas;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_areas);
}

 final  List<Reservation> _reservations;
@override List<Reservation> get reservations {
  if (_reservations is EqualUnmodifiableListView) return _reservations;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_reservations);
}

@override final  int? areaId;
@override final  DateTime date;
@override@JsonKey() final  int fromHour;
@override@JsonKey() final  int toHour;
@override@JsonKey() final  int guests;
@override@JsonKey() final  bool acceptedRules;
@override@JsonKey() final  bool submitting;
@override final  String? error;
@override final  ReservationBlock? created;

/// Create a copy of NewReservationState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NewReservationStateCopyWith<_NewReservationState> get copyWith => __$NewReservationStateCopyWithImpl<_NewReservationState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NewReservationState&&const DeepCollectionEquality().equals(other._areas, _areas)&&const DeepCollectionEquality().equals(other._reservations, _reservations)&&(identical(other.areaId, areaId) || other.areaId == areaId)&&(identical(other.date, date) || other.date == date)&&(identical(other.fromHour, fromHour) || other.fromHour == fromHour)&&(identical(other.toHour, toHour) || other.toHour == toHour)&&(identical(other.guests, guests) || other.guests == guests)&&(identical(other.acceptedRules, acceptedRules) || other.acceptedRules == acceptedRules)&&(identical(other.submitting, submitting) || other.submitting == submitting)&&(identical(other.error, error) || other.error == error)&&(identical(other.created, created) || other.created == created));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_areas),const DeepCollectionEquality().hash(_reservations),areaId,date,fromHour,toHour,guests,acceptedRules,submitting,error,created);

@override
String toString() {
  return 'NewReservationState(areas: $areas, reservations: $reservations, areaId: $areaId, date: $date, fromHour: $fromHour, toHour: $toHour, guests: $guests, acceptedRules: $acceptedRules, submitting: $submitting, error: $error, created: $created)';
}


}

/// @nodoc
abstract mixin class _$NewReservationStateCopyWith<$Res> implements $NewReservationStateCopyWith<$Res> {
  factory _$NewReservationStateCopyWith(_NewReservationState value, $Res Function(_NewReservationState) _then) = __$NewReservationStateCopyWithImpl;
@override @useResult
$Res call({
 List<CommonArea> areas, List<Reservation> reservations, int? areaId, DateTime date, int fromHour, int toHour, int guests, bool acceptedRules, bool submitting, String? error, ReservationBlock? created
});




}
/// @nodoc
class __$NewReservationStateCopyWithImpl<$Res>
    implements _$NewReservationStateCopyWith<$Res> {
  __$NewReservationStateCopyWithImpl(this._self, this._then);

  final _NewReservationState _self;
  final $Res Function(_NewReservationState) _then;

/// Create a copy of NewReservationState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? areas = null,Object? reservations = null,Object? areaId = freezed,Object? date = null,Object? fromHour = null,Object? toHour = null,Object? guests = null,Object? acceptedRules = null,Object? submitting = null,Object? error = freezed,Object? created = freezed,}) {
  return _then(_NewReservationState(
areas: null == areas ? _self._areas : areas // ignore: cast_nullable_to_non_nullable
as List<CommonArea>,reservations: null == reservations ? _self._reservations : reservations // ignore: cast_nullable_to_non_nullable
as List<Reservation>,areaId: freezed == areaId ? _self.areaId : areaId // ignore: cast_nullable_to_non_nullable
as int?,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,fromHour: null == fromHour ? _self.fromHour : fromHour // ignore: cast_nullable_to_non_nullable
as int,toHour: null == toHour ? _self.toHour : toHour // ignore: cast_nullable_to_non_nullable
as int,guests: null == guests ? _self.guests : guests // ignore: cast_nullable_to_non_nullable
as int,acceptedRules: null == acceptedRules ? _self.acceptedRules : acceptedRules // ignore: cast_nullable_to_non_nullable
as bool,submitting: null == submitting ? _self.submitting : submitting // ignore: cast_nullable_to_non_nullable
as bool,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,created: freezed == created ? _self.created : created // ignore: cast_nullable_to_non_nullable
as ReservationBlock?,
  ));
}


}

// dart format on
