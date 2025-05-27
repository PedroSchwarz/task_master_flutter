// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'dashboard_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$DashboardState {

 bool get isLoading; GroupsListType get groupsListType; List<GroupResponse> get groups; List<InviteResponse> get invites; List<WeeklyTaskProgression?> get progression; TaskProgressionSelection get selection; bool get isRefreshing;
/// Create a copy of DashboardState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DashboardStateCopyWith<DashboardState> get copyWith => _$DashboardStateCopyWithImpl<DashboardState>(this as DashboardState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DashboardState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.groupsListType, groupsListType) || other.groupsListType == groupsListType)&&const DeepCollectionEquality().equals(other.groups, groups)&&const DeepCollectionEquality().equals(other.invites, invites)&&const DeepCollectionEquality().equals(other.progression, progression)&&(identical(other.selection, selection) || other.selection == selection)&&(identical(other.isRefreshing, isRefreshing) || other.isRefreshing == isRefreshing));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,groupsListType,const DeepCollectionEquality().hash(groups),const DeepCollectionEquality().hash(invites),const DeepCollectionEquality().hash(progression),selection,isRefreshing);

@override
String toString() {
  return 'DashboardState(isLoading: $isLoading, groupsListType: $groupsListType, groups: $groups, invites: $invites, progression: $progression, selection: $selection, isRefreshing: $isRefreshing)';
}


}

/// @nodoc
abstract mixin class $DashboardStateCopyWith<$Res>  {
  factory $DashboardStateCopyWith(DashboardState value, $Res Function(DashboardState) _then) = _$DashboardStateCopyWithImpl;
@useResult
$Res call({
 bool isLoading, GroupsListType groupsListType, List<GroupResponse> groups, List<InviteResponse> invites, List<WeeklyTaskProgression?> progression, TaskProgressionSelection selection, bool isRefreshing
});




}
/// @nodoc
class _$DashboardStateCopyWithImpl<$Res>
    implements $DashboardStateCopyWith<$Res> {
  _$DashboardStateCopyWithImpl(this._self, this._then);

  final DashboardState _self;
  final $Res Function(DashboardState) _then;

/// Create a copy of DashboardState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isLoading = null,Object? groupsListType = null,Object? groups = null,Object? invites = null,Object? progression = null,Object? selection = null,Object? isRefreshing = null,}) {
  return _then(_self.copyWith(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,groupsListType: null == groupsListType ? _self.groupsListType : groupsListType // ignore: cast_nullable_to_non_nullable
as GroupsListType,groups: null == groups ? _self.groups : groups // ignore: cast_nullable_to_non_nullable
as List<GroupResponse>,invites: null == invites ? _self.invites : invites // ignore: cast_nullable_to_non_nullable
as List<InviteResponse>,progression: null == progression ? _self.progression : progression // ignore: cast_nullable_to_non_nullable
as List<WeeklyTaskProgression?>,selection: null == selection ? _self.selection : selection // ignore: cast_nullable_to_non_nullable
as TaskProgressionSelection,isRefreshing: null == isRefreshing ? _self.isRefreshing : isRefreshing // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// @nodoc


class _DashboardState implements DashboardState {
  const _DashboardState({required this.isLoading, required this.groupsListType, required final  List<GroupResponse> groups, required final  List<InviteResponse> invites, required final  List<WeeklyTaskProgression?> progression, required this.selection, required this.isRefreshing}): _groups = groups,_invites = invites,_progression = progression;
  

@override final  bool isLoading;
@override final  GroupsListType groupsListType;
 final  List<GroupResponse> _groups;
@override List<GroupResponse> get groups {
  if (_groups is EqualUnmodifiableListView) return _groups;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_groups);
}

 final  List<InviteResponse> _invites;
@override List<InviteResponse> get invites {
  if (_invites is EqualUnmodifiableListView) return _invites;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_invites);
}

 final  List<WeeklyTaskProgression?> _progression;
@override List<WeeklyTaskProgression?> get progression {
  if (_progression is EqualUnmodifiableListView) return _progression;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_progression);
}

@override final  TaskProgressionSelection selection;
@override final  bool isRefreshing;

/// Create a copy of DashboardState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DashboardStateCopyWith<_DashboardState> get copyWith => __$DashboardStateCopyWithImpl<_DashboardState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DashboardState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.groupsListType, groupsListType) || other.groupsListType == groupsListType)&&const DeepCollectionEquality().equals(other._groups, _groups)&&const DeepCollectionEquality().equals(other._invites, _invites)&&const DeepCollectionEquality().equals(other._progression, _progression)&&(identical(other.selection, selection) || other.selection == selection)&&(identical(other.isRefreshing, isRefreshing) || other.isRefreshing == isRefreshing));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,groupsListType,const DeepCollectionEquality().hash(_groups),const DeepCollectionEquality().hash(_invites),const DeepCollectionEquality().hash(_progression),selection,isRefreshing);

@override
String toString() {
  return 'DashboardState(isLoading: $isLoading, groupsListType: $groupsListType, groups: $groups, invites: $invites, progression: $progression, selection: $selection, isRefreshing: $isRefreshing)';
}


}

/// @nodoc
abstract mixin class _$DashboardStateCopyWith<$Res> implements $DashboardStateCopyWith<$Res> {
  factory _$DashboardStateCopyWith(_DashboardState value, $Res Function(_DashboardState) _then) = __$DashboardStateCopyWithImpl;
@override @useResult
$Res call({
 bool isLoading, GroupsListType groupsListType, List<GroupResponse> groups, List<InviteResponse> invites, List<WeeklyTaskProgression?> progression, TaskProgressionSelection selection, bool isRefreshing
});




}
/// @nodoc
class __$DashboardStateCopyWithImpl<$Res>
    implements _$DashboardStateCopyWith<$Res> {
  __$DashboardStateCopyWithImpl(this._self, this._then);

  final _DashboardState _self;
  final $Res Function(_DashboardState) _then;

/// Create a copy of DashboardState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isLoading = null,Object? groupsListType = null,Object? groups = null,Object? invites = null,Object? progression = null,Object? selection = null,Object? isRefreshing = null,}) {
  return _then(_DashboardState(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,groupsListType: null == groupsListType ? _self.groupsListType : groupsListType // ignore: cast_nullable_to_non_nullable
as GroupsListType,groups: null == groups ? _self._groups : groups // ignore: cast_nullable_to_non_nullable
as List<GroupResponse>,invites: null == invites ? _self._invites : invites // ignore: cast_nullable_to_non_nullable
as List<InviteResponse>,progression: null == progression ? _self._progression : progression // ignore: cast_nullable_to_non_nullable
as List<WeeklyTaskProgression?>,selection: null == selection ? _self.selection : selection // ignore: cast_nullable_to_non_nullable
as TaskProgressionSelection,isRefreshing: null == isRefreshing ? _self.isRefreshing : isRefreshing // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
