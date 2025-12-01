import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:task_master/app/app.dart';
import 'package:task_master/auth/data/models/user_data.dart';
import 'package:task_master/dashboard/dashboard.dart';
import 'package:task_master/groups/groups.dart';
import 'package:task_master/groups/ui/view/components/group_item.dart';

class GroupsList extends StatelessWidget {
  const GroupsList({
    required this.groups,
    required this.listType,
    required this.currentUser,
    required this.onSelected,
    required this.onEdit,
    super.key,
  });

  final List<GroupResponse> groups;
  final GroupsListType listType;
  final UserData currentUser;
  final void Function(GroupResponse) onSelected;
  final Future<void> Function(GroupResponse) onEdit;

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const .only(
        top: AppSpacing.s,
        left: AppSpacing.s,
        right: AppSpacing.s,
        bottom: AppSpacing.max,
      ),
      sliver: switch (listType) {
        .list => SliverList.separated(
          itemCount: groups.length,
          itemBuilder: (context, position) {
            final group = groups[position];

            return GroupItem(
              group: group,
              position: position,
              isEditable: group.owner.id == currentUser.id,
              onTap: () => onSelected(group),
              onEdit: () => onEdit(group),
            );
          },
          separatorBuilder: (context, index) => const Gap(AppSpacing.s),
        ),
        .grid => SliverGrid.builder(
          itemCount: groups.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 1.1,
            mainAxisSpacing: AppSpacing.s,
            crossAxisSpacing: AppSpacing.s,
          ),
          itemBuilder: (context, position) {
            final group = groups[position];

            return GroupItem(
              group: group,
              position: position,
              isEditable: group.owner.id == currentUser.id,
              onTap: () => onSelected(group),
              onEdit: () => onEdit(group),
            );
          },
        ),
      },
    );
  }
}
