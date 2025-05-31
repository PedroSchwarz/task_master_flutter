import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:gap/gap.dart';
import 'package:task_master/app/app.dart';
import 'package:task_master/tasks/data/models/task_response.dart';
import 'package:task_master/tasks/data/models/task_values.dart';

class TaskItem extends StatelessWidget {
  const TaskItem({
    required this.task,
    required this.position,
    required this.canDelete,
    required this.onTap,
    required this.onComplete,
    required this.onPending,
    required this.onDelete,
    super.key,
  });

  final TaskResponse task;
  final int position;
  final bool canDelete;
  final VoidCallback onTap;
  final Future<void> Function(TaskResponse) onComplete;
  final Future<void> Function(TaskResponse) onPending;
  final Future<void> Function(TaskResponse?) onDelete;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final localization = context.localization;

    final assignees = task.assignedTo.sublist(0, min(task.assignedTo.length, 2)).indexed;

    return Dismissible(
      key: Key(task.title),
      direction: canDelete ? DismissDirection.horizontal : DismissDirection.endToStart,
      dismissThresholds: const {DismissDirection.endToStart: 0.5, DismissDirection.startToEnd: 0.6},
      background: Container(
        padding: task.completed ? const EdgeInsets.symmetric(vertical: AppSpacing.s, horizontal: AppSpacing.m) : const EdgeInsets.all(AppSpacing.m),
        alignment: Alignment.centerLeft,
        decoration: const BoxDecoration(color: Colors.red),
        child: Column(
          spacing: AppSpacing.xxxs,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.delete_outline, color: Colors.white, size: 32),
            if (!task.completed) Text(localization.delete, style: theme.textTheme.titleMedium?.copyWith(color: Colors.white)),
          ],
        ),
      ),
      secondaryBackground: Container(
        padding: task.completed ? const EdgeInsets.symmetric(vertical: AppSpacing.s, horizontal: AppSpacing.m) : const EdgeInsets.all(AppSpacing.m),
        alignment: Alignment.centerRight,
        decoration: BoxDecoration(color: task.completed ? Colors.orange : Colors.green),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(task.completed ? Icons.close : Icons.check, color: Colors.white, size: 32),
            if (!task.completed) Text(localization.complete, style: theme.textTheme.titleMedium?.copyWith(color: Colors.white)),
          ],
        ),
      ),
      confirmDismiss: (direction) async {
        HapticFeedback.heavyImpact();
        if (direction == DismissDirection.endToStart) {
          if (task.completed) {
            onPending(task);
          } else {
            onComplete(task);
          }
        } else {
          onDelete(task);
        }

        return false;
      },
      child: InkWell(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(border: Border(left: BorderSide(color: task.priority.color, width: 5))),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s, vertical: AppSpacing.xs),
            child: Row(
              spacing: AppSpacing.s,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (task.completed)
                  Container(
                    padding: const EdgeInsets.all(AppSpacing.xxs),
                    decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: Colors.green, width: 3)),
                    child: const Icon(Icons.check_rounded, color: Colors.green),
                  ),
                Flexible(
                  fit: FlexFit.tight,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(task.title, style: theme.textTheme.titleLarge?.copyWith(color: task.isOverdue ? Colors.red : null)),
                      Text(
                        task.description ?? localization.no_description,
                        style: theme.textTheme.bodyLarge,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),

                      if (!task.completed) ...[
                        const Gap(AppSpacing.xs),
                        Row(
                          spacing: AppSpacing.xxs,
                          children: [
                            if (task.isOverdue) const Icon(Icons.watch_later_outlined, color: Colors.red),
                            Flexible(
                              child: Text(
                                task.formattedDueDate,
                                style: theme.textTheme.labelLarge?.copyWith(color: task.isOverdue ? Colors.red : null),
                              ),
                            ),
                          ],
                        ),
                        const Gap(AppSpacing.xs),
                        Row(
                          spacing: AppSpacing.xs,
                          children: [
                            if (task.isOverdue)
                              Chip(
                                label: Text(
                                  localization.overdue,
                                  style: theme.textTheme.bodyLarge?.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
                                ),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppSpacing.xs)),
                                padding: const EdgeInsets.all(AppSpacing.xxs),
                                backgroundColor: Colors.red,
                                side: BorderSide.none,
                              ),
                            Chip(
                              label: Text(switch (task.status) {
                                TaskStatus.todo => localization.to_do,
                                TaskStatus.inProgress => localization.in_progress,
                                TaskStatus.done => localization.done,
                              }, style: theme.textTheme.bodyMedium?.copyWith(color: Colors.white, fontWeight: FontWeight.bold)),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
                              padding: const EdgeInsets.all(AppSpacing.xs),
                              backgroundColor: task.status.color.withValues(alpha: 0.8),
                              side: BorderSide.none,
                            ),
                          ],
                        ),
                      ],
                    ],
                  ),
                ),
                Stack(
                  children:
                      assignees.map((item) {
                        final index = item.$1;
                        final assignee = item.$2;

                        return Transform.translate(
                          offset: Offset(index * 10, 0),
                          child: CircleAvatar(
                            backgroundColor: assignees.length > 1 && index == 0 ? theme.colorScheme.surfaceContainer : null,
                            child: Text(assignee.initials, style: theme.textTheme.titleMedium),
                          ),
                        );
                      }).toList(),
                ),
              ],
            ),
          ),
        ),
      ),
    ).animate().fade(delay: Duration(milliseconds: min(100 * position, 500)));
  }
}
