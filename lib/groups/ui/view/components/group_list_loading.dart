import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart';
import 'package:task_master/app/design_system/components/app_skeleton.dart';
import 'package:task_master/app/design_system/theme/app_spacing.dart';

class GroupListLoading extends StatelessWidget {
  const GroupListLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(AppSpacing.s),
      itemCount: 5,
      itemBuilder: (_, __) {
        return const AppSkeleton(isLoading: true, child: SizedBox(height: 150, width: double.infinity));
      },
      separatorBuilder: (_, __) {
        return const Gap(AppSpacing.s);
      },
    );
  }
}
