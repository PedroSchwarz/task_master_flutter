// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'simplified_task_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SimplifiedTaskResponse _$SimplifiedTaskResponseFromJson(
  Map<String, dynamic> json,
) => _SimplifiedTaskResponse(
  id: json['_id'] as String,
  priority: $enumDecode(_$TaskPriorityEnumMap, json['priority']),
  status: $enumDecode(_$TaskStatusEnumMap, json['status']),
  dueDate: DateTime.parse(json['dueDate'] as String),
  completed: json['completed'] as bool,
  createdAt: DateTime.parse(json['createdAt'] as String),
  description: json['description'] as String?,
);

Map<String, dynamic> _$SimplifiedTaskResponseToJson(
  _SimplifiedTaskResponse instance,
) => <String, dynamic>{
  '_id': instance.id,
  'priority': _$TaskPriorityEnumMap[instance.priority]!,
  'status': _$TaskStatusEnumMap[instance.status]!,
  'dueDate': instance.dueDate.toIso8601String(),
  'completed': instance.completed,
  'createdAt': instance.createdAt.toIso8601String(),
  'description': instance.description,
};

const _$TaskPriorityEnumMap = {
  TaskPriority.low: 'low',
  TaskPriority.medium: 'medium',
  TaskPriority.high: 'high',
};

const _$TaskStatusEnumMap = {
  TaskStatus.todo: 'todo',
  TaskStatus.inProgress: 'in_progress',
  TaskStatus.done: 'done',
};
