import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:task_master/app/design_system/theme/app_spacing.dart';
import 'package:task_master/app/extensions/build_context_extensions.dart';
import 'package:task_master/progress/progress.dart';
import 'package:task_master/progress/ui/view/components/progression_item_chart.dart';
import 'package:task_master/tasks/data/models/task_values.dart';

class ProgressionCarousel extends StatelessWidget {
  const ProgressionCarousel({
    required this.progression,
    required this.height,
    this.onCompletionPressed,
    this.onOverduePressed,
    this.onPriorityPressed,
    this.onStatusPressed,
    super.key,
  });

  final List<WeeklyTaskProgression?> progression;
  final double height;
  final VoidCallback? onCompletionPressed;
  final VoidCallback? onOverduePressed;
  final VoidCallback? onPriorityPressed;
  final VoidCallback? onStatusPressed;

  @override
  Widget build(BuildContext context) {
    final localization = context.localization;

    return SizedBox(
      height: height,
      child: PageView(
        scrollDirection: Axis.horizontal,
        children: [
          ProgressionItem(
            label: localization.completion_summary,
            onTap: onCompletionPressed,
            progression: progression,
            builder: (item) {
              return Padding(
                padding: const EdgeInsets.only(top: AppSpacing.xxxs),
                child: CircularProgressIndicator(value: item.completionPercentage, color: item.completionColor, strokeWidth: 5),
              );
            },
          ),
          ProgressionItem(
            label: localization.overdue_summary,
            onTap: onOverduePressed,
            progression: progression,
            builder: (item) {
              return Padding(
                padding: const EdgeInsets.only(top: AppSpacing.xxxs),
                child: CircularProgressIndicator(value: item.overduePercentage, color: Colors.red, strokeWidth: 5),
              );
            },
          ),
          ProgressionItem(
            label: localization.priority_summary,
            onTap: onPriorityPressed,
            progression: progression,
            builder: (item) {
              return ProgressionItemChart(
                height: 40,
                width: 40,
                items: TaskPriority.values,
                builder: (priority) {
                  return PieChartSectionData(
                    color: priority.color.withValues(alpha: 0.4),
                    borderSide: BorderSide(color: priority.color, width: 2),
                    value: item.tasks.where((item) => item.priority == priority).length.toDouble(),
                    radius: 15,
                    title: '',
                  );
                },
              );
            },
          ),
          ProgressionItem(
            label: localization.status_summary,
            onTap: onStatusPressed,
            progression: progression,
            builder: (item) {
              return ProgressionItemChart(
                height: 40,
                width: 40,
                items: TaskStatus.values,
                builder: (status) {
                  return PieChartSectionData(
                    color: status.color.withValues(alpha: 0.4),
                    borderSide: BorderSide(color: status.color, width: 2),
                    value: item.tasks.where((item) => item.status == status).length.toDouble(),
                    radius: 15,
                    titlePositionPercentageOffset: 0.55,
                    title: '',
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
