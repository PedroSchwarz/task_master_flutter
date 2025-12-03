import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:task_master/app/design_system/theme/app_spacing.dart';
import 'package:task_master/app/extensions/build_context_extensions.dart';
import 'package:task_master/tasks/tasks.dart';

class UpcomingTasksListSheet extends StatelessWidget {
  const UpcomingTasksListSheet({required this.tasks, super.key});

  final List<TaskResponse> tasks;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final localization = context.localization;

    return ElevatedButton(
      onPressed: tasks.isEmpty
          ? null
          : () {
              showModalBottomSheet(
                context: context,
                useSafeArea: true,
                showDragHandle: true,
                scrollControlDisabledMaxHeightRatio: 0.9,
                builder: (context) {
                  if (tasks.isEmpty && context.canPop()) {
                    context.pop();
                  }

                  return ListView.separated(
                    itemCount: tasks.length,
                    itemBuilder: (_, position) {
                      final task = tasks[position];
                      return SimplifiedTaskItem(
                        task: task,
                        position: position,
                        onTap: () {
                          context.goNamed(
                            TaskDetailsScreen.routeName,
                            pathParameters: {
                              'id': task.group,
                              'taskId': task.id,
                            },
                          );
                        },
                      );
                    },
                    separatorBuilder: (_, _) => const Divider(),
                  );
                },
              );
            },
      style: ElevatedButton.styleFrom(
        backgroundColor: theme.colorScheme.primaryContainer,
        shape: RoundedRectangleBorder(
          borderRadius: .circular(AppSpacing.xs),
        ),
        textStyle: theme.textTheme.titleMedium,
        foregroundColor: theme.colorScheme.onPrimaryContainer,
        padding: const .all(AppSpacing.m),
      ),
      child: Text(localization.dashboard_upcoming_tasks),
    ).animate().fade(delay: 150.ms);
  }
}
