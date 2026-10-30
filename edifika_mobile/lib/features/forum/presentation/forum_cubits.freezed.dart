// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'forum_cubits.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ForumState {

 LoadStatus get status; String? get error; List<Post> get posts; Map<int, String> get authorNames; String get query;
/// Create a copy of ForumState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ForumStateCopyWith<ForumState> get copyWith => _$ForumStateCopyWithImpl<ForumState>(this as ForumState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ForumState&&(identical(other.status, status) || other.status == status)&&(identical(other.error, error) || other.error == error)&&const DeepCollectionEquality().equals(other.posts, posts)&&const DeepCollectionEquality().equals(other.authorNames, authorNames)&&(identical(other.query, query) || other.query == query));
}


@override
int get hashCode => Object.hash(runtimeType,status,error,const DeepCollectionEquality().hash(posts),const DeepCollectionEquality().hash(authorNames),query);

@override
String toString() {
  return 'ForumState(status: $status, error: $error, posts: $posts, authorNames: $authorNames, query: $query)';
}


}

/// @nodoc
abstract mixin class $ForumStateCopyWith<$Res>  {
  factory $ForumStateCopyWith(ForumState value, $Res Function(ForumState) _then) = _$ForumStateCopyWithImpl;
@useResult
$Res call({
 LoadStatus status, String? error, List<Post> posts, Map<int, String> authorNames, String query
});




}
/// @nodoc
class _$ForumStateCopyWithImpl<$Res>
    implements $ForumStateCopyWith<$Res> {
  _$ForumStateCopyWithImpl(this._self, this._then);

  final ForumState _self;
  final $Res Function(ForumState) _then;

/// Create a copy of ForumState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? error = freezed,Object? posts = null,Object? authorNames = null,Object? query = null,}) {
  return _then(_self.copyWith(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as LoadStatus,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,posts: null == posts ? _self.posts : posts // ignore: cast_nullable_to_non_nullable
as List<Post>,authorNames: null == authorNames ? _self.authorNames : authorNames // ignore: cast_nullable_to_non_nullable
as Map<int, String>,query: null == query ? _self.query : query // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [ForumState].
extension ForumStatePatterns on ForumState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ForumState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ForumState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ForumState value)  $default,){
final _that = this;
switch (_that) {
case _ForumState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ForumState value)?  $default,){
final _that = this;
switch (_that) {
case _ForumState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( LoadStatus status,  String? error,  List<Post> posts,  Map<int, String> authorNames,  String query)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ForumState() when $default != null:
return $default(_that.status,_that.error,_that.posts,_that.authorNames,_that.query);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( LoadStatus status,  String? error,  List<Post> posts,  Map<int, String> authorNames,  String query)  $default,) {final _that = this;
switch (_that) {
case _ForumState():
return $default(_that.status,_that.error,_that.posts,_that.authorNames,_that.query);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( LoadStatus status,  String? error,  List<Post> posts,  Map<int, String> authorNames,  String query)?  $default,) {final _that = this;
switch (_that) {
case _ForumState() when $default != null:
return $default(_that.status,_that.error,_that.posts,_that.authorNames,_that.query);case _:
  return null;

}
}

}

/// @nodoc


class _ForumState extends ForumState {
  const _ForumState({this.status = LoadStatus.loading, this.error, final  List<Post> posts = const <Post>[], final  Map<int, String> authorNames = const <int, String>{}, this.query = ''}): _posts = posts,_authorNames = authorNames,super._();
  

@override@JsonKey() final  LoadStatus status;
@override final  String? error;
 final  List<Post> _posts;
@override@JsonKey() List<Post> get posts {
  if (_posts is EqualUnmodifiableListView) return _posts;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_posts);
}

 final  Map<int, String> _authorNames;
@override@JsonKey() Map<int, String> get authorNames {
  if (_authorNames is EqualUnmodifiableMapView) return _authorNames;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_authorNames);
}

@override@JsonKey() final  String query;

/// Create a copy of ForumState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ForumStateCopyWith<_ForumState> get copyWith => __$ForumStateCopyWithImpl<_ForumState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ForumState&&(identical(other.status, status) || other.status == status)&&(identical(other.error, error) || other.error == error)&&const DeepCollectionEquality().equals(other._posts, _posts)&&const DeepCollectionEquality().equals(other._authorNames, _authorNames)&&(identical(other.query, query) || other.query == query));
}


@override
int get hashCode => Object.hash(runtimeType,status,error,const DeepCollectionEquality().hash(_posts),const DeepCollectionEquality().hash(_authorNames),query);

@override
String toString() {
  return 'ForumState(status: $status, error: $error, posts: $posts, authorNames: $authorNames, query: $query)';
}


}

/// @nodoc
abstract mixin class _$ForumStateCopyWith<$Res> implements $ForumStateCopyWith<$Res> {
  factory _$ForumStateCopyWith(_ForumState value, $Res Function(_ForumState) _then) = __$ForumStateCopyWithImpl;
@override @useResult
$Res call({
 LoadStatus status, String? error, List<Post> posts, Map<int, String> authorNames, String query
});




}
/// @nodoc
class __$ForumStateCopyWithImpl<$Res>
    implements _$ForumStateCopyWith<$Res> {
  __$ForumStateCopyWithImpl(this._self, this._then);

  final _ForumState _self;
  final $Res Function(_ForumState) _then;

/// Create a copy of ForumState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? error = freezed,Object? posts = null,Object? authorNames = null,Object? query = null,}) {
  return _then(_ForumState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as LoadStatus,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,posts: null == posts ? _self._posts : posts // ignore: cast_nullable_to_non_nullable
as List<Post>,authorNames: null == authorNames ? _self._authorNames : authorNames // ignore: cast_nullable_to_non_nullable
as Map<int, String>,query: null == query ? _self.query : query // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
mixin _$NewPostState {

 bool get submitting; String? get error; Post? get created;
/// Create a copy of NewPostState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NewPostStateCopyWith<NewPostState> get copyWith => _$NewPostStateCopyWithImpl<NewPostState>(this as NewPostState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NewPostState&&(identical(other.submitting, submitting) || other.submitting == submitting)&&(identical(other.error, error) || other.error == error)&&(identical(other.created, created) || other.created == created));
}


@override
int get hashCode => Object.hash(runtimeType,submitting,error,created);

@override
String toString() {
  return 'NewPostState(submitting: $submitting, error: $error, created: $created)';
}


}

/// @nodoc
abstract mixin class $NewPostStateCopyWith<$Res>  {
  factory $NewPostStateCopyWith(NewPostState value, $Res Function(NewPostState) _then) = _$NewPostStateCopyWithImpl;
@useResult
$Res call({
 bool submitting, String? error, Post? created
});


$PostCopyWith<$Res>? get created;

}
/// @nodoc
class _$NewPostStateCopyWithImpl<$Res>
    implements $NewPostStateCopyWith<$Res> {
  _$NewPostStateCopyWithImpl(this._self, this._then);

  final NewPostState _self;
  final $Res Function(NewPostState) _then;

/// Create a copy of NewPostState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? submitting = null,Object? error = freezed,Object? created = freezed,}) {
  return _then(_self.copyWith(
submitting: null == submitting ? _self.submitting : submitting // ignore: cast_nullable_to_non_nullable
as bool,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,created: freezed == created ? _self.created : created // ignore: cast_nullable_to_non_nullable
as Post?,
  ));
}
/// Create a copy of NewPostState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PostCopyWith<$Res>? get created {
    if (_self.created == null) {
    return null;
  }

  return $PostCopyWith<$Res>(_self.created!, (value) {
    return _then(_self.copyWith(created: value));
  });
}
}


/// Adds pattern-matching-related methods to [NewPostState].
extension NewPostStatePatterns on NewPostState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _NewPostState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NewPostState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _NewPostState value)  $default,){
final _that = this;
switch (_that) {
case _NewPostState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _NewPostState value)?  $default,){
final _that = this;
switch (_that) {
case _NewPostState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool submitting,  String? error,  Post? created)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _NewPostState() when $default != null:
return $default(_that.submitting,_that.error,_that.created);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool submitting,  String? error,  Post? created)  $default,) {final _that = this;
switch (_that) {
case _NewPostState():
return $default(_that.submitting,_that.error,_that.created);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool submitting,  String? error,  Post? created)?  $default,) {final _that = this;
switch (_that) {
case _NewPostState() when $default != null:
return $default(_that.submitting,_that.error,_that.created);case _:
  return null;

}
}

}

/// @nodoc


class _NewPostState implements NewPostState {
  const _NewPostState({this.submitting = false, this.error, this.created});
  

@override@JsonKey() final  bool submitting;
@override final  String? error;
@override final  Post? created;

/// Create a copy of NewPostState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NewPostStateCopyWith<_NewPostState> get copyWith => __$NewPostStateCopyWithImpl<_NewPostState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NewPostState&&(identical(other.submitting, submitting) || other.submitting == submitting)&&(identical(other.error, error) || other.error == error)&&(identical(other.created, created) || other.created == created));
}


@override
int get hashCode => Object.hash(runtimeType,submitting,error,created);

@override
String toString() {
  return 'NewPostState(submitting: $submitting, error: $error, created: $created)';
}


}

/// @nodoc
abstract mixin class _$NewPostStateCopyWith<$Res> implements $NewPostStateCopyWith<$Res> {
  factory _$NewPostStateCopyWith(_NewPostState value, $Res Function(_NewPostState) _then) = __$NewPostStateCopyWithImpl;
@override @useResult
$Res call({
 bool submitting, String? error, Post? created
});


@override $PostCopyWith<$Res>? get created;

}
/// @nodoc
class __$NewPostStateCopyWithImpl<$Res>
    implements _$NewPostStateCopyWith<$Res> {
  __$NewPostStateCopyWithImpl(this._self, this._then);

  final _NewPostState _self;
  final $Res Function(_NewPostState) _then;

/// Create a copy of NewPostState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? submitting = null,Object? error = freezed,Object? created = freezed,}) {
  return _then(_NewPostState(
submitting: null == submitting ? _self.submitting : submitting // ignore: cast_nullable_to_non_nullable
as bool,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,created: freezed == created ? _self.created : created // ignore: cast_nullable_to_non_nullable
as Post?,
  ));
}

/// Create a copy of NewPostState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PostCopyWith<$Res>? get created {
    if (_self.created == null) {
    return null;
  }

  return $PostCopyWith<$Res>(_self.created!, (value) {
    return _then(_self.copyWith(created: value));
  });
}
}

// dart format on
