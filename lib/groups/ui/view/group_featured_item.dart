import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:task_master/app/design_system/theme/app_spacing.dart';
import 'package:task_master/groups/groups.dart';

class GroupFeaturedItem extends StatelessWidget {
  const GroupFeaturedItem({required this.group, required this.isEditable, required this.onTap, required this.onEdit, super.key});

  final GroupResponse group;
  final bool isEditable;
  final VoidCallback onTap;
  final VoidCallback onEdit;

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
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    spacing: AppSpacing.s,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(child: Text(group.name, style: theme.textTheme.titleLarge)),
                      if (isEditable) IconButton(onPressed: onEdit, icon: const Icon(Icons.edit)),
                    ],
                  ),
                  Text(group.description, maxLines: 3, overflow: TextOverflow.ellipsis),
                  const Gap(AppSpacing.s),
                  SizedBox(
                    height: 40,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: group.members.length,
                      itemBuilder: (context, index) {
                        final member = group.members[index];

                        return CircleAvatar(child: Text('${member.firstName.substring(0, 1)}${member.lastName.substring(0, 1)}'));
                      },
                      separatorBuilder: (context, index) => const Gap(AppSpacing.xs),
                    ),
                  ),
                  const Gap(AppSpacing.xxs),
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
