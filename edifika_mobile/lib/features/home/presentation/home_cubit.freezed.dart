// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'home_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$HomeState {

 LoadStatus get status; String? get error; double get pendingTotal; double get overdueTotal; String get currency; ReservationBlock? get nextReservation; String? get nextReservationArea; int get unreadNotifications; Announcement? get latestAnnouncement;/// La fake API no tiene comunicados: el bloque se muestra como pendiente.
 bool get announcementsUnavailable;
/// Create a copy of HomeState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HomeStateCopyWith<HomeState> get copyWith => _$HomeStateCopyWithImpl<HomeState>(this as HomeState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HomeState&&(identical(other.status, status) || other.status == status)&&(identical(other.error, error) || other.error == error)&&(identical(other.pendingTotal, pendingTotal) || other.pendingTotal == pendingTotal)&&(identical(other.overdueTotal, overdueTotal) || other.overdueTotal == overdueTotal)&&(identical(other.currency, currency) || other.currency == currency)&&(identical(other.nextReservation, nextReservation) || other.nextReservation == nextReservation)&&(identical(other.nextReservationArea, nextReservationArea) || other.nextReservationArea == nextReservationArea)&&(identical(other.unreadNotifications, unreadNotifications) || other.unreadNotifications == unreadNotifications)&&(identical(other.latestAnnouncement, latestAnnouncement) || other.latestAnnouncement == latestAnnouncement)&&(identical(other.announcementsUnavailable, announcementsUnavailable) || other.announcementsUnavailable == announcementsUnavailable));
}


@override
int get hashCode => Object.hash(runtimeType,status,error,pendingTotal,overdueTotal,currency,nextReservation,nextReservationArea,unreadNotifications,latestAnnouncement,announcementsUnavailable);

@override
String toString() {
  return 'HomeState(status: $status, error: $error, pendingTotal: $pendingTotal, overdueTotal: $overdueTotal, currency: $currency, nextReservation: $nextReservation, nextReservationArea: $nextReservationArea, unreadNotifications: $unreadNotifications, latestAnnouncement: $latestAnnouncement, announcementsUnavailable: $announcementsUnavailable)';
}


}

/// @nodoc
abstract mixin class $HomeStateCopyWith<$Res>  {
  factory $HomeStateCopyWith(HomeState value, $Res Function(HomeState) _then) = _$HomeStateCopyWithImpl;
@useResult
$Res call({
 LoadStatus status, String? error, double pendingTotal, double overdueTotal, String currency, ReservationBlock? nextReservation, String? nextReservationArea, int unreadNotifications, Announcement? latestAnnouncement, bool announcementsUnavailable
});


$AnnouncementCopyWith<$Res>? get latestAnnouncement;

}
/// @nodoc
class _$HomeStateCopyWithImpl<$Res>
    implements $HomeStateCopyWith<$Res> {
  _$HomeStateCopyWithImpl(this._self, this._then);

  final HomeState _self;
  final $Res Function(HomeState) _then;

/// Create a copy of HomeState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? error = freezed,Object? pendingTotal = null,Object? overdueTotal = null,Object? currency = null,Object? nextReservation = freezed,Object? nextReservationArea = freezed,Object? unreadNotifications = null,Object? latestAnnouncement = freezed,Object? announcementsUnavailable = null,}) {
  return _then(_self.copyWith(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as LoadStatus,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,pendingTotal: null == pendingTotal ? _self.pendingTotal : pendingTotal // ignore: cast_nullable_to_non_nullable
as double,overdueTotal: null == overdueTotal ? _self.overdueTotal : overdueTotal // ignore: cast_nullable_to_non_nullable
as double,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String,nextReservation: freezed == nextReservation ? _self.nextReservation : nextReservation // ignore: cast_nullable_to_non_nullable
as ReservationBlock?,nextReservationArea: freezed == nextReservationArea ? _self.nextReservationArea : nextReservationArea // ignore: cast_nullable_to_non_nullable
as String?,unreadNotifications: null == unreadNotifications ? _self.unreadNotifications : unreadNotifications // ignore: cast_nullable_to_non_nullable
as int,latestAnnouncement: freezed == latestAnnouncement ? _self.latestAnnouncement : latestAnnouncement // ignore: cast_nullable_to_non_nullable
as Announcement?,announcementsUnavailable: null == announcementsUnavailable ? _self.announcementsUnavailable : announcementsUnavailable // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}
/// Create a copy of HomeState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AnnouncementCopyWith<$Res>? get latestAnnouncement {
    if (_self.latestAnnouncement == null) {
    return null;
  }

  return $AnnouncementCopyWith<$Res>(_self.latestAnnouncement!, (value) {
    return _then(_self.copyWith(latestAnnouncement: value));
  });
}
}


/// Adds pattern-matching-related methods to [HomeState].
extension HomeStatePatterns on HomeState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _HomeState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _HomeState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _HomeState value)  $default,){
final _that = this;
switch (_that) {
case _HomeState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _HomeState value)?  $default,){
final _that = this;
switch (_that) {
case _HomeState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( LoadStatus status,  String? error,  double pendingTotal,  double overdueTotal,  String currency,  ReservationBlock? nextReservation,  String? nextReservationArea,  int unreadNotifications,  Announcement? latestAnnouncement,  bool announcementsUnavailable)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _HomeState() when $default != null:
return $default(_that.status,_that.error,_that.pendingTotal,_that.overdueTotal,_that.currency,_that.nextReservation,_that.nextReservationArea,_that.unreadNotifications,_that.latestAnnouncement,_that.announcementsUnavailable);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( LoadStatus status,  String? error,  double pendingTotal,  double overdueTotal,  String currency,  ReservationBlock? nextReservation,  String? nextReservationArea,  int unreadNotifications,  Announcement? latestAnnouncement,  bool announcementsUnavailable)  $default,) {final _that = this;
switch (_that) {
case _HomeState():
return $default(_that.status,_that.error,_that.pendingTotal,_that.overdueTotal,_that.currency,_that.nextReservation,_that.nextReservationArea,_that.unreadNotifications,_that.latestAnnouncement,_that.announcementsUnavailable);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( LoadStatus status,  String? error,  double pendingTotal,  double overdueTotal,  String currency,  ReservationBlock? nextReservation,  String? nextReservationArea,  int unreadNotifications,  Announcement? latestAnnouncement,  bool announcementsUnavailable)?  $default,) {final _that = this;
switch (_that) {
case _HomeState() when $default != null:
return $default(_that.status,_that.error,_that.pendingTotal,_that.overdueTotal,_that.currency,_that.nextReservation,_that.nextReservationArea,_that.unreadNotifications,_that.latestAnnouncement,_that.announcementsUnavailable);case _:
  return null;

}
}

}

/// @nodoc


class _HomeState extends HomeState {
  const _HomeState({this.status = LoadStatus.loading, this.error, this.pendingTotal = 0, this.overdueTotal = 0, this.currency = 'PEN', this.nextReservation, this.nextReservationArea, this.unreadNotifications = 0, this.latestAnnouncement, this.announcementsUnavailable = false}): super._();
  

@override@JsonKey() final  LoadStatus status;
@override final  String? error;
@override@JsonKey() final  double pendingTotal;
@override@JsonKey() final  double overdueTotal;
@override@JsonKey() final  String currency;
@override final  ReservationBlock? nextReservation;
@override final  String? nextReservationArea;
@override@JsonKey() final  int unreadNotifications;
@override final  Announcement? latestAnnouncement;
/// La fake API no tiene comunicados: el bloque se muestra como pendiente.
@override@JsonKey() final  bool announcementsUnavailable;

/// Create a copy of HomeState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HomeStateCopyWith<_HomeState> get copyWith => __$HomeStateCopyWithImpl<_HomeState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _HomeState&&(identical(other.status, status) || other.status == status)&&(identical(other.error, error) || other.error == error)&&(identical(other.pendingTotal, pendingTotal) || other.pendingTotal == pendingTotal)&&(identical(other.overdueTotal, overdueTotal) || other.overdueTotal == overdueTotal)&&(identical(other.currency, currency) || other.currency == currency)&&(identical(other.nextReservation, nextReservation) || other.nextReservation == nextReservation)&&(identical(other.nextReservationArea, nextReservationArea) || other.nextReservationArea == nextReservationArea)&&(identical(other.unreadNotifications, unreadNotifications) || other.unreadNotifications == unreadNotifications)&&(identical(other.latestAnnouncement, latestAnnouncement) || other.latestAnnouncement == latestAnnouncement)&&(identical(other.announcementsUnavailable, announcementsUnavailable) || other.announcementsUnavailable == announcementsUnavailable));
}


@override
int get hashCode => Object.hash(runtimeType,status,error,pendingTotal,overdueTotal,currency,nextReservation,nextReservationArea,unreadNotifications,latestAnnouncement,announcementsUnavailable);

@override
String toString() {
  return 'HomeState(status: $status, error: $error, pendingTotal: $pendingTotal, overdueTotal: $overdueTotal, currency: $currency, nextReservation: $nextReservation, nextReservationArea: $nextReservationArea, unreadNotifications: $unreadNotifications, latestAnnouncement: $latestAnnouncement, announcementsUnavailable: $announcementsUnavailable)';
}


}

/// @nodoc
abstract mixin class _$HomeStateCopyWith<$Res> implements $HomeStateCopyWith<$Res> {
  factory _$HomeStateCopyWith(_HomeState value, $Res Function(_HomeState) _then) = __$HomeStateCopyWithImpl;
@override @useResult
$Res call({
 LoadStatus status, String? error, double pendingTotal, double overdueTotal, String currency, ReservationBlock? nextReservation, String? nextReservationArea, int unreadNotifications, Announcement? latestAnnouncement, bool announcementsUnavailable
});


@override $AnnouncementCopyWith<$Res>? get latestAnnouncement;

}
/// @nodoc
class __$HomeStateCopyWithImpl<$Res>
    implements _$HomeStateCopyWith<$Res> {
  __$HomeStateCopyWithImpl(this._self, this._then);

  final _HomeState _self;
  final $Res Function(_HomeState) _then;

/// Create a copy of HomeState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? error = freezed,Object? pendingTotal = null,Object? overdueTotal = null,Object? currency = null,Object? nextReservation = freezed,Object? nextReservationArea = freezed,Object? unreadNotifications = null,Object? latestAnnouncement = freezed,Object? announcementsUnavailable = null,}) {
  return _then(_HomeState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as LoadStatus,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,pendingTotal: null == pendingTotal ? _self.pendingTotal : pendingTotal // ignore: cast_nullable_to_non_nullable
as double,overdueTotal: null == overdueTotal ? _self.overdueTotal : overdueTotal // ignore: cast_nullable_to_non_nullable
as double,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String,nextReservation: freezed == nextReservation ? _self.nextReservation : nextReservation // ignore: cast_nullable_to_non_nullable
as ReservationBlock?,nextReservationArea: freezed == nextReservationArea ? _self.nextReservationArea : nextReservationArea // ignore: cast_nullable_to_non_nullable
as String?,unreadNotifications: null == unreadNotifications ? _self.unreadNotifications : unreadNotifications // ignore: cast_nullable_to_non_nullable
as int,latestAnnouncement: freezed == latestAnnouncement ? _self.latestAnnouncement : latestAnnouncement // ignore: cast_nullable_to_non_nullable
as Announcement?,announcementsUnavailable: null == announcementsUnavailable ? _self.announcementsUnavailable : announcementsUnavailable // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

/// Create a copy of HomeState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AnnouncementCopyWith<$Res>? get latestAnnouncement {
    if (_self.latestAnnouncement == null) {
    return null;
  }

  return $AnnouncementCopyWith<$Res>(_self.latestAnnouncement!, (value) {
    return _then(_self.copyWith(latestAnnouncement: value));
  });
}
}

// dart format on
