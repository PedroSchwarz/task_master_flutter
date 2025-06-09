// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TaskResponse _$TaskResponseFromJson(Map<String, dynamic> json) =>
    _TaskResponse(
      id: json['_id'] as String,
      title: json['title'] as String,
      checklist:
          (json['checklist'] as List<dynamic>)
              .map((e) => TaskChecklistItem.fromJson(e as Map<String, dynamic>))
              .toList(),
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
      recurring: json['recurring'] as bool,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      description: json['description'] as String?,
      recurrencePattern: $enumDecodeNullable(
        _$TaskRecurrenceEnumMap,
        json['recurrencePattern'],
      ),
      recurrenceEndDate:
          json['recurrenceEndDate'] == null
              ? null
              : DateTime.parse(json['recurrenceEndDate'] as String),
    );

Map<String, dynamic> _$TaskResponseToJson(_TaskResponse instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'title': instance.title,
      'checklist': instance.checklist,
      'priority': _$TaskPriorityEnumMap[instance.priority]!,
      'status': _$TaskStatusEnumMap[instance.status]!,
      'dueDate': instance.dueDate.toIso8601String(),
      'completed': instance.completed,
      'group': instance.group,
      'owner': instance.owner,
      'assignedTo': instance.assignedTo,
      'recurring': instance.recurring,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'description': instance.description,
      'recurrencePattern': _$TaskRecurrenceEnumMap[instance.recurrencePattern],
      'recurrenceEndDate': instance.recurrenceEndDate?.toIso8601String(),
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

const _$TaskRecurrenceEnumMap = {
  TaskRecurrence.daily: 'daily',
  TaskRecurrence.weekly: 'weekly',
  TaskRecurrence.monthly: 'monthly',
};

_TaskChecklistItem _$TaskChecklistItemFromJson(Map<String, dynamic> json) =>
    _TaskChecklistItem(
      id: json['_id'] as String,
      title: json['title'] as String,
      status: $enumDecode(_$TaskChecklistItemStatusEnumMap, json['status']),
      order: (json['order'] as num).toInt(),
    );

Map<String, dynamic> _$TaskChecklistItemToJson(_TaskChecklistItem instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'title': instance.title,
      'status': _$TaskChecklistItemStatusEnumMap[instance.status]!,
      'order': instance.order,
    };

const _$TaskChecklistItemStatusEnumMap = {
  TaskChecklistItemStatus.incomplete: 'incomplete',
  TaskChecklistItemStatus.completed: 'completed',
  TaskChecklistItemStatus.blocked: 'blocked',
};
