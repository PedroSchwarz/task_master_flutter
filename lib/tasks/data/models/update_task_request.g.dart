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
      assignedTo: (json['assignedTo'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      checklist: (json['checklist'] as List<dynamic>)
          .map(
            (e) => UpdateTaskChecklistItem.fromJson(e as Map<String, dynamic>),
          )
          .toList(),
      recurring: json['recurring'] as bool,
      description: json['description'] as String?,
      recurrencePattern: $enumDecodeNullable(
        _$TaskRecurrenceEnumMap,
        json['recurrencePattern'],
      ),
      recurrenceEndDate: json['recurrenceEndDate'] == null
          ? null
          : DateTime.parse(json['recurrenceEndDate'] as String),
    );

Map<String, dynamic> _$UpdateTaskRequestToJson(_UpdateTaskRequest instance) =>
    <String, dynamic>{
      'title': instance.title,
      'dueDate': instance.dueDate.toIso8601String(),
      'priority': _$TaskPriorityEnumMap[instance.priority]!,
      'status': _$TaskStatusEnumMap[instance.status]!,
      'completed': instance.completed,
      'assignedTo': instance.assignedTo,
      'checklist': instance.checklist,
      'recurring': instance.recurring,
      'description': ?instance.description,
      'recurrencePattern': ?_$TaskRecurrenceEnumMap[instance.recurrencePattern],
      'recurrenceEndDate': ?instance.recurrenceEndDate?.toIso8601String(),
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

_UpdateTaskChecklistItem _$UpdateTaskChecklistItemFromJson(
  Map<String, dynamic> json,
) => _UpdateTaskChecklistItem(
  title: json['title'] as String,
  status: $enumDecode(_$TaskChecklistItemStatusEnumMap, json['status']),
  order: (json['order'] as num).toInt(),
);

Map<String, dynamic> _$UpdateTaskChecklistItemToJson(
  _UpdateTaskChecklistItem instance,
) => <String, dynamic>{
  'title': instance.title,
  'status': _$TaskChecklistItemStatusEnumMap[instance.status]!,
  'order': instance.order,
};

const _$TaskChecklistItemStatusEnumMap = {
  TaskChecklistItemStatus.incomplete: 'incomplete',
  TaskChecklistItemStatus.completed: 'completed',
  TaskChecklistItemStatus.blocked: 'blocked',
};
