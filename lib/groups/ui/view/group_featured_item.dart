import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:task_master/app/design_system/theme/app_spacing.dart';
import 'package:task_master/groups/groups.dart';

class GroupFeaturedItem extends StatelessWidget {
  const GroupFeaturedItem({required this.group, required this.onTap, super.key});

  final GroupResponse group;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppSpacing.xs)),
          margin: const EdgeInsets.symmetric(horizontal: AppSpacing.s),
          child: InkWell(
            borderRadius: BorderRadius.circular(AppSpacing.xs),
            onTap: onTap,
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.s),
              child: Column(
                spacing: AppSpacing.s,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(group.name, style: theme.textTheme.titleLarge),
                  Text(group.description, maxLines: 3, overflow: TextOverflow.ellipsis),
                  SizedBox(
                    height: 30,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: group.members.length,
                      itemBuilder: (context, index) {
                        final member = group.members[index];

                        return CircleAvatar(child: Text('${member.firstName.substring(0, 1)}${member.lastName.substring(0, 1)}'));
                      },
                    ),
                  ),
                  LinearProgressIndicator(value: 0.5, backgroundColor: Colors.grey.shade300),
                ],
              ),
            ),
          ),
        ),
        const Gap(AppSpacing.s),
      ],
    );
  }
}
