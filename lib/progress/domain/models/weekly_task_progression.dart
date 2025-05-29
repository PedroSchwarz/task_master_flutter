import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:task_master/tasks/tasks.dart';

part 'weekly_task_progression.freezed.dart';
part 'weekly_task_progression.g.dart';

@freezed
abstract class WeeklyTaskProgression with _$WeeklyTaskProgression {
  const factory WeeklyTaskProgression({
    required int week,
    required DateTime startDate,
    required DateTime endDate,
    required int completed,
    required int total,
    required int overdue,
    required List<SimplifiedTaskResponse> tasks,
  }) = _WeeklyTaskProgression;

  const WeeklyTaskProgression._();

  factory WeeklyTaskProgression.fromJson(Map<String, dynamic> json) => _$WeeklyTaskProgressionFromJson(json);

  List<String> get taskIds => tasks.map((task) => task.id).toList();

  double get completionPercentage => total == 0 ? 0 : completed / total;

  double get overduePercentage => total == 0 ? 0 : overdue / total;

  Color get completionColor {
    if (completionPercentage >= 0.0 && completionPercentage < 0.25) {
      return Colors.red;
    } else if (completionPercentage >= 0.25 && completionPercentage < 0.5) {
      return Colors.orange;
    } else if (completionPercentage >= 0.5 && completionPercentage < 0.75) {
      return Colors.blue;
    } else if (completionPercentage >= 0.75 && completionPercentage < 1) {
      return Colors.lightGreen;
    } else {
      return Colors.green;
    }
  }
}
