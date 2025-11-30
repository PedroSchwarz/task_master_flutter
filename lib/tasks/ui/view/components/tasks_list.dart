import 'package:flutter/material.dart';
import 'package:task_master/app/design_system/theme/app_spacing.dart';
import 'package:task_master/tasks/data/models/task_response.dart';
import 'package:task_master/tasks/ui/view/components/task_item.dart';

class TasksList extends StatelessWidget {
  const TasksList({
    required this.tasks,
    required this.currentUserId,
    required this.onPressed,
    required this.onComplete,
    required this.onPending,
    required this.onDelete,
    required this.onRefresh,
    super.key,
  });

  final List<TaskResponse> tasks;
  final String currentUserId;
  final Future<void> Function(TaskResponse) onPressed;
  final Future<void> Function(TaskResponse) onComplete;
  final Future<void> Function(TaskResponse) onPending;
  final Future<void> Function(TaskResponse?) onDelete;
  final RefreshCallback onRefresh;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: onRefresh,
      child: ListView.separated(
        padding: const .only(top: AppSpacing.s, bottom: AppSpacing.max),
        itemCount: tasks.length,
        itemBuilder: (context, position) {
          final task = tasks[position];

          return TaskItem(
            task: task,
            position: position,
            canDelete:
                task.owner.id == currentUserId ||
                task.assignedTo.any((assignee) => assignee.id == currentUserId),
            onTap: () async => await onPressed(task),
            onComplete: onComplete,
            onPending: onPending,
            onDelete: onDelete,
          );
        },
        separatorBuilder: (context, position) => const Divider(),
      ),
    );
  }
}
