// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'update_task_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$UpdateTaskRequest {

 String get title; DateTime get dueDate; TaskPriority get priority; TaskStatus get status; bool get completed; List<String> get assignedTo; List<UpdateTaskChecklistItem> get checklist;@JsonKey(includeIfNull: false) String? get description;
/// Create a copy of UpdateTaskRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UpdateTaskRequestCopyWith<UpdateTaskRequest> get copyWith => _$UpdateTaskRequestCopyWithImpl<UpdateTaskRequest>(this as UpdateTaskRequest, _$identity);

  /// Serializes this UpdateTaskRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UpdateTaskRequest&&(identical(other.title, title) || other.title == title)&&(identical(other.dueDate, dueDate) || other.dueDate == dueDate)&&(identical(other.priority, priority) || other.priority == priority)&&(identical(other.status, status) || other.status == status)&&(identical(other.completed, completed) || other.completed == completed)&&const DeepCollectionEquality().equals(other.assignedTo, assignedTo)&&const DeepCollectionEquality().equals(other.checklist, checklist)&&(identical(other.description, description) || other.description == description));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,title,dueDate,priority,status,completed,const DeepCollectionEquality().hash(assignedTo),const DeepCollectionEquality().hash(checklist),description);

@override
String toString() {
  return 'UpdateTaskRequest(title: $title, dueDate: $dueDate, priority: $priority, status: $status, completed: $completed, assignedTo: $assignedTo, checklist: $checklist, description: $description)';
}


}

/// @nodoc
abstract mixin class $UpdateTaskRequestCopyWith<$Res>  {
  factory $UpdateTaskRequestCopyWith(UpdateTaskRequest value, $Res Function(UpdateTaskRequest) _then) = _$UpdateTaskRequestCopyWithImpl;
@useResult
$Res call({
 String title, DateTime dueDate, TaskPriority priority, TaskStatus status, bool completed, List<String> assignedTo, List<UpdateTaskChecklistItem> checklist,@JsonKey(includeIfNull: false) String? description
});




}
/// @nodoc
class _$UpdateTaskRequestCopyWithImpl<$Res>
    implements $UpdateTaskRequestCopyWith<$Res> {
  _$UpdateTaskRequestCopyWithImpl(this._self, this._then);

  final UpdateTaskRequest _self;
  final $Res Function(UpdateTaskRequest) _then;

/// Create a copy of UpdateTaskRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? title = null,Object? dueDate = null,Object? priority = null,Object? status = null,Object? completed = null,Object? assignedTo = null,Object? checklist = null,Object? description = freezed,}) {
  return _then(_self.copyWith(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,dueDate: null == dueDate ? _self.dueDate : dueDate // ignore: cast_nullable_to_non_nullable
as DateTime,priority: null == priority ? _self.priority : priority // ignore: cast_nullable_to_non_nullable
as TaskPriority,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as TaskStatus,completed: null == completed ? _self.completed : completed // ignore: cast_nullable_to_non_nullable
as bool,assignedTo: null == assignedTo ? _self.assignedTo : assignedTo // ignore: cast_nullable_to_non_nullable
as List<String>,checklist: null == checklist ? _self.checklist : checklist // ignore: cast_nullable_to_non_nullable
as List<UpdateTaskChecklistItem>,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _UpdateTaskRequest implements UpdateTaskRequest {
  const _UpdateTaskRequest({required this.title, required this.dueDate, required this.priority, required this.status, required this.completed, required final  List<String> assignedTo, required final  List<UpdateTaskChecklistItem> checklist, @JsonKey(includeIfNull: false) this.description}): _assignedTo = assignedTo,_checklist = checklist;
  factory _UpdateTaskRequest.fromJson(Map<String, dynamic> json) => _$UpdateTaskRequestFromJson(json);

@override final  String title;
@override final  DateTime dueDate;
@override final  TaskPriority priority;
@override final  TaskStatus status;
@override final  bool completed;
 final  List<String> _assignedTo;
@override List<String> get assignedTo {
  if (_assignedTo is EqualUnmodifiableListView) return _assignedTo;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_assignedTo);
}

 final  List<UpdateTaskChecklistItem> _checklist;
@override List<UpdateTaskChecklistItem> get checklist {
  if (_checklist is EqualUnmodifiableListView) return _checklist;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_checklist);
}

@override@JsonKey(includeIfNull: false) final  String? description;

/// Create a copy of UpdateTaskRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UpdateTaskRequestCopyWith<_UpdateTaskRequest> get copyWith => __$UpdateTaskRequestCopyWithImpl<_UpdateTaskRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UpdateTaskRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UpdateTaskRequest&&(identical(other.title, title) || other.title == title)&&(identical(other.dueDate, dueDate) || other.dueDate == dueDate)&&(identical(other.priority, priority) || other.priority == priority)&&(identical(other.status, status) || other.status == status)&&(identical(other.completed, completed) || other.completed == completed)&&const DeepCollectionEquality().equals(other._assignedTo, _assignedTo)&&const DeepCollectionEquality().equals(other._checklist, _checklist)&&(identical(other.description, description) || other.description == description));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,title,dueDate,priority,status,completed,const DeepCollectionEquality().hash(_assignedTo),const DeepCollectionEquality().hash(_checklist),description);

@override
String toString() {
  return 'UpdateTaskRequest(title: $title, dueDate: $dueDate, priority: $priority, status: $status, completed: $completed, assignedTo: $assignedTo, checklist: $checklist, description: $description)';
}


}

/// @nodoc
abstract mixin class _$UpdateTaskRequestCopyWith<$Res> implements $UpdateTaskRequestCopyWith<$Res> {
  factory _$UpdateTaskRequestCopyWith(_UpdateTaskRequest value, $Res Function(_UpdateTaskRequest) _then) = __$UpdateTaskRequestCopyWithImpl;
@override @useResult
$Res call({
 String title, DateTime dueDate, TaskPriority priority, TaskStatus status, bool completed, List<String> assignedTo, List<UpdateTaskChecklistItem> checklist,@JsonKey(includeIfNull: false) String? description
});




}
/// @nodoc
class __$UpdateTaskRequestCopyWithImpl<$Res>
    implements _$UpdateTaskRequestCopyWith<$Res> {
  __$UpdateTaskRequestCopyWithImpl(this._self, this._then);

  final _UpdateTaskRequest _self;
  final $Res Function(_UpdateTaskRequest) _then;

/// Create a copy of UpdateTaskRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? title = null,Object? dueDate = null,Object? priority = null,Object? status = null,Object? completed = null,Object? assignedTo = null,Object? checklist = null,Object? description = freezed,}) {
  return _then(_UpdateTaskRequest(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,dueDate: null == dueDate ? _self.dueDate : dueDate // ignore: cast_nullable_to_non_nullable
as DateTime,priority: null == priority ? _self.priority : priority // ignore: cast_nullable_to_non_nullable
as TaskPriority,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as TaskStatus,completed: null == completed ? _self.completed : completed // ignore: cast_nullable_to_non_nullable
as bool,assignedTo: null == assignedTo ? _self._assignedTo : assignedTo // ignore: cast_nullable_to_non_nullable
as List<String>,checklist: null == checklist ? _self._checklist : checklist // ignore: cast_nullable_to_non_nullable
as List<UpdateTaskChecklistItem>,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$UpdateTaskChecklistItem {

 String get title; TaskChecklistItemStatus get status; int get order;
/// Create a copy of UpdateTaskChecklistItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UpdateTaskChecklistItemCopyWith<UpdateTaskChecklistItem> get copyWith => _$UpdateTaskChecklistItemCopyWithImpl<UpdateTaskChecklistItem>(this as UpdateTaskChecklistItem, _$identity);

  /// Serializes this UpdateTaskChecklistItem to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UpdateTaskChecklistItem&&(identical(other.title, title) || other.title == title)&&(identical(other.status, status) || other.status == status)&&(identical(other.order, order) || other.order == order));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,title,status,order);

@override
String toString() {
  return 'UpdateTaskChecklistItem(title: $title, status: $status, order: $order)';
}


}

/// @nodoc
abstract mixin class $UpdateTaskChecklistItemCopyWith<$Res>  {
  factory $UpdateTaskChecklistItemCopyWith(UpdateTaskChecklistItem value, $Res Function(UpdateTaskChecklistItem) _then) = _$UpdateTaskChecklistItemCopyWithImpl;
@useResult
$Res call({
 String title, TaskChecklistItemStatus status, int order
});




}
/// @nodoc
class _$UpdateTaskChecklistItemCopyWithImpl<$Res>
    implements $UpdateTaskChecklistItemCopyWith<$Res> {
  _$UpdateTaskChecklistItemCopyWithImpl(this._self, this._then);

  final UpdateTaskChecklistItem _self;
  final $Res Function(UpdateTaskChecklistItem) _then;

/// Create a copy of UpdateTaskChecklistItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? title = null,Object? status = null,Object? order = null,}) {
  return _then(_self.copyWith(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as TaskChecklistItemStatus,order: null == order ? _self.order : order // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _UpdateTaskChecklistItem implements UpdateTaskChecklistItem {
  const _UpdateTaskChecklistItem({required this.title, required this.status, required this.order});
  factory _UpdateTaskChecklistItem.fromJson(Map<String, dynamic> json) => _$UpdateTaskChecklistItemFromJson(json);

@override final  String title;
@override final  TaskChecklistItemStatus status;
@override final  int order;

/// Create a copy of UpdateTaskChecklistItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UpdateTaskChecklistItemCopyWith<_UpdateTaskChecklistItem> get copyWith => __$UpdateTaskChecklistItemCopyWithImpl<_UpdateTaskChecklistItem>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UpdateTaskChecklistItemToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UpdateTaskChecklistItem&&(identical(other.title, title) || other.title == title)&&(identical(other.status, status) || other.status == status)&&(identical(other.order, order) || other.order == order));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,title,status,order);

@override
String toString() {
  return 'UpdateTaskChecklistItem(title: $title, status: $status, order: $order)';
}


}

/// @nodoc
abstract mixin class _$UpdateTaskChecklistItemCopyWith<$Res> implements $UpdateTaskChecklistItemCopyWith<$Res> {
  factory _$UpdateTaskChecklistItemCopyWith(_UpdateTaskChecklistItem value, $Res Function(_UpdateTaskChecklistItem) _then) = __$UpdateTaskChecklistItemCopyWithImpl;
@override @useResult
$Res call({
 String title, TaskChecklistItemStatus status, int order
});




}
/// @nodoc
class __$UpdateTaskChecklistItemCopyWithImpl<$Res>
    implements _$UpdateTaskChecklistItemCopyWith<$Res> {
  __$UpdateTaskChecklistItemCopyWithImpl(this._self, this._then);

  final _UpdateTaskChecklistItem _self;
  final $Res Function(_UpdateTaskChecklistItem) _then;

/// Create a copy of UpdateTaskChecklistItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? title = null,Object? status = null,Object? order = null,}) {
  return _then(_UpdateTaskChecklistItem(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as TaskChecklistItemStatus,order: null == order ? _self.order : order // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
