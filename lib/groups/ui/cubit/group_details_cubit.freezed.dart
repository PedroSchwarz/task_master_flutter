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

 bool get isLoading; List<TaskResponse> get tasks; List<InviteResponse> get invites; DateTime get selectedDate; TaskListView get listView; TaskUserFilter get userFilter; TaskCompletionFilter get completionFilter; TaskStatusFilter get statusFilter; TaskPriorityFilter get priorityFilter; TaskDateSort get dateSort; TaskPrioritySort get prioritySort; GroupResponse? get group; UserData? get currentUser; UserResponse? get userToFilterBy; TaskResponse? get taskToDelete;
/// Create a copy of GroupDetailsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GroupDetailsStateCopyWith<GroupDetailsState> get copyWith => _$GroupDetailsStateCopyWithImpl<GroupDetailsState>(this as GroupDetailsState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GroupDetailsState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&const DeepCollectionEquality().equals(other.tasks, tasks)&&const DeepCollectionEquality().equals(other.invites, invites)&&(identical(other.selectedDate, selectedDate) || other.selectedDate == selectedDate)&&(identical(other.listView, listView) || other.listView == listView)&&(identical(other.userFilter, userFilter) || other.userFilter == userFilter)&&(identical(other.completionFilter, completionFilter) || other.completionFilter == completionFilter)&&(identical(other.statusFilter, statusFilter) || other.statusFilter == statusFilter)&&(identical(other.priorityFilter, priorityFilter) || other.priorityFilter == priorityFilter)&&(identical(other.dateSort, dateSort) || other.dateSort == dateSort)&&(identical(other.prioritySort, prioritySort) || other.prioritySort == prioritySort)&&(identical(other.group, group) || other.group == group)&&(identical(other.currentUser, currentUser) || other.currentUser == currentUser)&&(identical(other.userToFilterBy, userToFilterBy) || other.userToFilterBy == userToFilterBy)&&(identical(other.taskToDelete, taskToDelete) || other.taskToDelete == taskToDelete));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,const DeepCollectionEquality().hash(tasks),const DeepCollectionEquality().hash(invites),selectedDate,listView,userFilter,completionFilter,statusFilter,priorityFilter,dateSort,prioritySort,group,currentUser,userToFilterBy,taskToDelete);

@override
String toString() {
  return 'GroupDetailsState(isLoading: $isLoading, tasks: $tasks, invites: $invites, selectedDate: $selectedDate, listView: $listView, userFilter: $userFilter, completionFilter: $completionFilter, statusFilter: $statusFilter, priorityFilter: $priorityFilter, dateSort: $dateSort, prioritySort: $prioritySort, group: $group, currentUser: $currentUser, userToFilterBy: $userToFilterBy, taskToDelete: $taskToDelete)';
}


}

/// @nodoc
abstract mixin class $GroupDetailsStateCopyWith<$Res>  {
  factory $GroupDetailsStateCopyWith(GroupDetailsState value, $Res Function(GroupDetailsState) _then) = _$GroupDetailsStateCopyWithImpl;
@useResult
$Res call({
 bool isLoading, List<TaskResponse> tasks, List<InviteResponse> invites, DateTime selectedDate, TaskListView listView, TaskUserFilter userFilter, TaskCompletionFilter completionFilter, TaskStatusFilter statusFilter, TaskPriorityFilter priorityFilter, TaskDateSort dateSort, TaskPrioritySort prioritySort, GroupResponse? group, UserData? currentUser, UserResponse? userToFilterBy, TaskResponse? taskToDelete
});


$GroupResponseCopyWith<$Res>? get group;$UserDataCopyWith<$Res>? get currentUser;$UserResponseCopyWith<$Res>? get userToFilterBy;$TaskResponseCopyWith<$Res>? get taskToDelete;

}
/// @nodoc
class _$GroupDetailsStateCopyWithImpl<$Res>
    implements $GroupDetailsStateCopyWith<$Res> {
  _$GroupDetailsStateCopyWithImpl(this._self, this._then);

  final GroupDetailsState _self;
  final $Res Function(GroupDetailsState) _then;

/// Create a copy of GroupDetailsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isLoading = null,Object? tasks = null,Object? invites = null,Object? selectedDate = null,Object? listView = null,Object? userFilter = null,Object? completionFilter = null,Object? statusFilter = null,Object? priorityFilter = null,Object? dateSort = null,Object? prioritySort = null,Object? group = freezed,Object? currentUser = freezed,Object? userToFilterBy = freezed,Object? taskToDelete = freezed,}) {
  return _then(_self.copyWith(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,tasks: null == tasks ? _self.tasks : tasks // ignore: cast_nullable_to_non_nullable
as List<TaskResponse>,invites: null == invites ? _self.invites : invites // ignore: cast_nullable_to_non_nullable
as List<InviteResponse>,selectedDate: null == selectedDate ? _self.selectedDate : selectedDate // ignore: cast_nullable_to_non_nullable
as DateTime,listView: null == listView ? _self.listView : listView // ignore: cast_nullable_to_non_nullable
as TaskListView,userFilter: null == userFilter ? _self.userFilter : userFilter // ignore: cast_nullable_to_non_nullable
as TaskUserFilter,completionFilter: null == completionFilter ? _self.completionFilter : completionFilter // ignore: cast_nullable_to_non_nullable
as TaskCompletionFilter,statusFilter: null == statusFilter ? _self.statusFilter : statusFilter // ignore: cast_nullable_to_non_nullable
as TaskStatusFilter,priorityFilter: null == priorityFilter ? _self.priorityFilter : priorityFilter // ignore: cast_nullable_to_non_nullable
as TaskPriorityFilter,dateSort: null == dateSort ? _self.dateSort : dateSort // ignore: cast_nullable_to_non_nullable
as TaskDateSort,prioritySort: null == prioritySort ? _self.prioritySort : prioritySort // ignore: cast_nullable_to_non_nullable
as TaskPrioritySort,group: freezed == group ? _self.group : group // ignore: cast_nullable_to_non_nullable
as GroupResponse?,currentUser: freezed == currentUser ? _self.currentUser : currentUser // ignore: cast_nullable_to_non_nullable
as UserData?,userToFilterBy: freezed == userToFilterBy ? _self.userToFilterBy : userToFilterBy // ignore: cast_nullable_to_non_nullable
as UserResponse?,taskToDelete: freezed == taskToDelete ? _self.taskToDelete : taskToDelete // ignore: cast_nullable_to_non_nullable
as TaskResponse?,
  ));
}
/// Create a copy of GroupDetailsState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$GroupResponseCopyWith<$Res>? get group {
    if (_self.group == null) {
    return null;
  }

  return $GroupResponseCopyWith<$Res>(_self.group!, (value) {
    return _then(_self.copyWith(group: value));
  });
}/// Create a copy of GroupDetailsState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserDataCopyWith<$Res>? get currentUser {
    if (_self.currentUser == null) {
    return null;
  }

  return $UserDataCopyWith<$Res>(_self.currentUser!, (value) {
    return _then(_self.copyWith(currentUser: value));
  });
}/// Create a copy of GroupDetailsState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserResponseCopyWith<$Res>? get userToFilterBy {
    if (_self.userToFilterBy == null) {
    return null;
  }

  return $UserResponseCopyWith<$Res>(_self.userToFilterBy!, (value) {
    return _then(_self.copyWith(userToFilterBy: value));
  });
}/// Create a copy of GroupDetailsState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TaskResponseCopyWith<$Res>? get taskToDelete {
    if (_self.taskToDelete == null) {
    return null;
  }

  return $TaskResponseCopyWith<$Res>(_self.taskToDelete!, (value) {
    return _then(_self.copyWith(taskToDelete: value));
  });
}
}


/// @nodoc


class _GroupDetailsState extends GroupDetailsState {
  const _GroupDetailsState({required this.isLoading, required final  List<TaskResponse> tasks, required final  List<InviteResponse> invites, required this.selectedDate, required this.listView, required this.userFilter, required this.completionFilter, required this.statusFilter, required this.priorityFilter, required this.dateSort, required this.prioritySort, this.group, this.currentUser, this.userToFilterBy, this.taskToDelete}): _tasks = tasks,_invites = invites,super._();
  

@override final  bool isLoading;
 final  List<TaskResponse> _tasks;
@override List<TaskResponse> get tasks {
  if (_tasks is EqualUnmodifiableListView) return _tasks;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_tasks);
}

 final  List<InviteResponse> _invites;
@override List<InviteResponse> get invites {
  if (_invites is EqualUnmodifiableListView) return _invites;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_invites);
}

@override final  DateTime selectedDate;
@override final  TaskListView listView;
@override final  TaskUserFilter userFilter;
@override final  TaskCompletionFilter completionFilter;
@override final  TaskStatusFilter statusFilter;
@override final  TaskPriorityFilter priorityFilter;
@override final  TaskDateSort dateSort;
@override final  TaskPrioritySort prioritySort;
@override final  GroupResponse? group;
@override final  UserData? currentUser;
@override final  UserResponse? userToFilterBy;
@override final  TaskResponse? taskToDelete;

/// Create a copy of GroupDetailsState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GroupDetailsStateCopyWith<_GroupDetailsState> get copyWith => __$GroupDetailsStateCopyWithImpl<_GroupDetailsState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GroupDetailsState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&const DeepCollectionEquality().equals(other._tasks, _tasks)&&const DeepCollectionEquality().equals(other._invites, _invites)&&(identical(other.selectedDate, selectedDate) || other.selectedDate == selectedDate)&&(identical(other.listView, listView) || other.listView == listView)&&(identical(other.userFilter, userFilter) || other.userFilter == userFilter)&&(identical(other.completionFilter, completionFilter) || other.completionFilter == completionFilter)&&(identical(other.statusFilter, statusFilter) || other.statusFilter == statusFilter)&&(identical(other.priorityFilter, priorityFilter) || other.priorityFilter == priorityFilter)&&(identical(other.dateSort, dateSort) || other.dateSort == dateSort)&&(identical(other.prioritySort, prioritySort) || other.prioritySort == prioritySort)&&(identical(other.group, group) || other.group == group)&&(identical(other.currentUser, currentUser) || other.currentUser == currentUser)&&(identical(other.userToFilterBy, userToFilterBy) || other.userToFilterBy == userToFilterBy)&&(identical(other.taskToDelete, taskToDelete) || other.taskToDelete == taskToDelete));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,const DeepCollectionEquality().hash(_tasks),const DeepCollectionEquality().hash(_invites),selectedDate,listView,userFilter,completionFilter,statusFilter,priorityFilter,dateSort,prioritySort,group,currentUser,userToFilterBy,taskToDelete);

@override
String toString() {
  return 'GroupDetailsState(isLoading: $isLoading, tasks: $tasks, invites: $invites, selectedDate: $selectedDate, listView: $listView, userFilter: $userFilter, completionFilter: $completionFilter, statusFilter: $statusFilter, priorityFilter: $priorityFilter, dateSort: $dateSort, prioritySort: $prioritySort, group: $group, currentUser: $currentUser, userToFilterBy: $userToFilterBy, taskToDelete: $taskToDelete)';
}


}

/// @nodoc
abstract mixin class _$GroupDetailsStateCopyWith<$Res> implements $GroupDetailsStateCopyWith<$Res> {
  factory _$GroupDetailsStateCopyWith(_GroupDetailsState value, $Res Function(_GroupDetailsState) _then) = __$GroupDetailsStateCopyWithImpl;
@override @useResult
$Res call({
 bool isLoading, List<TaskResponse> tasks, List<InviteResponse> invites, DateTime selectedDate, TaskListView listView, TaskUserFilter userFilter, TaskCompletionFilter completionFilter, TaskStatusFilter statusFilter, TaskPriorityFilter priorityFilter, TaskDateSort dateSort, TaskPrioritySort prioritySort, GroupResponse? group, UserData? currentUser, UserResponse? userToFilterBy, TaskResponse? taskToDelete
});


@override $GroupResponseCopyWith<$Res>? get group;@override $UserDataCopyWith<$Res>? get currentUser;@override $UserResponseCopyWith<$Res>? get userToFilterBy;@override $TaskResponseCopyWith<$Res>? get taskToDelete;

}
/// @nodoc
class __$GroupDetailsStateCopyWithImpl<$Res>
    implements _$GroupDetailsStateCopyWith<$Res> {
  __$GroupDetailsStateCopyWithImpl(this._self, this._then);

  final _GroupDetailsState _self;
  final $Res Function(_GroupDetailsState) _then;

/// Create a copy of GroupDetailsState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isLoading = null,Object? tasks = null,Object? invites = null,Object? selectedDate = null,Object? listView = null,Object? userFilter = null,Object? completionFilter = null,Object? statusFilter = null,Object? priorityFilter = null,Object? dateSort = null,Object? prioritySort = null,Object? group = freezed,Object? currentUser = freezed,Object? userToFilterBy = freezed,Object? taskToDelete = freezed,}) {
  return _then(_GroupDetailsState(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,tasks: null == tasks ? _self._tasks : tasks // ignore: cast_nullable_to_non_nullable
as List<TaskResponse>,invites: null == invites ? _self._invites : invites // ignore: cast_nullable_to_non_nullable
as List<InviteResponse>,selectedDate: null == selectedDate ? _self.selectedDate : selectedDate // ignore: cast_nullable_to_non_nullable
as DateTime,listView: null == listView ? _self.listView : listView // ignore: cast_nullable_to_non_nullable
as TaskListView,userFilter: null == userFilter ? _self.userFilter : userFilter // ignore: cast_nullable_to_non_nullable
as TaskUserFilter,completionFilter: null == completionFilter ? _self.completionFilter : completionFilter // ignore: cast_nullable_to_non_nullable
as TaskCompletionFilter,statusFilter: null == statusFilter ? _self.statusFilter : statusFilter // ignore: cast_nullable_to_non_nullable
as TaskStatusFilter,priorityFilter: null == priorityFilter ? _self.priorityFilter : priorityFilter // ignore: cast_nullable_to_non_nullable
as TaskPriorityFilter,dateSort: null == dateSort ? _self.dateSort : dateSort // ignore: cast_nullable_to_non_nullable
as TaskDateSort,prioritySort: null == prioritySort ? _self.prioritySort : prioritySort // ignore: cast_nullable_to_non_nullable
as TaskPrioritySort,group: freezed == group ? _self.group : group // ignore: cast_nullable_to_non_nullable
as GroupResponse?,currentUser: freezed == currentUser ? _self.currentUser : currentUser // ignore: cast_nullable_to_non_nullable
as UserData?,userToFilterBy: freezed == userToFilterBy ? _self.userToFilterBy : userToFilterBy // ignore: cast_nullable_to_non_nullable
as UserResponse?,taskToDelete: freezed == taskToDelete ? _self.taskToDelete : taskToDelete // ignore: cast_nullable_to_non_nullable
as TaskResponse?,
  ));
}

/// Create a copy of GroupDetailsState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$GroupResponseCopyWith<$Res>? get group {
    if (_self.group == null) {
    return null;
  }

  return $GroupResponseCopyWith<$Res>(_self.group!, (value) {
    return _then(_self.copyWith(group: value));
  });
}/// Create a copy of GroupDetailsState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserDataCopyWith<$Res>? get currentUser {
    if (_self.currentUser == null) {
    return null;
  }

  return $UserDataCopyWith<$Res>(_self.currentUser!, (value) {
    return _then(_self.copyWith(currentUser: value));
  });
}/// Create a copy of GroupDetailsState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserResponseCopyWith<$Res>? get userToFilterBy {
    if (_self.userToFilterBy == null) {
    return null;
  }

  return $UserResponseCopyWith<$Res>(_self.userToFilterBy!, (value) {
    return _then(_self.copyWith(userToFilterBy: value));
  });
}/// Create a copy of GroupDetailsState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TaskResponseCopyWith<$Res>? get taskToDelete {
    if (_self.taskToDelete == null) {
    return null;
  }

  return $TaskResponseCopyWith<$Res>(_self.taskToDelete!, (value) {
    return _then(_self.copyWith(taskToDelete: value));
  });
}
}

// dart format on
