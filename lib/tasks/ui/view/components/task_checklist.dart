import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:gap/gap.dart';
import 'package:task_master/app/app.dart';
import 'package:task_master/tasks/data/models/task_response.dart';

class TaskChecklist extends StatelessWidget {
  const TaskChecklist({
    required this.isLoading,
    required this.task,
    required this.onReorder,
    required this.onStatusChanged,
    super.key,
  });

  final bool isLoading;
  final TaskResponse? task;
  final void Function(int, int) onReorder;
  final Future<void> Function(TaskChecklistItem, int, TaskChecklistItemStatus)
  onStatusChanged;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final localization = context.localization;

    if (isLoading || task == null) {
      return const Padding(
        padding: .only(top: AppSpacing.s),
        child: AppSkeleton(
          isLoading: true,
          child: SizedBox(height: 150, width: .infinity),
        ),
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
          padding: const .only(top: AppSpacing.s, bottom: 0),
          shrinkWrap: true,
          itemCount: checklist.length,
          onReorder: onReorder,
          header: Padding(
            padding: const .only(bottom: AppSpacing.s),
            child: Row(
              mainAxisAlignment: .spaceBetween,
              children: [
                Text(localization.checklist, style: theme.textTheme.bodyLarge),
                SizedBox(
                  width: 24,
                  height: 24,
                  child: AnimatedCircularProgressIndicator(
                    value: task!.checklistProgression,
                    color: theme.colorScheme.primary,
                  ),
                ),
              ],
            ),
          ),
          proxyDecorator: (child, index, animation) {
            return Material(
              elevation: AppSpacing.xxs,
              color: theme.colorScheme.surfaceContainer,
              shadowColor: Colors.black45,
              borderRadius: .circular(AppSpacing.s),
              child: child,
            );
          },
          itemBuilder: (context, position) {
            final item = checklist[position];
            return ListTile(
              key: ValueKey(item.id),
              contentPadding: .zero,
              leading: SizedBox(
                height: 24,
                width: 24,
                child: Checkbox(
                  value: item.status == .completed,
                  onChanged: item.status == .blocked
                      ? null
                      : (_) {
                          onStatusChanged(
                            item,
                            position,
                            item.status == .completed
                                ? .incomplete
                                : .completed,
                          );
                        },
                  shape: RoundedRectangleBorder(
                    borderRadius: .circular(100),
                  ),
                ),
              ),
              title: Text(
                item.title,
                style: TextStyle(
                  color: theme.colorScheme.onSurface.withValues(
                    alpha: item.status == .blocked ? 0.5 : 1,
                  ),
                  decoration: item.status == .blocked
                      ? TextDecoration.lineThrough
                      : null,
                  decorationColor: Colors.orange.withValues(alpha: 0.5),
                  decorationThickness: 4,
                ),
              ),
              trailing: Row(
                mainAxisSize: .min,
                children: [
                  IconButton(
                    color: Colors.orange,
                    onPressed: item.status == .completed
                        ? null
                        : () {
                            onStatusChanged(
                              item,
                              position,
                              item.status == .blocked ? .incomplete : .blocked,
                            );
                          },
                    icon: Icon(
                      item.status == .blocked
                          ? Icons.lock_open_outlined
                          : Icons.lock_outline,
                    ),
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
