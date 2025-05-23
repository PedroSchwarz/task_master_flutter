import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
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
    return SizedBox(
      height: height,
      child: PageView(
        scrollDirection: Axis.horizontal,
        children: [
          ProgressionItem(
            label: 'Completion',
            onTap: onCompletionPressed,
            progression: progression,
            builder: (item) {
              return CircularProgressIndicator(value: item.completionPercentage, color: item.completionColor, strokeWidth: 5);
            },
          ),
          ProgressionItem(
            label: 'Overdue',
            onTap: onOverduePressed,
            progression: progression,
            builder: (item) {
              return CircularProgressIndicator(value: item.overduePercentage, color: Colors.red, strokeWidth: 5);
            },
          ),
          ProgressionItem(
            label: 'Priority',
            onTap: onPriorityPressed,
            progression: progression,
            builder: (item) {
              return ProgressionItemChart(
                items: TaskPriority.values,
                builder: (priority) {
                  return PieChartSectionData(
                    color: priority.color,
                    value: item.tasks.where((item) => item.priority == priority).length.toDouble(),
                    radius: 15,
                    titlePositionPercentageOffset: 0.55,
                    title: '',
                  );
                },
              );
            },
          ),
          ProgressionItem(
            label: 'Status',
            onTap: onStatusPressed,
            progression: progression,
            builder: (item) {
              return ProgressionItemChart(
                items: TaskStatus.values,
                builder: (status) {
                  return PieChartSectionData(
                    color: status.color,
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
