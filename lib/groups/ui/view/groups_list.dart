import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:task_master/app/app.dart';
import 'package:task_master/auth/data/models/user_data.dart';
import 'package:task_master/groups/groups.dart';
import 'package:task_master/groups/ui/view/group_featured_item.dart';

class GroupsList extends StatelessWidget {
  const GroupsList({required this.groups, required this.currentUser, required this.onSelected, required this.onRefresh, super.key});

  final List<GroupResponse> groups;
  final UserData currentUser;
  final void Function(GroupResponse) onSelected;
  final Future<void> Function() onRefresh;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return RefreshIndicator(
      onRefresh: onRefresh,
      child: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.all(AppSpacing.s),
            sliver: SliverToBoxAdapter(child: Text('Groups', style: theme.textTheme.headlineSmall)),
          ),
          SliverList.builder(
            itemCount: groups.length,
            itemBuilder: (context, position) {
              final group = groups[position];
              return GroupFeaturedItem(
                group: group,
                isEditable: group.owner.id == currentUser.id,
                onTap: () => onSelected(group),
                onEdit: () async {
                  if (context.mounted) {
                    await context.pushNamed(CreateGroupScreen.routeName, queryParameters: {'id': group.id});
                    await onRefresh();
                  }
                },
              );
            },
          ),
          const SliverToBoxAdapter(child: Gap(AppSpacing.max)),
        ],
      ),
    );
  }
}
