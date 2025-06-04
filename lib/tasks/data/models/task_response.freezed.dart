// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'task_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TaskResponse {

@JsonKey(name: '_id') String get id; String get title; List<TaskChecklistItem> get checklist; TaskPriority get priority; TaskStatus get status; DateTime get dueDate; bool get completed; String get group; UserResponse get owner; List<UserResponse> get assignedTo; DateTime get createdAt; DateTime get updatedAt; String? get description;
/// Create a copy of TaskResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TaskResponseCopyWith<TaskResponse> get copyWith => _$TaskResponseCopyWithImpl<TaskResponse>(this as TaskResponse, _$identity);

  /// Serializes this TaskResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TaskResponse&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&const DeepCollectionEquality().equals(other.checklist, checklist)&&(identical(other.priority, priority) || other.priority == priority)&&(identical(other.status, status) || other.status == status)&&(identical(other.dueDate, dueDate) || other.dueDate == dueDate)&&(identical(other.completed, completed) || other.completed == completed)&&(identical(other.group, group) || other.group == group)&&(identical(other.owner, owner) || other.owner == owner)&&const DeepCollectionEquality().equals(other.assignedTo, assignedTo)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.description, description) || other.description == description));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,const DeepCollectionEquality().hash(checklist),priority,status,dueDate,completed,group,owner,const DeepCollectionEquality().hash(assignedTo),createdAt,updatedAt,description);

@override
String toString() {
  return 'TaskResponse(id: $id, title: $title, checklist: $checklist, priority: $priority, status: $status, dueDate: $dueDate, completed: $completed, group: $group, owner: $owner, assignedTo: $assignedTo, createdAt: $createdAt, updatedAt: $updatedAt, description: $description)';
}


}

/// @nodoc
abstract mixin class $TaskResponseCopyWith<$Res>  {
  factory $TaskResponseCopyWith(TaskResponse value, $Res Function(TaskResponse) _then) = _$TaskResponseCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: '_id') String id, String title, List<TaskChecklistItem> checklist, TaskPriority priority, TaskStatus status, DateTime dueDate, bool completed, String group, UserResponse owner, List<UserResponse> assignedTo, DateTime createdAt, DateTime updatedAt, String? description
});


$UserResponseCopyWith<$Res> get owner;

}
/// @nodoc
class _$TaskResponseCopyWithImpl<$Res>
    implements $TaskResponseCopyWith<$Res> {
  _$TaskResponseCopyWithImpl(this._self, this._then);

  final TaskResponse _self;
  final $Res Function(TaskResponse) _then;

/// Create a copy of TaskResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? checklist = null,Object? priority = null,Object? status = null,Object? dueDate = null,Object? completed = null,Object? group = null,Object? owner = null,Object? assignedTo = null,Object? createdAt = null,Object? updatedAt = null,Object? description = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,checklist: null == checklist ? _self.checklist : checklist // ignore: cast_nullable_to_non_nullable
as List<TaskChecklistItem>,priority: null == priority ? _self.priority : priority // ignore: cast_nullable_to_non_nullable
as TaskPriority,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as TaskStatus,dueDate: null == dueDate ? _self.dueDate : dueDate // ignore: cast_nullable_to_non_nullable
as DateTime,completed: null == completed ? _self.completed : completed // ignore: cast_nullable_to_non_nullable
as bool,group: null == group ? _self.group : group // ignore: cast_nullable_to_non_nullable
as String,owner: null == owner ? _self.owner : owner // ignore: cast_nullable_to_non_nullable
as UserResponse,assignedTo: null == assignedTo ? _self.assignedTo : assignedTo // ignore: cast_nullable_to_non_nullable
as List<UserResponse>,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of TaskResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserResponseCopyWith<$Res> get owner {
  
  return $UserResponseCopyWith<$Res>(_self.owner, (value) {
    return _then(_self.copyWith(owner: value));
  });
}
}


/// @nodoc
@JsonSerializable()

class _TaskResponse extends TaskResponse {
  const _TaskResponse({@JsonKey(name: '_id') required this.id, required this.title, required final  List<TaskChecklistItem> checklist, required this.priority, required this.status, required this.dueDate, required this.completed, required this.group, required this.owner, required final  List<UserResponse> assignedTo, required this.createdAt, required this.updatedAt, this.description}): _checklist = checklist,_assignedTo = assignedTo,super._();
  factory _TaskResponse.fromJson(Map<String, dynamic> json) => _$TaskResponseFromJson(json);

@override@JsonKey(name: '_id') final  String id;
@override final  String title;
 final  List<TaskChecklistItem> _checklist;
@override List<TaskChecklistItem> get checklist {
  if (_checklist is EqualUnmodifiableListView) return _checklist;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_checklist);
}

@override final  TaskPriority priority;
@override final  TaskStatus status;
@override final  DateTime dueDate;
@override final  bool completed;
@override final  String group;
@override final  UserResponse owner;
 final  List<UserResponse> _assignedTo;
@override List<UserResponse> get assignedTo {
  if (_assignedTo is EqualUnmodifiableListView) return _assignedTo;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_assignedTo);
}

@override final  DateTime createdAt;
@override final  DateTime updatedAt;
@override final  String? description;

/// Create a copy of TaskResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TaskResponseCopyWith<_TaskResponse> get copyWith => __$TaskResponseCopyWithImpl<_TaskResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TaskResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TaskResponse&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&const DeepCollectionEquality().equals(other._checklist, _checklist)&&(identical(other.priority, priority) || other.priority == priority)&&(identical(other.status, status) || other.status == status)&&(identical(other.dueDate, dueDate) || other.dueDate == dueDate)&&(identical(other.completed, completed) || other.completed == completed)&&(identical(other.group, group) || other.group == group)&&(identical(other.owner, owner) || other.owner == owner)&&const DeepCollectionEquality().equals(other._assignedTo, _assignedTo)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.description, description) || other.description == description));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,const DeepCollectionEquality().hash(_checklist),priority,status,dueDate,completed,group,owner,const DeepCollectionEquality().hash(_assignedTo),createdAt,updatedAt,description);

@override
String toString() {
  return 'TaskResponse(id: $id, title: $title, checklist: $checklist, priority: $priority, status: $status, dueDate: $dueDate, completed: $completed, group: $group, owner: $owner, assignedTo: $assignedTo, createdAt: $createdAt, updatedAt: $updatedAt, description: $description)';
}


}

/// @nodoc
abstract mixin class _$TaskResponseCopyWith<$Res> implements $TaskResponseCopyWith<$Res> {
  factory _$TaskResponseCopyWith(_TaskResponse value, $Res Function(_TaskResponse) _then) = __$TaskResponseCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: '_id') String id, String title, List<TaskChecklistItem> checklist, TaskPriority priority, TaskStatus status, DateTime dueDate, bool completed, String group, UserResponse owner, List<UserResponse> assignedTo, DateTime createdAt, DateTime updatedAt, String? description
});


@override $UserResponseCopyWith<$Res> get owner;

}
/// @nodoc
class __$TaskResponseCopyWithImpl<$Res>
    implements _$TaskResponseCopyWith<$Res> {
  __$TaskResponseCopyWithImpl(this._self, this._then);

  final _TaskResponse _self;
  final $Res Function(_TaskResponse) _then;

/// Create a copy of TaskResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? checklist = null,Object? priority = null,Object? status = null,Object? dueDate = null,Object? completed = null,Object? group = null,Object? owner = null,Object? assignedTo = null,Object? createdAt = null,Object? updatedAt = null,Object? description = freezed,}) {
  return _then(_TaskResponse(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,checklist: null == checklist ? _self._checklist : checklist // ignore: cast_nullable_to_non_nullable
as List<TaskChecklistItem>,priority: null == priority ? _self.priority : priority // ignore: cast_nullable_to_non_nullable
as TaskPriority,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as TaskStatus,dueDate: null == dueDate ? _self.dueDate : dueDate // ignore: cast_nullable_to_non_nullable
as DateTime,completed: null == completed ? _self.completed : completed // ignore: cast_nullable_to_non_nullable
as bool,group: null == group ? _self.group : group // ignore: cast_nullable_to_non_nullable
as String,owner: null == owner ? _self.owner : owner // ignore: cast_nullable_to_non_nullable
as UserResponse,assignedTo: null == assignedTo ? _self._assignedTo : assignedTo // ignore: cast_nullable_to_non_nullable
as List<UserResponse>,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of TaskResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserResponseCopyWith<$Res> get owner {
  
  return $UserResponseCopyWith<$Res>(_self.owner, (value) {
    return _then(_self.copyWith(owner: value));
  });
}
}


/// @nodoc
mixin _$TaskChecklistItem {

@JsonKey(name: '_id') String get id; String get title; TaskChecklistItemStatus get status; int get order;
/// Create a copy of TaskChecklistItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TaskChecklistItemCopyWith<TaskChecklistItem> get copyWith => _$TaskChecklistItemCopyWithImpl<TaskChecklistItem>(this as TaskChecklistItem, _$identity);

  /// Serializes this TaskChecklistItem to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TaskChecklistItem&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.status, status) || other.status == status)&&(identical(other.order, order) || other.order == order));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,status,order);

@override
String toString() {
  return 'TaskChecklistItem(id: $id, title: $title, status: $status, order: $order)';
}


}

/// @nodoc
abstract mixin class $TaskChecklistItemCopyWith<$Res>  {
  factory $TaskChecklistItemCopyWith(TaskChecklistItem value, $Res Function(TaskChecklistItem) _then) = _$TaskChecklistItemCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: '_id') String id, String title, TaskChecklistItemStatus status, int order
});




}
/// @nodoc
class _$TaskChecklistItemCopyWithImpl<$Res>
    implements $TaskChecklistItemCopyWith<$Res> {
  _$TaskChecklistItemCopyWithImpl(this._self, this._then);

  final TaskChecklistItem _self;
  final $Res Function(TaskChecklistItem) _then;

/// Create a copy of TaskChecklistItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? status = null,Object? order = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as TaskChecklistItemStatus,order: null == order ? _self.order : order // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _TaskChecklistItem extends TaskChecklistItem {
  const _TaskChecklistItem({@JsonKey(name: '_id') required this.id, required this.title, required this.status, required this.order}): super._();
  factory _TaskChecklistItem.fromJson(Map<String, dynamic> json) => _$TaskChecklistItemFromJson(json);

@override@JsonKey(name: '_id') final  String id;
@override final  String title;
@override final  TaskChecklistItemStatus status;
@override final  int order;

/// Create a copy of TaskChecklistItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TaskChecklistItemCopyWith<_TaskChecklistItem> get copyWith => __$TaskChecklistItemCopyWithImpl<_TaskChecklistItem>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TaskChecklistItemToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TaskChecklistItem&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.status, status) || other.status == status)&&(identical(other.order, order) || other.order == order));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,status,order);

@override
String toString() {
  return 'TaskChecklistItem(id: $id, title: $title, status: $status, order: $order)';
}


}

/// @nodoc
abstract mixin class _$TaskChecklistItemCopyWith<$Res> implements $TaskChecklistItemCopyWith<$Res> {
  factory _$TaskChecklistItemCopyWith(_TaskChecklistItem value, $Res Function(_TaskChecklistItem) _then) = __$TaskChecklistItemCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: '_id') String id, String title, TaskChecklistItemStatus status, int order
});




}
/// @nodoc
class __$TaskChecklistItemCopyWithImpl<$Res>
    implements _$TaskChecklistItemCopyWith<$Res> {
  __$TaskChecklistItemCopyWithImpl(this._self, this._then);

  final _TaskChecklistItem _self;
  final $Res Function(_TaskChecklistItem) _then;

/// Create a copy of TaskChecklistItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? status = null,Object? order = null,}) {
  return _then(_TaskChecklistItem(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as TaskChecklistItemStatus,order: null == order ? _self.order : order // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
