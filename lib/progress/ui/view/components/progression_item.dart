import 'package:flutter/material.dart';
import 'package:task_master/app/design_system/theme/app_spacing.dart';
import 'package:task_master/progress/progress.dart';

class ProgressionItem extends StatelessWidget {
  const ProgressionItem({required this.progression, required this.label, required this.builder, this.onTap, super.key});

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
        margin: const EdgeInsets.symmetric(horizontal: AppSpacing.s),
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.s),
        child: Column(
          spacing: AppSpacing.xs,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              spacing: AppSpacing.xxs,
              children: [
                Flexible(child: Text('$label Summary', style: theme.textTheme.titleLarge)),
                Tooltip(
                  message: 'Information regarding assigned tasks',
                  textStyle: theme.textTheme.titleMedium?.copyWith(color: theme.colorScheme.onPrimary),
                  child: const Icon(Icons.info_outline_rounded),
                ),
              ],
            ),
            Row(
              spacing: AppSpacing.s,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children:
                  progression.map((progression) {
                    return Column(
                      spacing: AppSpacing.xxs,
                      children: [
                        Text('${(progression?.startDate.day ?? 0)}-${(progression?.endDate.day ?? 0)} / ${(progression?.endDate.month ?? 0)}'),
                        if (progression == null || progression.tasks.isEmpty) const CircleAvatar(child: Icon(Icons.close)) else builder(progression),
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
