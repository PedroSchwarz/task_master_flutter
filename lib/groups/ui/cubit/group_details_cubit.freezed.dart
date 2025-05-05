// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'group_details_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$GroupDetailsState {

 bool get isLoading; List<InviteResponse> get invites;
/// Create a copy of GroupDetailsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GroupDetailsStateCopyWith<GroupDetailsState> get copyWith => _$GroupDetailsStateCopyWithImpl<GroupDetailsState>(this as GroupDetailsState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GroupDetailsState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&const DeepCollectionEquality().equals(other.invites, invites));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,const DeepCollectionEquality().hash(invites));

@override
String toString() {
  return 'GroupDetailsState(isLoading: $isLoading, invites: $invites)';
}


}

/// @nodoc
abstract mixin class $GroupDetailsStateCopyWith<$Res>  {
  factory $GroupDetailsStateCopyWith(GroupDetailsState value, $Res Function(GroupDetailsState) _then) = _$GroupDetailsStateCopyWithImpl;
@useResult
$Res call({
 bool isLoading, List<InviteResponse> invites
});




}
/// @nodoc
class _$GroupDetailsStateCopyWithImpl<$Res>
    implements $GroupDetailsStateCopyWith<$Res> {
  _$GroupDetailsStateCopyWithImpl(this._self, this._then);

  final GroupDetailsState _self;
  final $Res Function(GroupDetailsState) _then;

/// Create a copy of GroupDetailsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isLoading = null,Object? invites = null,}) {
  return _then(_self.copyWith(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,invites: null == invites ? _self.invites : invites // ignore: cast_nullable_to_non_nullable
as List<InviteResponse>,
  ));
}

}


/// @nodoc


class _GroupDetailsState implements GroupDetailsState {
  const _GroupDetailsState({required this.isLoading, required final  List<InviteResponse> invites}): _invites = invites;
  

@override final  bool isLoading;
 final  List<InviteResponse> _invites;
@override List<InviteResponse> get invites {
  if (_invites is EqualUnmodifiableListView) return _invites;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_invites);
}


/// Create a copy of GroupDetailsState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GroupDetailsStateCopyWith<_GroupDetailsState> get copyWith => __$GroupDetailsStateCopyWithImpl<_GroupDetailsState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GroupDetailsState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&const DeepCollectionEquality().equals(other._invites, _invites));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,const DeepCollectionEquality().hash(_invites));

@override
String toString() {
  return 'GroupDetailsState(isLoading: $isLoading, invites: $invites)';
}


}

/// @nodoc
abstract mixin class _$GroupDetailsStateCopyWith<$Res> implements $GroupDetailsStateCopyWith<$Res> {
  factory _$GroupDetailsStateCopyWith(_GroupDetailsState value, $Res Function(_GroupDetailsState) _then) = __$GroupDetailsStateCopyWithImpl;
@override @useResult
$Res call({
 bool isLoading, List<InviteResponse> invites
});




}
/// @nodoc
class __$GroupDetailsStateCopyWithImpl<$Res>
    implements _$GroupDetailsStateCopyWith<$Res> {
  __$GroupDetailsStateCopyWithImpl(this._self, this._then);

  final _GroupDetailsState _self;
  final $Res Function(_GroupDetailsState) _then;

/// Create a copy of GroupDetailsState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isLoading = null,Object? invites = null,}) {
  return _then(_GroupDetailsState(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,invites: null == invites ? _self._invites : invites // ignore: cast_nullable_to_non_nullable
as List<InviteResponse>,
  ));
}


}

// dart format on
