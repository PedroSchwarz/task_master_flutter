import 'package:flutter/material.dart';
import 'package:task_master/app/app.dart';

class TaskFilteredContentUnavailable extends StatelessWidget {
  const TaskFilteredContentUnavailable({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final localization = context.localization;

    return Padding(
      padding: const .all(AppSpacing.s),
      child: Column(
        mainAxisAlignment: .center,
        crossAxisAlignment: .stretch,
        children: [
          const Spacer(),
          Text(
            localization.empty_filtered_tasks_title,
            style: theme.textTheme.titleLarge,
            textAlign: .center,
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
