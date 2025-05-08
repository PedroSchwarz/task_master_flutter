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
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(child: GroupFeaturedItem(group: groups.first, onTap: () => onSelected(groups.first))),
          SliverGrid.builder(
            itemCount: groups.length - 1,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 2.5),
            itemBuilder: (context, position) {
              final group = groups[position + 1];

              return Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppSpacing.xs)),
                margin: const EdgeInsets.symmetric(horizontal: AppSpacing.s, vertical: AppSpacing.xxs),
                child: ListTile(
                  title: Text(group.name),
                  onTap: () => onSelected(group),
                  trailing: const CircularProgressIndicator(value: 0.5),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppSpacing.xs)),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
