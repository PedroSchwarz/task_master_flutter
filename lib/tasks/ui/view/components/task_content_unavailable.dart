import 'package:flutter/material.dart';
import 'package:task_master/app/app.dart';

class TaskContentUnavailable extends StatelessWidget {
  const TaskContentUnavailable({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final localization = context.localization;

    return Padding(
      padding: const EdgeInsets.all(AppSpacing.s),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Spacer(),
          Text(localization.empty_tasks_title, style: theme.textTheme.titleLarge, textAlign: TextAlign.center),
          RichText(
            text: TextSpan(
              style: theme.textTheme.titleMedium,
              children: [
                TextSpan(text: localization.empty_tasks_description_1),
                TextSpan(text: ' + ', style: theme.textTheme.titleLarge?.copyWith(color: theme.colorScheme.primary)),
                TextSpan(text: localization.empty_tasks_description_2),
              ],
            ),
            textAlign: TextAlign.center,
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
