// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_task_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CreateTaskRequest _$CreateTaskRequestFromJson(Map<String, dynamic> json) =>
    _CreateTaskRequest(
      title: json['title'] as String,
      dueDate: DateTime.parse(json['dueDate'] as String),
      group: json['group'] as String,
      checklist: (json['checklist'] as List<dynamic>)
          .map(
            (e) => CreateTaskChecklistItem.fromJson(e as Map<String, dynamic>),
          )
          .toList(),
      recurring: json['recurring'] as bool,
      description: json['description'] as String?,
      priority: $enumDecodeNullable(_$TaskPriorityEnumMap, json['priority']),
      status: $enumDecodeNullable(_$TaskStatusEnumMap, json['status']),
      assignedTo: (json['assignedTo'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      recurrencePattern: $enumDecodeNullable(
        _$TaskRecurrenceEnumMap,
        json['recurrencePattern'],
      ),
      recurrenceEndDate: json['recurrenceEndDate'] == null
          ? null
          : DateTime.parse(json['recurrenceEndDate'] as String),
    );

Map<String, dynamic> _$CreateTaskRequestToJson(_CreateTaskRequest instance) =>
    <String, dynamic>{
      'title': instance.title,
      'dueDate': instance.dueDate.toIso8601String(),
      'group': instance.group,
      'checklist': instance.checklist,
      'recurring': instance.recurring,
      'description': ?instance.description,
      'priority': ?_$TaskPriorityEnumMap[instance.priority],
      'status': ?_$TaskStatusEnumMap[instance.status],
      'assignedTo': ?instance.assignedTo,
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

_CreateTaskChecklistItem _$CreateTaskChecklistItemFromJson(
  Map<String, dynamic> json,
) => _CreateTaskChecklistItem(
  title: json['title'] as String,
  order: (json['order'] as num).toInt(),
);

Map<String, dynamic> _$CreateTaskChecklistItemToJson(
  _CreateTaskChecklistItem instance,
) => <String, dynamic>{'title': instance.title, 'order': instance.order};
