// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'announcements_screen.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AnnouncementsState {

 LoadStatus get status; String? get error; List<Announcement> get items; Set<int> get readIds;/// El servicio no existe aún en la fake API (404).
 bool get unavailable;
/// Create a copy of AnnouncementsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AnnouncementsStateCopyWith<AnnouncementsState> get copyWith => _$AnnouncementsStateCopyWithImpl<AnnouncementsState>(this as AnnouncementsState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AnnouncementsState&&(identical(other.status, status) || other.status == status)&&(identical(other.error, error) || other.error == error)&&const DeepCollectionEquality().equals(other.items, items)&&const DeepCollectionEquality().equals(other.readIds, readIds)&&(identical(other.unavailable, unavailable) || other.unavailable == unavailable));
}


@override
int get hashCode => Object.hash(runtimeType,status,error,const DeepCollectionEquality().hash(items),const DeepCollectionEquality().hash(readIds),unavailable);

@override
String toString() {
  return 'AnnouncementsState(status: $status, error: $error, items: $items, readIds: $readIds, unavailable: $unavailable)';
}


}

/// @nodoc
abstract mixin class $AnnouncementsStateCopyWith<$Res>  {
  factory $AnnouncementsStateCopyWith(AnnouncementsState value, $Res Function(AnnouncementsState) _then) = _$AnnouncementsStateCopyWithImpl;
@useResult
$Res call({
 LoadStatus status, String? error, List<Announcement> items, Set<int> readIds, bool unavailable
});




}
/// @nodoc
class _$AnnouncementsStateCopyWithImpl<$Res>
    implements $AnnouncementsStateCopyWith<$Res> {
  _$AnnouncementsStateCopyWithImpl(this._self, this._then);

  final AnnouncementsState _self;
  final $Res Function(AnnouncementsState) _then;

/// Create a copy of AnnouncementsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? error = freezed,Object? items = null,Object? readIds = null,Object? unavailable = null,}) {
  return _then(_self.copyWith(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as LoadStatus,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<Announcement>,readIds: null == readIds ? _self.readIds : readIds // ignore: cast_nullable_to_non_nullable
as Set<int>,unavailable: null == unavailable ? _self.unavailable : unavailable // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [AnnouncementsState].
extension AnnouncementsStatePatterns on AnnouncementsState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AnnouncementsState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AnnouncementsState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AnnouncementsState value)  $default,){
final _that = this;
switch (_that) {
case _AnnouncementsState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AnnouncementsState value)?  $default,){
final _that = this;
switch (_that) {
case _AnnouncementsState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( LoadStatus status,  String? error,  List<Announcement> items,  Set<int> readIds,  bool unavailable)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AnnouncementsState() when $default != null:
return $default(_that.status,_that.error,_that.items,_that.readIds,_that.unavailable);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( LoadStatus status,  String? error,  List<Announcement> items,  Set<int> readIds,  bool unavailable)  $default,) {final _that = this;
switch (_that) {
case _AnnouncementsState():
return $default(_that.status,_that.error,_that.items,_that.readIds,_that.unavailable);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( LoadStatus status,  String? error,  List<Announcement> items,  Set<int> readIds,  bool unavailable)?  $default,) {final _that = this;
switch (_that) {
case _AnnouncementsState() when $default != null:
return $default(_that.status,_that.error,_that.items,_that.readIds,_that.unavailable);case _:
  return null;

}
}

}

/// @nodoc


class _AnnouncementsState implements AnnouncementsState {
  const _AnnouncementsState({this.status = LoadStatus.loading, this.error, final  List<Announcement> items = const <Announcement>[], final  Set<int> readIds = const <int>{}, this.unavailable = false}): _items = items,_readIds = readIds;
  

@override@JsonKey() final  LoadStatus status;
@override final  String? error;
 final  List<Announcement> _items;
@override@JsonKey() List<Announcement> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}

 final  Set<int> _readIds;
@override@JsonKey() Set<int> get readIds {
  if (_readIds is EqualUnmodifiableSetView) return _readIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableSetView(_readIds);
}

/// El servicio no existe aún en la fake API (404).
@override@JsonKey() final  bool unavailable;

/// Create a copy of AnnouncementsState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AnnouncementsStateCopyWith<_AnnouncementsState> get copyWith => __$AnnouncementsStateCopyWithImpl<_AnnouncementsState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AnnouncementsState&&(identical(other.status, status) || other.status == status)&&(identical(other.error, error) || other.error == error)&&const DeepCollectionEquality().equals(other._items, _items)&&const DeepCollectionEquality().equals(other._readIds, _readIds)&&(identical(other.unavailable, unavailable) || other.unavailable == unavailable));
}


@override
int get hashCode => Object.hash(runtimeType,status,error,const DeepCollectionEquality().hash(_items),const DeepCollectionEquality().hash(_readIds),unavailable);

@override
String toString() {
  return 'AnnouncementsState(status: $status, error: $error, items: $items, readIds: $readIds, unavailable: $unavailable)';
}


}

/// @nodoc
abstract mixin class _$AnnouncementsStateCopyWith<$Res> implements $AnnouncementsStateCopyWith<$Res> {
  factory _$AnnouncementsStateCopyWith(_AnnouncementsState value, $Res Function(_AnnouncementsState) _then) = __$AnnouncementsStateCopyWithImpl;
@override @useResult
$Res call({
 LoadStatus status, String? error, List<Announcement> items, Set<int> readIds, bool unavailable
});




}
/// @nodoc
class __$AnnouncementsStateCopyWithImpl<$Res>
    implements _$AnnouncementsStateCopyWith<$Res> {
  __$AnnouncementsStateCopyWithImpl(this._self, this._then);

  final _AnnouncementsState _self;
  final $Res Function(_AnnouncementsState) _then;

/// Create a copy of AnnouncementsState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? error = freezed,Object? items = null,Object? readIds = null,Object? unavailable = null,}) {
  return _then(_AnnouncementsState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as LoadStatus,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<Announcement>,readIds: null == readIds ? _self._readIds : readIds // ignore: cast_nullable_to_non_nullable
as Set<int>,unavailable: null == unavailable ? _self.unavailable : unavailable // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
