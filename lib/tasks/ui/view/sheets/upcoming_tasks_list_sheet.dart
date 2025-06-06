import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:task_master/app/design_system/theme/app_spacing.dart';
import 'package:task_master/app/extensions/build_context_extensions.dart';
import 'package:task_master/tasks/tasks.dart';

class UpcomingTasksListSheet extends StatefulWidget {
  const UpcomingTasksListSheet({required this.tasks, super.key});

  final List<TaskResponse> tasks;

  @override
  State<UpcomingTasksListSheet> createState() => _UpcomingTasksListSheetState();
}

class _UpcomingTasksListSheetState extends State<UpcomingTasksListSheet> with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = BottomSheet.createAnimationController(this);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final localization = context.localization;

    return ElevatedButton(
      onPressed:
          widget.tasks.isEmpty
              ? null
              : () {
                showModalBottomSheet(
                  context: context,
                  useSafeArea: true,
                  scrollControlDisabledMaxHeightRatio: 0.9,
                  builder: (_) {
                    return BottomSheet(
                      clipBehavior: Clip.antiAlias,
                      showDragHandle: true,
                      animationController: _animationController,
                      onClosing: () {},
                      builder: (_) {
                        return ListView.separated(
                          itemCount: widget.tasks.length,
                          itemBuilder: (_, position) {
                            final task = widget.tasks[position];
                            return SimplifiedTaskItem(
                              task: task,
                              position: position,
                              onTap: () {
                                context.goNamed(TaskDetailsScreen.routeName, pathParameters: {'id': task.group, 'taskId': task.id});
                              },
                            );
                          },
                          separatorBuilder: (_, __) => const Divider(),
                        );
                      },
                    );
                  },
                );
              },
      style: ElevatedButton.styleFrom(
        backgroundColor: theme.colorScheme.primaryContainer,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppSpacing.s)),
        textStyle: theme.textTheme.titleMedium,
        foregroundColor: theme.colorScheme.onPrimaryContainer,
        padding: const EdgeInsets.all(AppSpacing.m),
      ),
      child: Text(localization.dashboard_upcoming_tasks),
    ).animate().fade(delay: 200.ms);
  }
}
