// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
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

 bool get isLoading; bool get showingProgression; bool get showingHighlights; GroupsListType get groupsListType; List<GroupResponse> get groups; List<TaskResponse> get upcomingTasks; List<TaskResponse> get overdueTasks; List<InviteResponse> get invites; List<WeeklyTaskProgression?> get progression; TaskProgressionSelection get selection; bool get showGroupSearch; String get groupSearchQuery; bool get isRefreshing;
/// Create a copy of DashboardState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DashboardStateCopyWith<DashboardState> get copyWith => _$DashboardStateCopyWithImpl<DashboardState>(this as DashboardState, _$identity);

  /// Serializes this DashboardState to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DashboardState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.showingProgression, showingProgression) || other.showingProgression == showingProgression)&&(identical(other.showingHighlights, showingHighlights) || other.showingHighlights == showingHighlights)&&(identical(other.groupsListType, groupsListType) || other.groupsListType == groupsListType)&&const DeepCollectionEquality().equals(other.groups, groups)&&const DeepCollectionEquality().equals(other.upcomingTasks, upcomingTasks)&&const DeepCollectionEquality().equals(other.overdueTasks, overdueTasks)&&const DeepCollectionEquality().equals(other.invites, invites)&&const DeepCollectionEquality().equals(other.progression, progression)&&(identical(other.selection, selection) || other.selection == selection)&&(identical(other.showGroupSearch, showGroupSearch) || other.showGroupSearch == showGroupSearch)&&(identical(other.groupSearchQuery, groupSearchQuery) || other.groupSearchQuery == groupSearchQuery)&&(identical(other.isRefreshing, isRefreshing) || other.isRefreshing == isRefreshing));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,isLoading,showingProgression,showingHighlights,groupsListType,const DeepCollectionEquality().hash(groups),const DeepCollectionEquality().hash(upcomingTasks),const DeepCollectionEquality().hash(overdueTasks),const DeepCollectionEquality().hash(invites),const DeepCollectionEquality().hash(progression),selection,showGroupSearch,groupSearchQuery,isRefreshing);

@override
String toString() {
  return 'DashboardState(isLoading: $isLoading, showingProgression: $showingProgression, showingHighlights: $showingHighlights, groupsListType: $groupsListType, groups: $groups, upcomingTasks: $upcomingTasks, overdueTasks: $overdueTasks, invites: $invites, progression: $progression, selection: $selection, showGroupSearch: $showGroupSearch, groupSearchQuery: $groupSearchQuery, isRefreshing: $isRefreshing)';
}


}

/// @nodoc
abstract mixin class $DashboardStateCopyWith<$Res>  {
  factory $DashboardStateCopyWith(DashboardState value, $Res Function(DashboardState) _then) = _$DashboardStateCopyWithImpl;
@useResult
$Res call({
 bool isLoading, bool showingProgression, bool showingHighlights, GroupsListType groupsListType, List<GroupResponse> groups, List<TaskResponse> upcomingTasks, List<TaskResponse> overdueTasks, List<InviteResponse> invites, List<WeeklyTaskProgression?> progression, TaskProgressionSelection selection, bool showGroupSearch, String groupSearchQuery, bool isRefreshing
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
@pragma('vm:prefer-inline') @override $Res call({Object? isLoading = null,Object? showingProgression = null,Object? showingHighlights = null,Object? groupsListType = null,Object? groups = null,Object? upcomingTasks = null,Object? overdueTasks = null,Object? invites = null,Object? progression = null,Object? selection = null,Object? showGroupSearch = null,Object? groupSearchQuery = null,Object? isRefreshing = null,}) {
  return _then(_self.copyWith(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,showingProgression: null == showingProgression ? _self.showingProgression : showingProgression // ignore: cast_nullable_to_non_nullable
as bool,showingHighlights: null == showingHighlights ? _self.showingHighlights : showingHighlights // ignore: cast_nullable_to_non_nullable
as bool,groupsListType: null == groupsListType ? _self.groupsListType : groupsListType // ignore: cast_nullable_to_non_nullable
as GroupsListType,groups: null == groups ? _self.groups : groups // ignore: cast_nullable_to_non_nullable
as List<GroupResponse>,upcomingTasks: null == upcomingTasks ? _self.upcomingTasks : upcomingTasks // ignore: cast_nullable_to_non_nullable
as List<TaskResponse>,overdueTasks: null == overdueTasks ? _self.overdueTasks : overdueTasks // ignore: cast_nullable_to_non_nullable
as List<TaskResponse>,invites: null == invites ? _self.invites : invites // ignore: cast_nullable_to_non_nullable
as List<InviteResponse>,progression: null == progression ? _self.progression : progression // ignore: cast_nullable_to_non_nullable
as List<WeeklyTaskProgression?>,selection: null == selection ? _self.selection : selection // ignore: cast_nullable_to_non_nullable
as TaskProgressionSelection,showGroupSearch: null == showGroupSearch ? _self.showGroupSearch : showGroupSearch // ignore: cast_nullable_to_non_nullable
as bool,groupSearchQuery: null == groupSearchQuery ? _self.groupSearchQuery : groupSearchQuery // ignore: cast_nullable_to_non_nullable
as String,isRefreshing: null == isRefreshing ? _self.isRefreshing : isRefreshing // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [DashboardState].
extension DashboardStatePatterns on DashboardState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DashboardState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DashboardState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DashboardState value)  $default,){
final _that = this;
switch (_that) {
case _DashboardState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DashboardState value)?  $default,){
final _that = this;
switch (_that) {
case _DashboardState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool isLoading,  bool showingProgression,  bool showingHighlights,  GroupsListType groupsListType,  List<GroupResponse> groups,  List<TaskResponse> upcomingTasks,  List<TaskResponse> overdueTasks,  List<InviteResponse> invites,  List<WeeklyTaskProgression?> progression,  TaskProgressionSelection selection,  bool showGroupSearch,  String groupSearchQuery,  bool isRefreshing)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DashboardState() when $default != null:
return $default(_that.isLoading,_that.showingProgression,_that.showingHighlights,_that.groupsListType,_that.groups,_that.upcomingTasks,_that.overdueTasks,_that.invites,_that.progression,_that.selection,_that.showGroupSearch,_that.groupSearchQuery,_that.isRefreshing);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool isLoading,  bool showingProgression,  bool showingHighlights,  GroupsListType groupsListType,  List<GroupResponse> groups,  List<TaskResponse> upcomingTasks,  List<TaskResponse> overdueTasks,  List<InviteResponse> invites,  List<WeeklyTaskProgression?> progression,  TaskProgressionSelection selection,  bool showGroupSearch,  String groupSearchQuery,  bool isRefreshing)  $default,) {final _that = this;
switch (_that) {
case _DashboardState():
return $default(_that.isLoading,_that.showingProgression,_that.showingHighlights,_that.groupsListType,_that.groups,_that.upcomingTasks,_that.overdueTasks,_that.invites,_that.progression,_that.selection,_that.showGroupSearch,_that.groupSearchQuery,_that.isRefreshing);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool isLoading,  bool showingProgression,  bool showingHighlights,  GroupsListType groupsListType,  List<GroupResponse> groups,  List<TaskResponse> upcomingTasks,  List<TaskResponse> overdueTasks,  List<InviteResponse> invites,  List<WeeklyTaskProgression?> progression,  TaskProgressionSelection selection,  bool showGroupSearch,  String groupSearchQuery,  bool isRefreshing)?  $default,) {final _that = this;
switch (_that) {
case _DashboardState() when $default != null:
return $default(_that.isLoading,_that.showingProgression,_that.showingHighlights,_that.groupsListType,_that.groups,_that.upcomingTasks,_that.overdueTasks,_that.invites,_that.progression,_that.selection,_that.showGroupSearch,_that.groupSearchQuery,_that.isRefreshing);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DashboardState extends DashboardState {
  const _DashboardState({required this.isLoading, required this.showingProgression, required this.showingHighlights, required this.groupsListType, required final  List<GroupResponse> groups, required final  List<TaskResponse> upcomingTasks, required final  List<TaskResponse> overdueTasks, required final  List<InviteResponse> invites, required final  List<WeeklyTaskProgression?> progression, required this.selection, required this.showGroupSearch, required this.groupSearchQuery, required this.isRefreshing}): _groups = groups,_upcomingTasks = upcomingTasks,_overdueTasks = overdueTasks,_invites = invites,_progression = progression,super._();
  factory _DashboardState.fromJson(Map<String, dynamic> json) => _$DashboardStateFromJson(json);

@override final  bool isLoading;
@override final  bool showingProgression;
@override final  bool showingHighlights;
@override final  GroupsListType groupsListType;
 final  List<GroupResponse> _groups;
@override List<GroupResponse> get groups {
  if (_groups is EqualUnmodifiableListView) return _groups;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_groups);
}

 final  List<TaskResponse> _upcomingTasks;
@override List<TaskResponse> get upcomingTasks {
  if (_upcomingTasks is EqualUnmodifiableListView) return _upcomingTasks;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_upcomingTasks);
}

 final  List<TaskResponse> _overdueTasks;
@override List<TaskResponse> get overdueTasks {
  if (_overdueTasks is EqualUnmodifiableListView) return _overdueTasks;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_overdueTasks);
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
@override final  bool showGroupSearch;
@override final  String groupSearchQuery;
@override final  bool isRefreshing;

/// Create a copy of DashboardState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DashboardStateCopyWith<_DashboardState> get copyWith => __$DashboardStateCopyWithImpl<_DashboardState>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DashboardStateToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DashboardState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.showingProgression, showingProgression) || other.showingProgression == showingProgression)&&(identical(other.showingHighlights, showingHighlights) || other.showingHighlights == showingHighlights)&&(identical(other.groupsListType, groupsListType) || other.groupsListType == groupsListType)&&const DeepCollectionEquality().equals(other._groups, _groups)&&const DeepCollectionEquality().equals(other._upcomingTasks, _upcomingTasks)&&const DeepCollectionEquality().equals(other._overdueTasks, _overdueTasks)&&const DeepCollectionEquality().equals(other._invites, _invites)&&const DeepCollectionEquality().equals(other._progression, _progression)&&(identical(other.selection, selection) || other.selection == selection)&&(identical(other.showGroupSearch, showGroupSearch) || other.showGroupSearch == showGroupSearch)&&(identical(other.groupSearchQuery, groupSearchQuery) || other.groupSearchQuery == groupSearchQuery)&&(identical(other.isRefreshing, isRefreshing) || other.isRefreshing == isRefreshing));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,isLoading,showingProgression,showingHighlights,groupsListType,const DeepCollectionEquality().hash(_groups),const DeepCollectionEquality().hash(_upcomingTasks),const DeepCollectionEquality().hash(_overdueTasks),const DeepCollectionEquality().hash(_invites),const DeepCollectionEquality().hash(_progression),selection,showGroupSearch,groupSearchQuery,isRefreshing);

@override
String toString() {
  return 'DashboardState(isLoading: $isLoading, showingProgression: $showingProgression, showingHighlights: $showingHighlights, groupsListType: $groupsListType, groups: $groups, upcomingTasks: $upcomingTasks, overdueTasks: $overdueTasks, invites: $invites, progression: $progression, selection: $selection, showGroupSearch: $showGroupSearch, groupSearchQuery: $groupSearchQuery, isRefreshing: $isRefreshing)';
}


}

/// @nodoc
abstract mixin class _$DashboardStateCopyWith<$Res> implements $DashboardStateCopyWith<$Res> {
  factory _$DashboardStateCopyWith(_DashboardState value, $Res Function(_DashboardState) _then) = __$DashboardStateCopyWithImpl;
@override @useResult
$Res call({
 bool isLoading, bool showingProgression, bool showingHighlights, GroupsListType groupsListType, List<GroupResponse> groups, List<TaskResponse> upcomingTasks, List<TaskResponse> overdueTasks, List<InviteResponse> invites, List<WeeklyTaskProgression?> progression, TaskProgressionSelection selection, bool showGroupSearch, String groupSearchQuery, bool isRefreshing
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
@override @pragma('vm:prefer-inline') $Res call({Object? isLoading = null,Object? showingProgression = null,Object? showingHighlights = null,Object? groupsListType = null,Object? groups = null,Object? upcomingTasks = null,Object? overdueTasks = null,Object? invites = null,Object? progression = null,Object? selection = null,Object? showGroupSearch = null,Object? groupSearchQuery = null,Object? isRefreshing = null,}) {
  return _then(_DashboardState(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,showingProgression: null == showingProgression ? _self.showingProgression : showingProgression // ignore: cast_nullable_to_non_nullable
as bool,showingHighlights: null == showingHighlights ? _self.showingHighlights : showingHighlights // ignore: cast_nullable_to_non_nullable
as bool,groupsListType: null == groupsListType ? _self.groupsListType : groupsListType // ignore: cast_nullable_to_non_nullable
as GroupsListType,groups: null == groups ? _self._groups : groups // ignore: cast_nullable_to_non_nullable
as List<GroupResponse>,upcomingTasks: null == upcomingTasks ? _self._upcomingTasks : upcomingTasks // ignore: cast_nullable_to_non_nullable
as List<TaskResponse>,overdueTasks: null == overdueTasks ? _self._overdueTasks : overdueTasks // ignore: cast_nullable_to_non_nullable
as List<TaskResponse>,invites: null == invites ? _self._invites : invites // ignore: cast_nullable_to_non_nullable
as List<InviteResponse>,progression: null == progression ? _self._progression : progression // ignore: cast_nullable_to_non_nullable
as List<WeeklyTaskProgression?>,selection: null == selection ? _self.selection : selection // ignore: cast_nullable_to_non_nullable
as TaskProgressionSelection,showGroupSearch: null == showGroupSearch ? _self.showGroupSearch : showGroupSearch // ignore: cast_nullable_to_non_nullable
as bool,groupSearchQuery: null == groupSearchQuery ? _self.groupSearchQuery : groupSearchQuery // ignore: cast_nullable_to_non_nullable
as String,isRefreshing: null == isRefreshing ? _self.isRefreshing : isRefreshing // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
