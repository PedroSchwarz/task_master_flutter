// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'create_task_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CreateTaskRequest {

 String get title; DateTime get dueDate; String get group;@JsonKey(includeIfNull: false) String? get description;@JsonKey(includeIfNull: false) TaskPriority? get priority;@JsonKey(includeIfNull: false) TaskStatus? get status;@JsonKey(includeIfNull: false) List<String>? get assignedTo;
/// Create a copy of CreateTaskRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CreateTaskRequestCopyWith<CreateTaskRequest> get copyWith => _$CreateTaskRequestCopyWithImpl<CreateTaskRequest>(this as CreateTaskRequest, _$identity);

  /// Serializes this CreateTaskRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CreateTaskRequest&&(identical(other.title, title) || other.title == title)&&(identical(other.dueDate, dueDate) || other.dueDate == dueDate)&&(identical(other.group, group) || other.group == group)&&(identical(other.description, description) || other.description == description)&&(identical(other.priority, priority) || other.priority == priority)&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other.assignedTo, assignedTo));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,title,dueDate,group,description,priority,status,const DeepCollectionEquality().hash(assignedTo));

@override
String toString() {
  return 'CreateTaskRequest(title: $title, dueDate: $dueDate, group: $group, description: $description, priority: $priority, status: $status, assignedTo: $assignedTo)';
}


}

/// @nodoc
abstract mixin class $CreateTaskRequestCopyWith<$Res>  {
  factory $CreateTaskRequestCopyWith(CreateTaskRequest value, $Res Function(CreateTaskRequest) _then) = _$CreateTaskRequestCopyWithImpl;
@useResult
$Res call({
 String title, DateTime dueDate, String group,@JsonKey(includeIfNull: false) String? description,@JsonKey(includeIfNull: false) TaskPriority? priority,@JsonKey(includeIfNull: false) TaskStatus? status,@JsonKey(includeIfNull: false) List<String>? assignedTo
});




}
/// @nodoc
class _$CreateTaskRequestCopyWithImpl<$Res>
    implements $CreateTaskRequestCopyWith<$Res> {
  _$CreateTaskRequestCopyWithImpl(this._self, this._then);

  final CreateTaskRequest _self;
  final $Res Function(CreateTaskRequest) _then;

/// Create a copy of CreateTaskRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? title = null,Object? dueDate = null,Object? group = null,Object? description = freezed,Object? priority = freezed,Object? status = freezed,Object? assignedTo = freezed,}) {
  return _then(_self.copyWith(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,dueDate: null == dueDate ? _self.dueDate : dueDate // ignore: cast_nullable_to_non_nullable
as DateTime,group: null == group ? _self.group : group // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,priority: freezed == priority ? _self.priority : priority // ignore: cast_nullable_to_non_nullable
as TaskPriority?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as TaskStatus?,assignedTo: freezed == assignedTo ? _self.assignedTo : assignedTo // ignore: cast_nullable_to_non_nullable
as List<String>?,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _CreateTaskRequest implements CreateTaskRequest {
  const _CreateTaskRequest({required this.title, required this.dueDate, required this.group, @JsonKey(includeIfNull: false) this.description, @JsonKey(includeIfNull: false) this.priority, @JsonKey(includeIfNull: false) this.status, @JsonKey(includeIfNull: false) final  List<String>? assignedTo}): _assignedTo = assignedTo;
  factory _CreateTaskRequest.fromJson(Map<String, dynamic> json) => _$CreateTaskRequestFromJson(json);

@override final  String title;
@override final  DateTime dueDate;
@override final  String group;
@override@JsonKey(includeIfNull: false) final  String? description;
@override@JsonKey(includeIfNull: false) final  TaskPriority? priority;
@override@JsonKey(includeIfNull: false) final  TaskStatus? status;
 final  List<String>? _assignedTo;
@override@JsonKey(includeIfNull: false) List<String>? get assignedTo {
  final value = _assignedTo;
  if (value == null) return null;
  if (_assignedTo is EqualUnmodifiableListView) return _assignedTo;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}


/// Create a copy of CreateTaskRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CreateTaskRequestCopyWith<_CreateTaskRequest> get copyWith => __$CreateTaskRequestCopyWithImpl<_CreateTaskRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CreateTaskRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CreateTaskRequest&&(identical(other.title, title) || other.title == title)&&(identical(other.dueDate, dueDate) || other.dueDate == dueDate)&&(identical(other.group, group) || other.group == group)&&(identical(other.description, description) || other.description == description)&&(identical(other.priority, priority) || other.priority == priority)&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other._assignedTo, _assignedTo));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,title,dueDate,group,description,priority,status,const DeepCollectionEquality().hash(_assignedTo));

@override
String toString() {
  return 'CreateTaskRequest(title: $title, dueDate: $dueDate, group: $group, description: $description, priority: $priority, status: $status, assignedTo: $assignedTo)';
}


}

/// @nodoc
abstract mixin class _$CreateTaskRequestCopyWith<$Res> implements $CreateTaskRequestCopyWith<$Res> {
  factory _$CreateTaskRequestCopyWith(_CreateTaskRequest value, $Res Function(_CreateTaskRequest) _then) = __$CreateTaskRequestCopyWithImpl;
@override @useResult
$Res call({
 String title, DateTime dueDate, String group,@JsonKey(includeIfNull: false) String? description,@JsonKey(includeIfNull: false) TaskPriority? priority,@JsonKey(includeIfNull: false) TaskStatus? status,@JsonKey(includeIfNull: false) List<String>? assignedTo
});




}
/// @nodoc
class __$CreateTaskRequestCopyWithImpl<$Res>
    implements _$CreateTaskRequestCopyWith<$Res> {
  __$CreateTaskRequestCopyWithImpl(this._self, this._then);

  final _CreateTaskRequest _self;
  final $Res Function(_CreateTaskRequest) _then;

/// Create a copy of CreateTaskRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? title = null,Object? dueDate = null,Object? group = null,Object? description = freezed,Object? priority = freezed,Object? status = freezed,Object? assignedTo = freezed,}) {
  return _then(_CreateTaskRequest(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,dueDate: null == dueDate ? _self.dueDate : dueDate // ignore: cast_nullable_to_non_nullable
as DateTime,group: null == group ? _self.group : group // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,priority: freezed == priority ? _self.priority : priority // ignore: cast_nullable_to_non_nullable
as TaskPriority?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as TaskStatus?,assignedTo: freezed == assignedTo ? _self._assignedTo : assignedTo // ignore: cast_nullable_to_non_nullable
as List<String>?,
  ));
}


}

// dart format on
