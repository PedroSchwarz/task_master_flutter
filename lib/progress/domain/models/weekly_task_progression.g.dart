// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weekly_task_progression.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_WeeklyTaskProgression _$WeeklyTaskProgressionFromJson(
  Map<String, dynamic> json,
) => _WeeklyTaskProgression(
  week: (json['week'] as num).toInt(),
  startDate: DateTime.parse(json['startDate'] as String),
  endDate: DateTime.parse(json['endDate'] as String),
  completed: (json['completed'] as num).toInt(),
  total: (json['total'] as num).toInt(),
  overdue: (json['overdue'] as num).toInt(),
  tasks:
      (json['tasks'] as List<dynamic>)
          .map(
            (e) => SimplifiedTaskResponse.fromJson(e as Map<String, dynamic>),
          )
          .toList(),
);

Map<String, dynamic> _$WeeklyTaskProgressionToJson(
  _WeeklyTaskProgression instance,
) => <String, dynamic>{
  'week': instance.week,
  'startDate': instance.startDate.toIso8601String(),
  'endDate': instance.endDate.toIso8601String(),
  'completed': instance.completed,
  'total': instance.total,
  'overdue': instance.overdue,
  'tasks': instance.tasks,
};
