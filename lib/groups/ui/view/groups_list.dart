import 'package:flutter/material.dart';
import 'package:task_master/groups/data/models/group_response.dart';

class GroupsList extends StatelessWidget {
  const GroupsList({required this.groups, super.key});

  final List<GroupResponse> groups;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: groups.length,
      itemBuilder: (context, position) {
        final group = groups[position];
        return ListTile(
          title: Text(group.name),
          subtitle: Text(group.description),
          onTap: () {},
        );
      },
      separatorBuilder: (context, index) => const Divider(),
    );
  }
}
