import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:task_master/app/design_system/theme/app_spacing.dart';
import 'package:task_master/auth/data/models/user_data.dart';
import 'package:task_master/dashboard/dashboard.dart';
import 'package:task_master/groups/groups.dart';
import 'package:task_master/groups/ui/view/components/group_item.dart';

class GroupsList extends StatelessWidget {
  const GroupsList({
    required this.groups,
    required this.listType,
    required this.onToggleListType,
    required this.currentUser,
    required this.onSelected,
    required this.onEdit,
    required this.onRefresh,
    super.key,
  });

  final List<GroupResponse> groups;
  final GroupsListType listType;
  final VoidCallback onToggleListType;
  final UserData currentUser;
  final void Function(GroupResponse) onSelected;
  final Future<void> Function(GroupResponse) onEdit;
  final RefreshCallback onRefresh;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Groups', style: theme.textTheme.headlineSmall),
              IconButton(onPressed: onToggleListType, icon: Icon(listType == GroupsListType.list ? Icons.grid_view : Icons.table_rows_outlined)),
            ],
          ),
        ),
        Expanded(
          child: RefreshIndicator(
            onRefresh: onRefresh,
            child: switch (listType) {
              GroupsListType.list => ListView.separated(
                padding: const EdgeInsets.only(top: AppSpacing.s, left: AppSpacing.s, right: AppSpacing.s, bottom: AppSpacing.max),
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
              GroupsListType.grid => GridView.builder(
                padding: const EdgeInsets.only(top: AppSpacing.s, left: AppSpacing.s, right: AppSpacing.s, bottom: AppSpacing.max),
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
          ),
        ),
      ],
    );
  }
}
