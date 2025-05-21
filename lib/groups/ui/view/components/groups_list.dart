import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:task_master/app/design_system/theme/app_spacing.dart';
import 'package:task_master/auth/data/models/user_data.dart';
import 'package:task_master/groups/groups.dart';
import 'package:task_master/groups/ui/view/components/group_item.dart';

class GroupsList extends StatelessWidget {
  const GroupsList({
    required this.groups,
    required this.currentUser,
    required this.onSelected,
    required this.onEdit,
    required this.onRefresh,
    super.key,
  });

  final List<GroupResponse> groups;
  final UserData currentUser;
  final void Function(GroupResponse) onSelected;
  final Future<void> Function(GroupResponse) onEdit;
  final RefreshCallback onRefresh;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: onRefresh,
      child: ListView.separated(
        padding: const EdgeInsets.only(top: AppSpacing.s, bottom: AppSpacing.max),
        itemCount: groups.length,
        itemBuilder: (context, position) {
          final group = groups[position];

          return GroupItem(group: group, isEditable: group.owner.id == currentUser.id, onTap: () => onSelected(group), onEdit: () => onEdit(group));
        },
        separatorBuilder: (context, index) => const Gap(AppSpacing.s),
      ),
    );
  }
}
