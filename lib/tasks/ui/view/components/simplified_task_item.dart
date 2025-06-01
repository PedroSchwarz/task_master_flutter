import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:gap/gap.dart';
import 'package:task_master/app/app.dart';
import 'package:task_master/tasks/data/models/task_response.dart';

class SimplifiedTaskItem extends StatelessWidget {
  const SimplifiedTaskItem({required this.task, required this.position, required this.onTap, super.key});

  final TaskResponse task;
  final int position;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final localization = context.localization;

    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(border: Border(left: BorderSide(color: task.priority.color, width: 5))),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s, vertical: AppSpacing.xs),
          child: Row(
            spacing: AppSpacing.s,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                fit: FlexFit.tight,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(task.title, style: theme.textTheme.titleLarge?.copyWith(color: task.isOverdue ? Colors.red : null)),
                    Text(
                      task.description ?? localization.no_description,
                      style: theme.textTheme.bodyLarge,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const Gap(AppSpacing.xs),
                    Text(task.formattedDueDate, style: theme.textTheme.labelLarge?.copyWith(color: task.isOverdue ? Colors.red : null)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ).animate().fade(delay: Duration(milliseconds: min(100 * position, 500)));
  }
}
