import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:task_master/app/design_system/components/app_skeleton.dart';
import 'package:task_master/app/design_system/theme/app_spacing.dart';

class TasksListLoading extends StatelessWidget {
  const TasksListLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const .all(AppSpacing.s),
      itemCount: 5,
      itemBuilder: (_, _) {
        return const AppSkeleton(
          isLoading: true,
          child: SizedBox(height: 150, width: .infinity),
        );
      },
      separatorBuilder: (_, _) {
        return const Gap(AppSpacing.s);
      },
    );
  }
}
