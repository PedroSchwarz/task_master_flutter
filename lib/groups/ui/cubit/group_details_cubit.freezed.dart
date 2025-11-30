// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
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

 bool get isLoading; List<TaskResponse> get tasks; List<InviteResponse> get invites; DateTime get selectedDate; TaskListView get listView; TaskUserFilter get userFilter; TaskCompletionFilter get completionFilter; TaskStatusFilter get statusFilter; TaskPriorityFilter get priorityFilter; TaskDateSort get dateSort; TaskPrioritySort get prioritySort; bool get showLeaveDialog; bool get isRefreshing; bool get shouldGoBack; GroupResponse? get group; UserData? get currentUser; UserResponse? get userToFilterBy; TaskResponse? get taskToDelete;
/// Create a copy of GroupDetailsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GroupDetailsStateCopyWith<GroupDetailsState> get copyWith => _$GroupDetailsStateCopyWithImpl<GroupDetailsState>(this as GroupDetailsState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GroupDetailsState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&const DeepCollectionEquality().equals(other.tasks, tasks)&&const DeepCollectionEquality().equals(other.invites, invites)&&(identical(other.selectedDate, selectedDate) || other.selectedDate == selectedDate)&&(identical(other.listView, listView) || other.listView == listView)&&(identical(other.userFilter, userFilter) || other.userFilter == userFilter)&&(identical(other.completionFilter, completionFilter) || other.completionFilter == completionFilter)&&(identical(other.statusFilter, statusFilter) || other.statusFilter == statusFilter)&&(identical(other.priorityFilter, priorityFilter) || other.priorityFilter == priorityFilter)&&(identical(other.dateSort, dateSort) || other.dateSort == dateSort)&&(identical(other.prioritySort, prioritySort) || other.prioritySort == prioritySort)&&(identical(other.showLeaveDialog, showLeaveDialog) || other.showLeaveDialog == showLeaveDialog)&&(identical(other.isRefreshing, isRefreshing) || other.isRefreshing == isRefreshing)&&(identical(other.shouldGoBack, shouldGoBack) || other.shouldGoBack == shouldGoBack)&&(identical(other.group, group) || other.group == group)&&(identical(other.currentUser, currentUser) || other.currentUser == currentUser)&&(identical(other.userToFilterBy, userToFilterBy) || other.userToFilterBy == userToFilterBy)&&(identical(other.taskToDelete, taskToDelete) || other.taskToDelete == taskToDelete));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,const DeepCollectionEquality().hash(tasks),const DeepCollectionEquality().hash(invites),selectedDate,listView,userFilter,completionFilter,statusFilter,priorityFilter,dateSort,prioritySort,showLeaveDialog,isRefreshing,shouldGoBack,group,currentUser,userToFilterBy,taskToDelete);

@override
String toString() {
  return 'GroupDetailsState(isLoading: $isLoading, tasks: $tasks, invites: $invites, selectedDate: $selectedDate, listView: $listView, userFilter: $userFilter, completionFilter: $completionFilter, statusFilter: $statusFilter, priorityFilter: $priorityFilter, dateSort: $dateSort, prioritySort: $prioritySort, showLeaveDialog: $showLeaveDialog, isRefreshing: $isRefreshing, shouldGoBack: $shouldGoBack, group: $group, currentUser: $currentUser, userToFilterBy: $userToFilterBy, taskToDelete: $taskToDelete)';
}


}

/// @nodoc
abstract mixin class $GroupDetailsStateCopyWith<$Res>  {
  factory $GroupDetailsStateCopyWith(GroupDetailsState value, $Res Function(GroupDetailsState) _then) = _$GroupDetailsStateCopyWithImpl;
@useResult
$Res call({
 bool isLoading, List<TaskResponse> tasks, List<InviteResponse> invites, DateTime selectedDate, TaskListView listView, TaskUserFilter userFilter, TaskCompletionFilter completionFilter, TaskStatusFilter statusFilter, TaskPriorityFilter priorityFilter, TaskDateSort dateSort, TaskPrioritySort prioritySort, bool showLeaveDialog, bool isRefreshing, bool shouldGoBack, GroupResponse? group, UserData? currentUser, UserResponse? userToFilterBy, TaskResponse? taskToDelete
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
@pragma('vm:prefer-inline') @override $Res call({Object? isLoading = null,Object? tasks = null,Object? invites = null,Object? selectedDate = null,Object? listView = null,Object? userFilter = null,Object? completionFilter = null,Object? statusFilter = null,Object? priorityFilter = null,Object? dateSort = null,Object? prioritySort = null,Object? showLeaveDialog = null,Object? isRefreshing = null,Object? shouldGoBack = null,Object? group = freezed,Object? currentUser = freezed,Object? userToFilterBy = freezed,Object? taskToDelete = freezed,}) {
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
as TaskPrioritySort,showLeaveDialog: null == showLeaveDialog ? _self.showLeaveDialog : showLeaveDialog // ignore: cast_nullable_to_non_nullable
as bool,isRefreshing: null == isRefreshing ? _self.isRefreshing : isRefreshing // ignore: cast_nullable_to_non_nullable
as bool,shouldGoBack: null == shouldGoBack ? _self.shouldGoBack : shouldGoBack // ignore: cast_nullable_to_non_nullable
as bool,group: freezed == group ? _self.group : group // ignore: cast_nullable_to_non_nullable
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


/// Adds pattern-matching-related methods to [GroupDetailsState].
extension GroupDetailsStatePatterns on GroupDetailsState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GroupDetailsState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GroupDetailsState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GroupDetailsState value)  $default,){
final _that = this;
switch (_that) {
case _GroupDetailsState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GroupDetailsState value)?  $default,){
final _that = this;
switch (_that) {
case _GroupDetailsState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool isLoading,  List<TaskResponse> tasks,  List<InviteResponse> invites,  DateTime selectedDate,  TaskListView listView,  TaskUserFilter userFilter,  TaskCompletionFilter completionFilter,  TaskStatusFilter statusFilter,  TaskPriorityFilter priorityFilter,  TaskDateSort dateSort,  TaskPrioritySort prioritySort,  bool showLeaveDialog,  bool isRefreshing,  bool shouldGoBack,  GroupResponse? group,  UserData? currentUser,  UserResponse? userToFilterBy,  TaskResponse? taskToDelete)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GroupDetailsState() when $default != null:
return $default(_that.isLoading,_that.tasks,_that.invites,_that.selectedDate,_that.listView,_that.userFilter,_that.completionFilter,_that.statusFilter,_that.priorityFilter,_that.dateSort,_that.prioritySort,_that.showLeaveDialog,_that.isRefreshing,_that.shouldGoBack,_that.group,_that.currentUser,_that.userToFilterBy,_that.taskToDelete);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool isLoading,  List<TaskResponse> tasks,  List<InviteResponse> invites,  DateTime selectedDate,  TaskListView listView,  TaskUserFilter userFilter,  TaskCompletionFilter completionFilter,  TaskStatusFilter statusFilter,  TaskPriorityFilter priorityFilter,  TaskDateSort dateSort,  TaskPrioritySort prioritySort,  bool showLeaveDialog,  bool isRefreshing,  bool shouldGoBack,  GroupResponse? group,  UserData? currentUser,  UserResponse? userToFilterBy,  TaskResponse? taskToDelete)  $default,) {final _that = this;
switch (_that) {
case _GroupDetailsState():
return $default(_that.isLoading,_that.tasks,_that.invites,_that.selectedDate,_that.listView,_that.userFilter,_that.completionFilter,_that.statusFilter,_that.priorityFilter,_that.dateSort,_that.prioritySort,_that.showLeaveDialog,_that.isRefreshing,_that.shouldGoBack,_that.group,_that.currentUser,_that.userToFilterBy,_that.taskToDelete);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool isLoading,  List<TaskResponse> tasks,  List<InviteResponse> invites,  DateTime selectedDate,  TaskListView listView,  TaskUserFilter userFilter,  TaskCompletionFilter completionFilter,  TaskStatusFilter statusFilter,  TaskPriorityFilter priorityFilter,  TaskDateSort dateSort,  TaskPrioritySort prioritySort,  bool showLeaveDialog,  bool isRefreshing,  bool shouldGoBack,  GroupResponse? group,  UserData? currentUser,  UserResponse? userToFilterBy,  TaskResponse? taskToDelete)?  $default,) {final _that = this;
switch (_that) {
case _GroupDetailsState() when $default != null:
return $default(_that.isLoading,_that.tasks,_that.invites,_that.selectedDate,_that.listView,_that.userFilter,_that.completionFilter,_that.statusFilter,_that.priorityFilter,_that.dateSort,_that.prioritySort,_that.showLeaveDialog,_that.isRefreshing,_that.shouldGoBack,_that.group,_that.currentUser,_that.userToFilterBy,_that.taskToDelete);case _:
  return null;

}
}

}

/// @nodoc


class _GroupDetailsState extends GroupDetailsState {
  const _GroupDetailsState({required this.isLoading, required final  List<TaskResponse> tasks, required final  List<InviteResponse> invites, required this.selectedDate, required this.listView, required this.userFilter, required this.completionFilter, required this.statusFilter, required this.priorityFilter, required this.dateSort, required this.prioritySort, required this.showLeaveDialog, required this.isRefreshing, required this.shouldGoBack, this.group, this.currentUser, this.userToFilterBy, this.taskToDelete}): _tasks = tasks,_invites = invites,super._();
  

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
@override final  bool showLeaveDialog;
@override final  bool isRefreshing;
@override final  bool shouldGoBack;
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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GroupDetailsState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&const DeepCollectionEquality().equals(other._tasks, _tasks)&&const DeepCollectionEquality().equals(other._invites, _invites)&&(identical(other.selectedDate, selectedDate) || other.selectedDate == selectedDate)&&(identical(other.listView, listView) || other.listView == listView)&&(identical(other.userFilter, userFilter) || other.userFilter == userFilter)&&(identical(other.completionFilter, completionFilter) || other.completionFilter == completionFilter)&&(identical(other.statusFilter, statusFilter) || other.statusFilter == statusFilter)&&(identical(other.priorityFilter, priorityFilter) || other.priorityFilter == priorityFilter)&&(identical(other.dateSort, dateSort) || other.dateSort == dateSort)&&(identical(other.prioritySort, prioritySort) || other.prioritySort == prioritySort)&&(identical(other.showLeaveDialog, showLeaveDialog) || other.showLeaveDialog == showLeaveDialog)&&(identical(other.isRefreshing, isRefreshing) || other.isRefreshing == isRefreshing)&&(identical(other.shouldGoBack, shouldGoBack) || other.shouldGoBack == shouldGoBack)&&(identical(other.group, group) || other.group == group)&&(identical(other.currentUser, currentUser) || other.currentUser == currentUser)&&(identical(other.userToFilterBy, userToFilterBy) || other.userToFilterBy == userToFilterBy)&&(identical(other.taskToDelete, taskToDelete) || other.taskToDelete == taskToDelete));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,const DeepCollectionEquality().hash(_tasks),const DeepCollectionEquality().hash(_invites),selectedDate,listView,userFilter,completionFilter,statusFilter,priorityFilter,dateSort,prioritySort,showLeaveDialog,isRefreshing,shouldGoBack,group,currentUser,userToFilterBy,taskToDelete);

@override
String toString() {
  return 'GroupDetailsState(isLoading: $isLoading, tasks: $tasks, invites: $invites, selectedDate: $selectedDate, listView: $listView, userFilter: $userFilter, completionFilter: $completionFilter, statusFilter: $statusFilter, priorityFilter: $priorityFilter, dateSort: $dateSort, prioritySort: $prioritySort, showLeaveDialog: $showLeaveDialog, isRefreshing: $isRefreshing, shouldGoBack: $shouldGoBack, group: $group, currentUser: $currentUser, userToFilterBy: $userToFilterBy, taskToDelete: $taskToDelete)';
}


}

/// @nodoc
abstract mixin class _$GroupDetailsStateCopyWith<$Res> implements $GroupDetailsStateCopyWith<$Res> {
  factory _$GroupDetailsStateCopyWith(_GroupDetailsState value, $Res Function(_GroupDetailsState) _then) = __$GroupDetailsStateCopyWithImpl;
@override @useResult
$Res call({
 bool isLoading, List<TaskResponse> tasks, List<InviteResponse> invites, DateTime selectedDate, TaskListView listView, TaskUserFilter userFilter, TaskCompletionFilter completionFilter, TaskStatusFilter statusFilter, TaskPriorityFilter priorityFilter, TaskDateSort dateSort, TaskPrioritySort prioritySort, bool showLeaveDialog, bool isRefreshing, bool shouldGoBack, GroupResponse? group, UserData? currentUser, UserResponse? userToFilterBy, TaskResponse? taskToDelete
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
@override @pragma('vm:prefer-inline') $Res call({Object? isLoading = null,Object? tasks = null,Object? invites = null,Object? selectedDate = null,Object? listView = null,Object? userFilter = null,Object? completionFilter = null,Object? statusFilter = null,Object? priorityFilter = null,Object? dateSort = null,Object? prioritySort = null,Object? showLeaveDialog = null,Object? isRefreshing = null,Object? shouldGoBack = null,Object? group = freezed,Object? currentUser = freezed,Object? userToFilterBy = freezed,Object? taskToDelete = freezed,}) {
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
as TaskPrioritySort,showLeaveDialog: null == showLeaveDialog ? _self.showLeaveDialog : showLeaveDialog // ignore: cast_nullable_to_non_nullable
as bool,isRefreshing: null == isRefreshing ? _self.isRefreshing : isRefreshing // ignore: cast_nullable_to_non_nullable
as bool,shouldGoBack: null == shouldGoBack ? _self.shouldGoBack : shouldGoBack // ignore: cast_nullable_to_non_nullable
as bool,group: freezed == group ? _self.group : group // ignore: cast_nullable_to_non_nullable
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
