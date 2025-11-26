// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'invitations_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$InvitationsState {

 List<InvitationFriendEntity> get pendingRequests;
/// Create a copy of InvitationsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$InvitationsStateCopyWith<InvitationsState> get copyWith => _$InvitationsStateCopyWithImpl<InvitationsState>(this as InvitationsState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is InvitationsState&&const DeepCollectionEquality().equals(other.pendingRequests, pendingRequests));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(pendingRequests));

@override
String toString() {
  return 'InvitationsState(pendingRequests: $pendingRequests)';
}


}

/// @nodoc
abstract mixin class $InvitationsStateCopyWith<$Res>  {
  factory $InvitationsStateCopyWith(InvitationsState value, $Res Function(InvitationsState) _then) = _$InvitationsStateCopyWithImpl;
@useResult
$Res call({
 List<InvitationFriendEntity> pendingRequests
});




}
/// @nodoc
class _$InvitationsStateCopyWithImpl<$Res>
    implements $InvitationsStateCopyWith<$Res> {
  _$InvitationsStateCopyWithImpl(this._self, this._then);

  final InvitationsState _self;
  final $Res Function(InvitationsState) _then;

/// Create a copy of InvitationsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? pendingRequests = null,}) {
  return _then(_self.copyWith(
pendingRequests: null == pendingRequests ? _self.pendingRequests : pendingRequests // ignore: cast_nullable_to_non_nullable
as List<InvitationFriendEntity>,
  ));
}

}


/// Adds pattern-matching-related methods to [InvitationsState].
extension InvitationsStatePatterns on InvitationsState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _InvitationsState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _InvitationsState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _InvitationsState value)  $default,){
final _that = this;
switch (_that) {
case _InvitationsState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _InvitationsState value)?  $default,){
final _that = this;
switch (_that) {
case _InvitationsState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<InvitationFriendEntity> pendingRequests)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _InvitationsState() when $default != null:
return $default(_that.pendingRequests);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<InvitationFriendEntity> pendingRequests)  $default,) {final _that = this;
switch (_that) {
case _InvitationsState():
return $default(_that.pendingRequests);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<InvitationFriendEntity> pendingRequests)?  $default,) {final _that = this;
switch (_that) {
case _InvitationsState() when $default != null:
return $default(_that.pendingRequests);case _:
  return null;

}
}

}

/// @nodoc


class _InvitationsState implements InvitationsState {
  const _InvitationsState({final  List<InvitationFriendEntity> pendingRequests = const []}): _pendingRequests = pendingRequests;
  

 final  List<InvitationFriendEntity> _pendingRequests;
@override@JsonKey() List<InvitationFriendEntity> get pendingRequests {
  if (_pendingRequests is EqualUnmodifiableListView) return _pendingRequests;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_pendingRequests);
}


/// Create a copy of InvitationsState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$InvitationsStateCopyWith<_InvitationsState> get copyWith => __$InvitationsStateCopyWithImpl<_InvitationsState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _InvitationsState&&const DeepCollectionEquality().equals(other._pendingRequests, _pendingRequests));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_pendingRequests));

@override
String toString() {
  return 'InvitationsState(pendingRequests: $pendingRequests)';
}


}

/// @nodoc
abstract mixin class _$InvitationsStateCopyWith<$Res> implements $InvitationsStateCopyWith<$Res> {
  factory _$InvitationsStateCopyWith(_InvitationsState value, $Res Function(_InvitationsState) _then) = __$InvitationsStateCopyWithImpl;
@override @useResult
$Res call({
 List<InvitationFriendEntity> pendingRequests
});




}
/// @nodoc
class __$InvitationsStateCopyWithImpl<$Res>
    implements _$InvitationsStateCopyWith<$Res> {
  __$InvitationsStateCopyWithImpl(this._self, this._then);

  final _InvitationsState _self;
  final $Res Function(_InvitationsState) _then;

/// Create a copy of InvitationsState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? pendingRequests = null,}) {
  return _then(_InvitationsState(
pendingRequests: null == pendingRequests ? _self._pendingRequests : pendingRequests // ignore: cast_nullable_to_non_nullable
as List<InvitationFriendEntity>,
  ));
}


}

// dart format on
