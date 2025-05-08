// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_task_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UpdateTaskRequest _$UpdateTaskRequestFromJson(Map<String, dynamic> json) =>
    _UpdateTaskRequest(
      title: json['title'] as String,
      dueDate: DateTime.parse(json['dueDate'] as String),
      priority: $enumDecode(_$TaskPriorityEnumMap, json['priority']),
      status: $enumDecode(_$TaskStatusEnumMap, json['status']),
      completed: json['completed'] as bool,
      assignedTo:
          (json['assignedTo'] as List<dynamic>)
              .map((e) => e as String)
              .toList(),
      description: json['description'] as String?,
    );

Map<String, dynamic> _$UpdateTaskRequestToJson(_UpdateTaskRequest instance) =>
    <String, dynamic>{
      'title': instance.title,
      'dueDate': instance.dueDate.toIso8601String(),
      'priority': _$TaskPriorityEnumMap[instance.priority]!,
      'status': _$TaskStatusEnumMap[instance.status]!,
      'completed': instance.completed,
      'assignedTo': instance.assignedTo,
      if (instance.description case final value?) 'description': value,
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
