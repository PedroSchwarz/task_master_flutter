import 'package:flutter/material.dart';
import 'package:task_master/app/design_system/theme/app_spacing.dart';

class TaskFilteredContentUnavailable extends StatelessWidget {
  const TaskFilteredContentUnavailable({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.all(AppSpacing.s),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Spacer(),
          Text("No tasks found for selected filters", style: theme.textTheme.titleLarge, textAlign: TextAlign.center),
          const Spacer(),
        ],
      ),
    );
  }
}
