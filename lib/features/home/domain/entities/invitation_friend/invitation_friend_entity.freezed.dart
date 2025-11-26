// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'invitation_friend_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$InvitationFriendEntity {

 String get id; String get email; String get displayName; String? get photoUrl;
/// Create a copy of InvitationFriendEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$InvitationFriendEntityCopyWith<InvitationFriendEntity> get copyWith => _$InvitationFriendEntityCopyWithImpl<InvitationFriendEntity>(this as InvitationFriendEntity, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is InvitationFriendEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.email, email) || other.email == email)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.photoUrl, photoUrl) || other.photoUrl == photoUrl));
}


@override
int get hashCode => Object.hash(runtimeType,id,email,displayName,photoUrl);

@override
String toString() {
  return 'InvitationFriendEntity(id: $id, email: $email, displayName: $displayName, photoUrl: $photoUrl)';
}


}

/// @nodoc
abstract mixin class $InvitationFriendEntityCopyWith<$Res>  {
  factory $InvitationFriendEntityCopyWith(InvitationFriendEntity value, $Res Function(InvitationFriendEntity) _then) = _$InvitationFriendEntityCopyWithImpl;
@useResult
$Res call({
 String id, String email, String displayName, String? photoUrl
});




}
/// @nodoc
class _$InvitationFriendEntityCopyWithImpl<$Res>
    implements $InvitationFriendEntityCopyWith<$Res> {
  _$InvitationFriendEntityCopyWithImpl(this._self, this._then);

  final InvitationFriendEntity _self;
  final $Res Function(InvitationFriendEntity) _then;

/// Create a copy of InvitationFriendEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? email = null,Object? displayName = null,Object? photoUrl = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,photoUrl: freezed == photoUrl ? _self.photoUrl : photoUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [InvitationFriendEntity].
extension InvitationFriendEntityPatterns on InvitationFriendEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _InvitationsEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _InvitationsEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _InvitationsEntity value)  $default,){
final _that = this;
switch (_that) {
case _InvitationsEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _InvitationsEntity value)?  $default,){
final _that = this;
switch (_that) {
case _InvitationsEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String email,  String displayName,  String? photoUrl)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _InvitationsEntity() when $default != null:
return $default(_that.id,_that.email,_that.displayName,_that.photoUrl);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String email,  String displayName,  String? photoUrl)  $default,) {final _that = this;
switch (_that) {
case _InvitationsEntity():
return $default(_that.id,_that.email,_that.displayName,_that.photoUrl);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String email,  String displayName,  String? photoUrl)?  $default,) {final _that = this;
switch (_that) {
case _InvitationsEntity() when $default != null:
return $default(_that.id,_that.email,_that.displayName,_that.photoUrl);case _:
  return null;

}
}

}

/// @nodoc


class _InvitationsEntity implements InvitationFriendEntity {
  const _InvitationsEntity({required this.id, required this.email, required this.displayName, this.photoUrl});
  

@override final  String id;
@override final  String email;
@override final  String displayName;
@override final  String? photoUrl;

/// Create a copy of InvitationFriendEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$InvitationsEntityCopyWith<_InvitationsEntity> get copyWith => __$InvitationsEntityCopyWithImpl<_InvitationsEntity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _InvitationsEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.email, email) || other.email == email)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.photoUrl, photoUrl) || other.photoUrl == photoUrl));
}


@override
int get hashCode => Object.hash(runtimeType,id,email,displayName,photoUrl);

@override
String toString() {
  return 'InvitationFriendEntity(id: $id, email: $email, displayName: $displayName, photoUrl: $photoUrl)';
}


}

/// @nodoc
abstract mixin class _$InvitationsEntityCopyWith<$Res> implements $InvitationFriendEntityCopyWith<$Res> {
  factory _$InvitationsEntityCopyWith(_InvitationsEntity value, $Res Function(_InvitationsEntity) _then) = __$InvitationsEntityCopyWithImpl;
@override @useResult
$Res call({
 String id, String email, String displayName, String? photoUrl
});




}
/// @nodoc
class __$InvitationsEntityCopyWithImpl<$Res>
    implements _$InvitationsEntityCopyWith<$Res> {
  __$InvitationsEntityCopyWithImpl(this._self, this._then);

  final _InvitationsEntity _self;
  final $Res Function(_InvitationsEntity) _then;

/// Create a copy of InvitationFriendEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? email = null,Object? displayName = null,Object? photoUrl = freezed,}) {
  return _then(_InvitationsEntity(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,photoUrl: freezed == photoUrl ? _self.photoUrl : photoUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
