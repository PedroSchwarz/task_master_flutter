// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'invites_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$InvitesState {

 bool get isLoading; List<InviteResponse> get invites; bool get isRefreshing;
/// Create a copy of InvitesState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$InvitesStateCopyWith<InvitesState> get copyWith => _$InvitesStateCopyWithImpl<InvitesState>(this as InvitesState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is InvitesState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&const DeepCollectionEquality().equals(other.invites, invites)&&(identical(other.isRefreshing, isRefreshing) || other.isRefreshing == isRefreshing));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,const DeepCollectionEquality().hash(invites),isRefreshing);

@override
String toString() {
  return 'InvitesState(isLoading: $isLoading, invites: $invites, isRefreshing: $isRefreshing)';
}


}

/// @nodoc
abstract mixin class $InvitesStateCopyWith<$Res>  {
  factory $InvitesStateCopyWith(InvitesState value, $Res Function(InvitesState) _then) = _$InvitesStateCopyWithImpl;
@useResult
$Res call({
 bool isLoading, List<InviteResponse> invites, bool isRefreshing
});




}
/// @nodoc
class _$InvitesStateCopyWithImpl<$Res>
    implements $InvitesStateCopyWith<$Res> {
  _$InvitesStateCopyWithImpl(this._self, this._then);

  final InvitesState _self;
  final $Res Function(InvitesState) _then;

/// Create a copy of InvitesState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isLoading = null,Object? invites = null,Object? isRefreshing = null,}) {
  return _then(_self.copyWith(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,invites: null == invites ? _self.invites : invites // ignore: cast_nullable_to_non_nullable
as List<InviteResponse>,isRefreshing: null == isRefreshing ? _self.isRefreshing : isRefreshing // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [InvitesState].
extension InvitesStatePatterns on InvitesState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _InvitesState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _InvitesState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _InvitesState value)  $default,){
final _that = this;
switch (_that) {
case _InvitesState():
return $default(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _InvitesState value)?  $default,){
final _that = this;
switch (_that) {
case _InvitesState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool isLoading,  List<InviteResponse> invites,  bool isRefreshing)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _InvitesState() when $default != null:
return $default(_that.isLoading,_that.invites,_that.isRefreshing);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool isLoading,  List<InviteResponse> invites,  bool isRefreshing)  $default,) {final _that = this;
switch (_that) {
case _InvitesState():
return $default(_that.isLoading,_that.invites,_that.isRefreshing);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool isLoading,  List<InviteResponse> invites,  bool isRefreshing)?  $default,) {final _that = this;
switch (_that) {
case _InvitesState() when $default != null:
return $default(_that.isLoading,_that.invites,_that.isRefreshing);case _:
  return null;

}
}

}

/// @nodoc


class _InvitesState implements InvitesState {
  const _InvitesState({required this.isLoading, required final  List<InviteResponse> invites, required this.isRefreshing}): _invites = invites;
  

@override final  bool isLoading;
 final  List<InviteResponse> _invites;
@override List<InviteResponse> get invites {
  if (_invites is EqualUnmodifiableListView) return _invites;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_invites);
}

@override final  bool isRefreshing;

/// Create a copy of InvitesState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$InvitesStateCopyWith<_InvitesState> get copyWith => __$InvitesStateCopyWithImpl<_InvitesState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _InvitesState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&const DeepCollectionEquality().equals(other._invites, _invites)&&(identical(other.isRefreshing, isRefreshing) || other.isRefreshing == isRefreshing));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,const DeepCollectionEquality().hash(_invites),isRefreshing);

@override
String toString() {
  return 'InvitesState(isLoading: $isLoading, invites: $invites, isRefreshing: $isRefreshing)';
}


}

/// @nodoc
abstract mixin class _$InvitesStateCopyWith<$Res> implements $InvitesStateCopyWith<$Res> {
  factory _$InvitesStateCopyWith(_InvitesState value, $Res Function(_InvitesState) _then) = __$InvitesStateCopyWithImpl;
@override @useResult
$Res call({
 bool isLoading, List<InviteResponse> invites, bool isRefreshing
});




}
/// @nodoc
class __$InvitesStateCopyWithImpl<$Res>
    implements _$InvitesStateCopyWith<$Res> {
  __$InvitesStateCopyWithImpl(this._self, this._then);

  final _InvitesState _self;
  final $Res Function(_InvitesState) _then;

/// Create a copy of InvitesState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isLoading = null,Object? invites = null,Object? isRefreshing = null,}) {
  return _then(_InvitesState(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,invites: null == invites ? _self._invites : invites // ignore: cast_nullable_to_non_nullable
as List<InviteResponse>,isRefreshing: null == isRefreshing ? _self.isRefreshing : isRefreshing // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
