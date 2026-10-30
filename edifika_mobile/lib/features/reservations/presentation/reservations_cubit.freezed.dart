// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'reservations_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ReservationsState {

 LoadStatus get status; String? get error; List<CommonArea> get areas;/// Todas las reservas del edificio (para calcular disponibilidad).
 List<Reservation> get allReservations; List<ReservationBlock> get upcoming; List<ReservationBlock> get past;
/// Create a copy of ReservationsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReservationsStateCopyWith<ReservationsState> get copyWith => _$ReservationsStateCopyWithImpl<ReservationsState>(this as ReservationsState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReservationsState&&(identical(other.status, status) || other.status == status)&&(identical(other.error, error) || other.error == error)&&const DeepCollectionEquality().equals(other.areas, areas)&&const DeepCollectionEquality().equals(other.allReservations, allReservations)&&const DeepCollectionEquality().equals(other.upcoming, upcoming)&&const DeepCollectionEquality().equals(other.past, past));
}


@override
int get hashCode => Object.hash(runtimeType,status,error,const DeepCollectionEquality().hash(areas),const DeepCollectionEquality().hash(allReservations),const DeepCollectionEquality().hash(upcoming),const DeepCollectionEquality().hash(past));

@override
String toString() {
  return 'ReservationsState(status: $status, error: $error, areas: $areas, allReservations: $allReservations, upcoming: $upcoming, past: $past)';
}


}

/// @nodoc
abstract mixin class $ReservationsStateCopyWith<$Res>  {
  factory $ReservationsStateCopyWith(ReservationsState value, $Res Function(ReservationsState) _then) = _$ReservationsStateCopyWithImpl;
@useResult
$Res call({
 LoadStatus status, String? error, List<CommonArea> areas, List<Reservation> allReservations, List<ReservationBlock> upcoming, List<ReservationBlock> past
});




}
/// @nodoc
class _$ReservationsStateCopyWithImpl<$Res>
    implements $ReservationsStateCopyWith<$Res> {
  _$ReservationsStateCopyWithImpl(this._self, this._then);

  final ReservationsState _self;
  final $Res Function(ReservationsState) _then;

/// Create a copy of ReservationsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? error = freezed,Object? areas = null,Object? allReservations = null,Object? upcoming = null,Object? past = null,}) {
  return _then(_self.copyWith(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as LoadStatus,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,areas: null == areas ? _self.areas : areas // ignore: cast_nullable_to_non_nullable
as List<CommonArea>,allReservations: null == allReservations ? _self.allReservations : allReservations // ignore: cast_nullable_to_non_nullable
as List<Reservation>,upcoming: null == upcoming ? _self.upcoming : upcoming // ignore: cast_nullable_to_non_nullable
as List<ReservationBlock>,past: null == past ? _self.past : past // ignore: cast_nullable_to_non_nullable
as List<ReservationBlock>,
  ));
}

}


/// Adds pattern-matching-related methods to [ReservationsState].
extension ReservationsStatePatterns on ReservationsState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ReservationsState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ReservationsState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ReservationsState value)  $default,){
final _that = this;
switch (_that) {
case _ReservationsState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ReservationsState value)?  $default,){
final _that = this;
switch (_that) {
case _ReservationsState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( LoadStatus status,  String? error,  List<CommonArea> areas,  List<Reservation> allReservations,  List<ReservationBlock> upcoming,  List<ReservationBlock> past)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ReservationsState() when $default != null:
return $default(_that.status,_that.error,_that.areas,_that.allReservations,_that.upcoming,_that.past);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( LoadStatus status,  String? error,  List<CommonArea> areas,  List<Reservation> allReservations,  List<ReservationBlock> upcoming,  List<ReservationBlock> past)  $default,) {final _that = this;
switch (_that) {
case _ReservationsState():
return $default(_that.status,_that.error,_that.areas,_that.allReservations,_that.upcoming,_that.past);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( LoadStatus status,  String? error,  List<CommonArea> areas,  List<Reservation> allReservations,  List<ReservationBlock> upcoming,  List<ReservationBlock> past)?  $default,) {final _that = this;
switch (_that) {
case _ReservationsState() when $default != null:
return $default(_that.status,_that.error,_that.areas,_that.allReservations,_that.upcoming,_that.past);case _:
  return null;

}
}

}

/// @nodoc


class _ReservationsState extends ReservationsState {
  const _ReservationsState({this.status = LoadStatus.loading, this.error, final  List<CommonArea> areas = const <CommonArea>[], final  List<Reservation> allReservations = const <Reservation>[], final  List<ReservationBlock> upcoming = const <ReservationBlock>[], final  List<ReservationBlock> past = const <ReservationBlock>[]}): _areas = areas,_allReservations = allReservations,_upcoming = upcoming,_past = past,super._();
  

@override@JsonKey() final  LoadStatus status;
@override final  String? error;
 final  List<CommonArea> _areas;
@override@JsonKey() List<CommonArea> get areas {
  if (_areas is EqualUnmodifiableListView) return _areas;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_areas);
}

/// Todas las reservas del edificio (para calcular disponibilidad).
 final  List<Reservation> _allReservations;
/// Todas las reservas del edificio (para calcular disponibilidad).
@override@JsonKey() List<Reservation> get allReservations {
  if (_allReservations is EqualUnmodifiableListView) return _allReservations;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_allReservations);
}

 final  List<ReservationBlock> _upcoming;
@override@JsonKey() List<ReservationBlock> get upcoming {
  if (_upcoming is EqualUnmodifiableListView) return _upcoming;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_upcoming);
}

 final  List<ReservationBlock> _past;
@override@JsonKey() List<ReservationBlock> get past {
  if (_past is EqualUnmodifiableListView) return _past;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_past);
}


/// Create a copy of ReservationsState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ReservationsStateCopyWith<_ReservationsState> get copyWith => __$ReservationsStateCopyWithImpl<_ReservationsState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ReservationsState&&(identical(other.status, status) || other.status == status)&&(identical(other.error, error) || other.error == error)&&const DeepCollectionEquality().equals(other._areas, _areas)&&const DeepCollectionEquality().equals(other._allReservations, _allReservations)&&const DeepCollectionEquality().equals(other._upcoming, _upcoming)&&const DeepCollectionEquality().equals(other._past, _past));
}


@override
int get hashCode => Object.hash(runtimeType,status,error,const DeepCollectionEquality().hash(_areas),const DeepCollectionEquality().hash(_allReservations),const DeepCollectionEquality().hash(_upcoming),const DeepCollectionEquality().hash(_past));

@override
String toString() {
  return 'ReservationsState(status: $status, error: $error, areas: $areas, allReservations: $allReservations, upcoming: $upcoming, past: $past)';
}


}

/// @nodoc
abstract mixin class _$ReservationsStateCopyWith<$Res> implements $ReservationsStateCopyWith<$Res> {
  factory _$ReservationsStateCopyWith(_ReservationsState value, $Res Function(_ReservationsState) _then) = __$ReservationsStateCopyWithImpl;
@override @useResult
$Res call({
 LoadStatus status, String? error, List<CommonArea> areas, List<Reservation> allReservations, List<ReservationBlock> upcoming, List<ReservationBlock> past
});




}
/// @nodoc
class __$ReservationsStateCopyWithImpl<$Res>
    implements _$ReservationsStateCopyWith<$Res> {
  __$ReservationsStateCopyWithImpl(this._self, this._then);

  final _ReservationsState _self;
  final $Res Function(_ReservationsState) _then;

/// Create a copy of ReservationsState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? error = freezed,Object? areas = null,Object? allReservations = null,Object? upcoming = null,Object? past = null,}) {
  return _then(_ReservationsState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as LoadStatus,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,areas: null == areas ? _self._areas : areas // ignore: cast_nullable_to_non_nullable
as List<CommonArea>,allReservations: null == allReservations ? _self._allReservations : allReservations // ignore: cast_nullable_to_non_nullable
as List<Reservation>,upcoming: null == upcoming ? _self._upcoming : upcoming // ignore: cast_nullable_to_non_nullable
as List<ReservationBlock>,past: null == past ? _self._past : past // ignore: cast_nullable_to_non_nullable
as List<ReservationBlock>,
  ));
}


}

// dart format on
