// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'simplified_task_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SimplifiedTaskResponse {

@JsonKey(name: '_id') String get id; TaskPriority get priority; TaskStatus get status; DateTime get dueDate; bool get completed; DateTime get createdAt; String? get description;
/// Create a copy of SimplifiedTaskResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SimplifiedTaskResponseCopyWith<SimplifiedTaskResponse> get copyWith => _$SimplifiedTaskResponseCopyWithImpl<SimplifiedTaskResponse>(this as SimplifiedTaskResponse, _$identity);

  /// Serializes this SimplifiedTaskResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SimplifiedTaskResponse&&(identical(other.id, id) || other.id == id)&&(identical(other.priority, priority) || other.priority == priority)&&(identical(other.status, status) || other.status == status)&&(identical(other.dueDate, dueDate) || other.dueDate == dueDate)&&(identical(other.completed, completed) || other.completed == completed)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.description, description) || other.description == description));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,priority,status,dueDate,completed,createdAt,description);

@override
String toString() {
  return 'SimplifiedTaskResponse(id: $id, priority: $priority, status: $status, dueDate: $dueDate, completed: $completed, createdAt: $createdAt, description: $description)';
}


}

/// @nodoc
abstract mixin class $SimplifiedTaskResponseCopyWith<$Res>  {
  factory $SimplifiedTaskResponseCopyWith(SimplifiedTaskResponse value, $Res Function(SimplifiedTaskResponse) _then) = _$SimplifiedTaskResponseCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: '_id') String id, TaskPriority priority, TaskStatus status, DateTime dueDate, bool completed, DateTime createdAt, String? description
});




}
/// @nodoc
class _$SimplifiedTaskResponseCopyWithImpl<$Res>
    implements $SimplifiedTaskResponseCopyWith<$Res> {
  _$SimplifiedTaskResponseCopyWithImpl(this._self, this._then);

  final SimplifiedTaskResponse _self;
  final $Res Function(SimplifiedTaskResponse) _then;

/// Create a copy of SimplifiedTaskResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? priority = null,Object? status = null,Object? dueDate = null,Object? completed = null,Object? createdAt = null,Object? description = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,priority: null == priority ? _self.priority : priority // ignore: cast_nullable_to_non_nullable
as TaskPriority,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as TaskStatus,dueDate: null == dueDate ? _self.dueDate : dueDate // ignore: cast_nullable_to_non_nullable
as DateTime,completed: null == completed ? _self.completed : completed // ignore: cast_nullable_to_non_nullable
as bool,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _SimplifiedTaskResponse extends SimplifiedTaskResponse {
  const _SimplifiedTaskResponse({@JsonKey(name: '_id') required this.id, required this.priority, required this.status, required this.dueDate, required this.completed, required this.createdAt, this.description}): super._();
  factory _SimplifiedTaskResponse.fromJson(Map<String, dynamic> json) => _$SimplifiedTaskResponseFromJson(json);

@override@JsonKey(name: '_id') final  String id;
@override final  TaskPriority priority;
@override final  TaskStatus status;
@override final  DateTime dueDate;
@override final  bool completed;
@override final  DateTime createdAt;
@override final  String? description;

/// Create a copy of SimplifiedTaskResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SimplifiedTaskResponseCopyWith<_SimplifiedTaskResponse> get copyWith => __$SimplifiedTaskResponseCopyWithImpl<_SimplifiedTaskResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SimplifiedTaskResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SimplifiedTaskResponse&&(identical(other.id, id) || other.id == id)&&(identical(other.priority, priority) || other.priority == priority)&&(identical(other.status, status) || other.status == status)&&(identical(other.dueDate, dueDate) || other.dueDate == dueDate)&&(identical(other.completed, completed) || other.completed == completed)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.description, description) || other.description == description));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,priority,status,dueDate,completed,createdAt,description);

@override
String toString() {
  return 'SimplifiedTaskResponse(id: $id, priority: $priority, status: $status, dueDate: $dueDate, completed: $completed, createdAt: $createdAt, description: $description)';
}


}

/// @nodoc
abstract mixin class _$SimplifiedTaskResponseCopyWith<$Res> implements $SimplifiedTaskResponseCopyWith<$Res> {
  factory _$SimplifiedTaskResponseCopyWith(_SimplifiedTaskResponse value, $Res Function(_SimplifiedTaskResponse) _then) = __$SimplifiedTaskResponseCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: '_id') String id, TaskPriority priority, TaskStatus status, DateTime dueDate, bool completed, DateTime createdAt, String? description
});




}
/// @nodoc
class __$SimplifiedTaskResponseCopyWithImpl<$Res>
    implements _$SimplifiedTaskResponseCopyWith<$Res> {
  __$SimplifiedTaskResponseCopyWithImpl(this._self, this._then);

  final _SimplifiedTaskResponse _self;
  final $Res Function(_SimplifiedTaskResponse) _then;

/// Create a copy of SimplifiedTaskResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? priority = null,Object? status = null,Object? dueDate = null,Object? completed = null,Object? createdAt = null,Object? description = freezed,}) {
  return _then(_SimplifiedTaskResponse(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,priority: null == priority ? _self.priority : priority // ignore: cast_nullable_to_non_nullable
as TaskPriority,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as TaskStatus,dueDate: null == dueDate ? _self.dueDate : dueDate // ignore: cast_nullable_to_non_nullable
as DateTime,completed: null == completed ? _self.completed : completed // ignore: cast_nullable_to_non_nullable
as bool,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
