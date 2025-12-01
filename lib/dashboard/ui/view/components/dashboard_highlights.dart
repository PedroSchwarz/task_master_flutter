import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:task_master/app/design_system/components/app_skeleton.dart';
import 'package:task_master/app/design_system/theme/app_spacing.dart';
import 'package:task_master/app/extensions/build_context_extensions.dart';
import 'package:task_master/tasks/data/models/task_response.dart';
import 'package:task_master/tasks/ui/view/sheets/overdue_tasks_list_sheet.dart';
import 'package:task_master/tasks/ui/view/sheets/upcoming_tasks_list_sheet.dart';

class DashboardHighlights extends StatelessWidget {
  const DashboardHighlights({
    required this.isLoading,
    required this.upcomingTasks,
    required this.overdueTasks,
    super.key,
  });

  final bool isLoading;
  final List<TaskResponse> upcomingTasks;
  final List<TaskResponse> overdueTasks;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final localization = context.localization;

    return Padding(
      padding: const .all(AppSpacing.s),
      child: Column(
        spacing: AppSpacing.s,
        crossAxisAlignment: .start,
        children: [
          Text(
            localization.dashboard_highlights,
            style: theme.textTheme.titleLarge,
          ).animate().fade(delay: 100.ms),
          Row(
            spacing: AppSpacing.s,
            children: [
              Expanded(
                child: AppSkeleton(
                  isLoading: isLoading,
                  child: UpcomingTasksListSheet(tasks: upcomingTasks),
                ),
              ),
              Expanded(
                child: AppSkeleton(
                  isLoading: isLoading,
                  child: OverdueTasksListSheet(tasks: overdueTasks),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
