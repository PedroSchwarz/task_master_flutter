import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:task_master/app/design_system/theme/app_spacing.dart';
import 'package:task_master/tasks/data/models/task_response.dart';

class TaskItem extends StatelessWidget {
  const TaskItem({required this.task, required this.onTap, required this.onComplete, required this.onPending, required this.onDelete, super.key});

  final TaskResponse task;
  final VoidCallback onTap;
  final Future<bool> Function() onComplete;
  final Future<bool> Function() onPending;
  final Future<bool> Function() onDelete;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Dismissible(
      key: Key(task.title),
      dismissThresholds: const {DismissDirection.endToStart: 0.5, DismissDirection.startToEnd: 0.6},
      background: Container(
        padding: const EdgeInsets.all(AppSpacing.m),
        alignment: Alignment.centerLeft,
        decoration: const BoxDecoration(color: Colors.red),
        child: Column(
          spacing: AppSpacing.xxxs,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.delete_outline, color: Colors.white, size: 32),
            Text('Delete', style: theme.textTheme.titleMedium?.copyWith(color: Colors.white)),
          ],
        ),
      ),
      secondaryBackground: Container(
        padding: const EdgeInsets.all(AppSpacing.m),
        alignment: Alignment.centerRight,
        decoration: BoxDecoration(color: task.completed ? Colors.purple : Colors.green),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(task.completed ? Icons.close : Icons.check, color: Colors.white, size: 32),
            Text(task.completed ? 'Pending' : 'Complete', style: theme.textTheme.titleMedium?.copyWith(color: Colors.white)),
          ],
        ),
      ),
      confirmDismiss: (direction) async {
        if (direction == DismissDirection.endToStart) {
          if (task.completed) {
            return onPending();
          } else {
            return onComplete();
          }
        } else {
          return onDelete();
        }
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(task.title, style: theme.textTheme.titleLarge),
                      Text(task.description ?? 'No description', style: theme.textTheme.bodyLarge, maxLines: 2, overflow: TextOverflow.ellipsis),
                      const Gap(AppSpacing.xs),
                      Row(
                        spacing: AppSpacing.xxs,
                        children: [const Icon(Icons.watch_later), Flexible(child: Text(task.formattedDueDate, style: theme.textTheme.labelLarge))],
                      ),
                      Chip(
                        label: Text(task.status.title, style: theme.textTheme.bodySmall?.copyWith(color: Colors.white, fontWeight: FontWeight.bold)),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
                        padding: const EdgeInsets.all(AppSpacing.xxxs),
                        backgroundColor: task.status.color.withValues(alpha: 0.8),
                        side: BorderSide(color: task.status.color, width: 3),
                      ),
                    ],
                  ),
                ),
                Stack(
                  children:
                      task.assignedTo.indexed.map((item) {
                        final index = item.$1;
                        final assignee = item.$2;

                        return Transform.translate(
                          offset: Offset(index * 10, 0),
                          child: CircleAvatar(
                            child: Text(
                              '${assignee.firstName.substring(0, 1)}${assignee.lastName.substring(0, 1)}',
                              style: theme.textTheme.titleMedium,
                            ),
                          ),
                        );
                      }).toList(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
