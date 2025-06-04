// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'create_task_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CreateTaskState {

 bool get isLoading; String get title; List<TaskChecklistItem> get checklist; TaskPriority get priority; TaskStatus get status; DateTime get date; TimeOfDay get time; Set<String> get assignedIds; bool get isSubmitting; bool get shouldGoBack; String? get description; GroupResponse? get group; TaskResponse? get task;
/// Create a copy of CreateTaskState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CreateTaskStateCopyWith<CreateTaskState> get copyWith => _$CreateTaskStateCopyWithImpl<CreateTaskState>(this as CreateTaskState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CreateTaskState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.title, title) || other.title == title)&&const DeepCollectionEquality().equals(other.checklist, checklist)&&(identical(other.priority, priority) || other.priority == priority)&&(identical(other.status, status) || other.status == status)&&(identical(other.date, date) || other.date == date)&&(identical(other.time, time) || other.time == time)&&const DeepCollectionEquality().equals(other.assignedIds, assignedIds)&&(identical(other.isSubmitting, isSubmitting) || other.isSubmitting == isSubmitting)&&(identical(other.shouldGoBack, shouldGoBack) || other.shouldGoBack == shouldGoBack)&&(identical(other.description, description) || other.description == description)&&(identical(other.group, group) || other.group == group)&&(identical(other.task, task) || other.task == task));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,title,const DeepCollectionEquality().hash(checklist),priority,status,date,time,const DeepCollectionEquality().hash(assignedIds),isSubmitting,shouldGoBack,description,group,task);

@override
String toString() {
  return 'CreateTaskState(isLoading: $isLoading, title: $title, checklist: $checklist, priority: $priority, status: $status, date: $date, time: $time, assignedIds: $assignedIds, isSubmitting: $isSubmitting, shouldGoBack: $shouldGoBack, description: $description, group: $group, task: $task)';
}


}

/// @nodoc
abstract mixin class $CreateTaskStateCopyWith<$Res>  {
  factory $CreateTaskStateCopyWith(CreateTaskState value, $Res Function(CreateTaskState) _then) = _$CreateTaskStateCopyWithImpl;
@useResult
$Res call({
 bool isLoading, String title, List<TaskChecklistItem> checklist, TaskPriority priority, TaskStatus status, DateTime date, TimeOfDay time, Set<String> assignedIds, bool isSubmitting, bool shouldGoBack, String? description, GroupResponse? group, TaskResponse? task
});


$GroupResponseCopyWith<$Res>? get group;$TaskResponseCopyWith<$Res>? get task;

}
/// @nodoc
class _$CreateTaskStateCopyWithImpl<$Res>
    implements $CreateTaskStateCopyWith<$Res> {
  _$CreateTaskStateCopyWithImpl(this._self, this._then);

  final CreateTaskState _self;
  final $Res Function(CreateTaskState) _then;

/// Create a copy of CreateTaskState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isLoading = null,Object? title = null,Object? checklist = null,Object? priority = null,Object? status = null,Object? date = null,Object? time = null,Object? assignedIds = null,Object? isSubmitting = null,Object? shouldGoBack = null,Object? description = freezed,Object? group = freezed,Object? task = freezed,}) {
  return _then(_self.copyWith(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,checklist: null == checklist ? _self.checklist : checklist // ignore: cast_nullable_to_non_nullable
as List<TaskChecklistItem>,priority: null == priority ? _self.priority : priority // ignore: cast_nullable_to_non_nullable
as TaskPriority,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as TaskStatus,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,time: null == time ? _self.time : time // ignore: cast_nullable_to_non_nullable
as TimeOfDay,assignedIds: null == assignedIds ? _self.assignedIds : assignedIds // ignore: cast_nullable_to_non_nullable
as Set<String>,isSubmitting: null == isSubmitting ? _self.isSubmitting : isSubmitting // ignore: cast_nullable_to_non_nullable
as bool,shouldGoBack: null == shouldGoBack ? _self.shouldGoBack : shouldGoBack // ignore: cast_nullable_to_non_nullable
as bool,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,group: freezed == group ? _self.group : group // ignore: cast_nullable_to_non_nullable
as GroupResponse?,task: freezed == task ? _self.task : task // ignore: cast_nullable_to_non_nullable
as TaskResponse?,
  ));
}
/// Create a copy of CreateTaskState
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
}/// Create a copy of CreateTaskState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TaskResponseCopyWith<$Res>? get task {
    if (_self.task == null) {
    return null;
  }

  return $TaskResponseCopyWith<$Res>(_self.task!, (value) {
    return _then(_self.copyWith(task: value));
  });
}
}


/// @nodoc


class _CreateTaskState extends CreateTaskState {
  const _CreateTaskState({required this.isLoading, required this.title, required final  List<TaskChecklistItem> checklist, required this.priority, required this.status, required this.date, required this.time, required final  Set<String> assignedIds, required this.isSubmitting, required this.shouldGoBack, this.description, this.group, this.task}): _checklist = checklist,_assignedIds = assignedIds,super._();
  

@override final  bool isLoading;
@override final  String title;
 final  List<TaskChecklistItem> _checklist;
@override List<TaskChecklistItem> get checklist {
  if (_checklist is EqualUnmodifiableListView) return _checklist;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_checklist);
}

@override final  TaskPriority priority;
@override final  TaskStatus status;
@override final  DateTime date;
@override final  TimeOfDay time;
 final  Set<String> _assignedIds;
@override Set<String> get assignedIds {
  if (_assignedIds is EqualUnmodifiableSetView) return _assignedIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableSetView(_assignedIds);
}

@override final  bool isSubmitting;
@override final  bool shouldGoBack;
@override final  String? description;
@override final  GroupResponse? group;
@override final  TaskResponse? task;

/// Create a copy of CreateTaskState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CreateTaskStateCopyWith<_CreateTaskState> get copyWith => __$CreateTaskStateCopyWithImpl<_CreateTaskState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CreateTaskState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.title, title) || other.title == title)&&const DeepCollectionEquality().equals(other._checklist, _checklist)&&(identical(other.priority, priority) || other.priority == priority)&&(identical(other.status, status) || other.status == status)&&(identical(other.date, date) || other.date == date)&&(identical(other.time, time) || other.time == time)&&const DeepCollectionEquality().equals(other._assignedIds, _assignedIds)&&(identical(other.isSubmitting, isSubmitting) || other.isSubmitting == isSubmitting)&&(identical(other.shouldGoBack, shouldGoBack) || other.shouldGoBack == shouldGoBack)&&(identical(other.description, description) || other.description == description)&&(identical(other.group, group) || other.group == group)&&(identical(other.task, task) || other.task == task));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,title,const DeepCollectionEquality().hash(_checklist),priority,status,date,time,const DeepCollectionEquality().hash(_assignedIds),isSubmitting,shouldGoBack,description,group,task);

@override
String toString() {
  return 'CreateTaskState(isLoading: $isLoading, title: $title, checklist: $checklist, priority: $priority, status: $status, date: $date, time: $time, assignedIds: $assignedIds, isSubmitting: $isSubmitting, shouldGoBack: $shouldGoBack, description: $description, group: $group, task: $task)';
}


}

/// @nodoc
abstract mixin class _$CreateTaskStateCopyWith<$Res> implements $CreateTaskStateCopyWith<$Res> {
  factory _$CreateTaskStateCopyWith(_CreateTaskState value, $Res Function(_CreateTaskState) _then) = __$CreateTaskStateCopyWithImpl;
@override @useResult
$Res call({
 bool isLoading, String title, List<TaskChecklistItem> checklist, TaskPriority priority, TaskStatus status, DateTime date, TimeOfDay time, Set<String> assignedIds, bool isSubmitting, bool shouldGoBack, String? description, GroupResponse? group, TaskResponse? task
});


@override $GroupResponseCopyWith<$Res>? get group;@override $TaskResponseCopyWith<$Res>? get task;

}
/// @nodoc
class __$CreateTaskStateCopyWithImpl<$Res>
    implements _$CreateTaskStateCopyWith<$Res> {
  __$CreateTaskStateCopyWithImpl(this._self, this._then);

  final _CreateTaskState _self;
  final $Res Function(_CreateTaskState) _then;

/// Create a copy of CreateTaskState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isLoading = null,Object? title = null,Object? checklist = null,Object? priority = null,Object? status = null,Object? date = null,Object? time = null,Object? assignedIds = null,Object? isSubmitting = null,Object? shouldGoBack = null,Object? description = freezed,Object? group = freezed,Object? task = freezed,}) {
  return _then(_CreateTaskState(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,checklist: null == checklist ? _self._checklist : checklist // ignore: cast_nullable_to_non_nullable
as List<TaskChecklistItem>,priority: null == priority ? _self.priority : priority // ignore: cast_nullable_to_non_nullable
as TaskPriority,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as TaskStatus,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,time: null == time ? _self.time : time // ignore: cast_nullable_to_non_nullable
as TimeOfDay,assignedIds: null == assignedIds ? _self._assignedIds : assignedIds // ignore: cast_nullable_to_non_nullable
as Set<String>,isSubmitting: null == isSubmitting ? _self.isSubmitting : isSubmitting // ignore: cast_nullable_to_non_nullable
as bool,shouldGoBack: null == shouldGoBack ? _self.shouldGoBack : shouldGoBack // ignore: cast_nullable_to_non_nullable
as bool,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,group: freezed == group ? _self.group : group // ignore: cast_nullable_to_non_nullable
as GroupResponse?,task: freezed == task ? _self.task : task // ignore: cast_nullable_to_non_nullable
as TaskResponse?,
  ));
}

/// Create a copy of CreateTaskState
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
}/// Create a copy of CreateTaskState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TaskResponseCopyWith<$Res>? get task {
    if (_self.task == null) {
    return null;
  }

  return $TaskResponseCopyWith<$Res>(_self.task!, (value) {
    return _then(_self.copyWith(task: value));
  });
}
}

// dart format on
