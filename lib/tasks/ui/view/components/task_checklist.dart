import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:gap/gap.dart';
import 'package:task_master/app/app.dart';
import 'package:task_master/tasks/data/models/task_response.dart';

class TaskChecklist extends StatelessWidget {
  const TaskChecklist({required this.isLoading, required this.task, required this.onReorder, required this.onStatusChanged, super.key});

  final bool isLoading;
  final TaskResponse? task;
  final void Function(int, int) onReorder;
  final Future<void> Function(TaskChecklistItem, int, TaskChecklistItemStatus) onStatusChanged;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final localization = context.localization;

    if (isLoading || task == null) {
      return const Padding(
        padding: EdgeInsets.only(top: AppSpacing.s),
        child: AppSkeleton(isLoading: true, child: SizedBox(height: 150, width: double.infinity)),
      );
    }

    final checklist = task!.checklist;

    if (checklist.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      children: [
        const Gap(AppSpacing.s),
        const Divider(),
        ReorderableListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.only(top: AppSpacing.s, bottom: 0),
          shrinkWrap: true,
          itemCount: checklist.length,
          onReorder: onReorder,
          header: Padding(
            padding: const EdgeInsets.only(bottom: AppSpacing.s),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(localization.checklist, style: theme.textTheme.bodyLarge),
                SizedBox(
                  width: 24,
                  height: 24,
                  child: AnimatedCircularProgressIndicator(value: task!.checklistProgression, color: theme.colorScheme.primary),
                ),
              ],
            ),
          ),
          proxyDecorator: (child, index, animation) {
            return Material(
              elevation: AppSpacing.xxs,
              color: theme.colorScheme.surfaceContainer,
              shadowColor: Colors.black45,
              borderRadius: BorderRadius.circular(AppSpacing.s),
              child: child,
            );
          },
          itemBuilder: (context, position) {
            final item = checklist[position];
            return ListTile(
              key: ValueKey(item.id),
              contentPadding: EdgeInsets.zero,
              leading: SizedBox(
                height: 24,
                width: 24,
                child: Checkbox(
                  value: item.status == TaskChecklistItemStatus.completed,
                  onChanged:
                      item.status == TaskChecklistItemStatus.blocked
                          ? null
                          : (_) {
                            onStatusChanged(
                              item,
                              position,
                              item.status == TaskChecklistItemStatus.completed
                                  ? TaskChecklistItemStatus.incomplete
                                  : TaskChecklistItemStatus.completed,
                            );
                          },
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
                ),
              ),
              title: Text(
                item.title,
                style: TextStyle(
                  color: theme.colorScheme.onSurface.withValues(alpha: item.status == TaskChecklistItemStatus.blocked ? 0.5 : 1),
                  decoration: item.status == TaskChecklistItemStatus.blocked ? TextDecoration.lineThrough : null,
                  decorationColor: Colors.orange.withValues(alpha: 0.5),
                  decorationThickness: 4,
                ),
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    color: Colors.orange,
                    onPressed:
                        item.status == TaskChecklistItemStatus.completed
                            ? null
                            : () {
                              onStatusChanged(
                                item,
                                position,
                                item.status == TaskChecklistItemStatus.blocked ? TaskChecklistItemStatus.incomplete : TaskChecklistItemStatus.blocked,
                              );
                            },
                    icon: Icon(item.status == TaskChecklistItemStatus.blocked ? Icons.lock_open_outlined : Icons.lock_outline),
                  ),
                  const Icon(Icons.drag_handle),
                ],
              ),
            );
          },
        ).animate().fade(delay: 250.ms),
      ],
    );
  }
}
