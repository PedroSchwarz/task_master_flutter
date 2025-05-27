import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart';
import 'package:task_master/app/design_system/components/app_skeleton.dart';
import 'package:task_master/app/design_system/theme/app_spacing.dart';
import 'package:task_master/dashboard/dashboard.dart';

class GroupListLoading extends StatelessWidget {
  const GroupListLoading({required this.listType, super.key});

  final GroupsListType listType;

  @override
  Widget build(BuildContext context) {
    return switch (listType) {
      GroupsListType.list => ListView.separated(
        padding: const EdgeInsets.all(AppSpacing.s),
        itemCount: 5,
        itemBuilder: (_, __) {
          return const AppSkeleton(isLoading: true, child: SizedBox(height: 150, width: double.infinity));
        },
        separatorBuilder: (_, __) {
          return const Gap(AppSpacing.s);
        },
      ),
      GroupsListType.grid => GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: AppSpacing.s,
          crossAxisSpacing: AppSpacing.s,
          childAspectRatio: 1.1,
        ),
        padding: const EdgeInsets.all(AppSpacing.s),
        itemCount: 5,
        itemBuilder: (_, __) {
          return const AppSkeleton(isLoading: true, child: SizedBox(height: 150, width: double.infinity));
        },
      ),
    };
  }
}
