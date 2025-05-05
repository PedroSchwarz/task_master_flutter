// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TaskResponse _$TaskResponseFromJson(Map<String, dynamic> json) =>
    _TaskResponse(
      title: json['title'] as String,
      priority: $enumDecode(_$TaskPriorityEnumMap, json['priority']),
      status: $enumDecode(_$TaskStatusEnumMap, json['status']),
      dueDate: DateTime.parse(json['dueDate'] as String),
      completed: json['completed'] as bool,
      group: json['group'] as String,
      owner: UserResponse.fromJson(json['owner'] as Map<String, dynamic>),
      assignedTo:
          (json['assignedTo'] as List<dynamic>)
              .map((e) => UserResponse.fromJson(e as Map<String, dynamic>))
              .toList(),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      description: json['description'] as String?,
    );

Map<String, dynamic> _$TaskResponseToJson(_TaskResponse instance) =>
    <String, dynamic>{
      'title': instance.title,
      'priority': _$TaskPriorityEnumMap[instance.priority]!,
      'status': _$TaskStatusEnumMap[instance.status]!,
      'dueDate': instance.dueDate.toIso8601String(),
      'completed': instance.completed,
      'group': instance.group,
      'owner': instance.owner,
      'assignedTo': instance.assignedTo,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
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
