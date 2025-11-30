import 'package:flutter/material.dart';
import 'package:task_master/app/design_system/theme/app_spacing.dart';
import 'package:task_master/progress/progress.dart';

class ProgressionItem extends StatelessWidget {
  const ProgressionItem({
    required this.progression,
    required this.label,
    required this.builder,
    this.onTap,
    super.key,
  });

  final List<WeeklyTaskProgression?> progression;
  final String label;
  final Widget Function(WeeklyTaskProgression) builder;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const .all(AppSpacing.s),
        child: Column(
          spacing: AppSpacing.s,
          mainAxisAlignment: .center,
          crossAxisAlignment: .stretch,
          children: [
            Text(label, style: theme.textTheme.headlineSmall),
            Row(
              spacing: AppSpacing.s,
              mainAxisAlignment: .spaceBetween,
              crossAxisAlignment: .start,
              children: progression.map((progression) {
                return Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: .spaceBetween,
                  spacing: AppSpacing.xs,
                  children: [
                    Text(
                      '${(progression?.startDate.day ?? 0)}-${(progression?.endDate.day ?? 0)} / ${(progression?.endDate.month ?? 0)}',
                    ),
                    if (progression == null || progression.tasks.isEmpty)
                      const CircleAvatar(radius: 21, child: Icon(Icons.close))
                    else
                      builder(progression),
                  ],
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
