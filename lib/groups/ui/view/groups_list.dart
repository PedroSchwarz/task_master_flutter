import 'package:flutter/material.dart';
import 'package:task_master/app/app.dart';
import 'package:task_master/groups/data/models/group_response.dart';
import 'package:task_master/groups/ui/view/group_featured_item.dart';

class GroupsList extends StatelessWidget {
  const GroupsList({required this.groups, required this.onSelected, required this.onRefresh, super.key});

  final List<GroupResponse> groups;
  final void Function(GroupResponse) onSelected;
  final Future<void> Function() onRefresh;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: onRefresh,
      child: ListView.builder(
        itemCount: groups.length,
        itemBuilder: (context, position) {
          final group = groups[position];

          if (position == 0) {
            return GroupFeaturedItem(group: group, onTap: () => onSelected(group));
          }

          return Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppSpacing.xs)),
            margin: const EdgeInsets.symmetric(horizontal: AppSpacing.s, vertical: AppSpacing.xxs),
            child: ListTile(
              title: Text(group.name),
              subtitle: Text(group.description),
              onTap: () => onSelected(group),
              trailing: const CircularProgressIndicator(value: 0.5),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppSpacing.xs)),
            ),
          );
        },
      ),
    );
  }
}
