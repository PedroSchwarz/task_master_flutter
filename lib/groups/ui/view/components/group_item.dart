import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:task_master/app/design_system/theme/app_spacing.dart';
import 'package:task_master/groups/groups.dart';

class GroupItem extends StatelessWidget {
  const GroupItem({required this.group, required this.isEditable, required this.onTap, required this.onEdit, super.key});

  final GroupResponse group;
  final bool isEditable;
  final VoidCallback onTap;
  final VoidCallback onEdit;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Stack(
      alignment: Alignment.topRight,
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
                  Text(group.name, style: theme.textTheme.titleLarge),
                  Text(group.description, maxLines: 3, overflow: TextOverflow.ellipsis),
                  const Gap(AppSpacing.s),
                  SizedBox(
                    height: 40,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: group.members.length,
                      itemBuilder: (context, index) {
                        final member = group.members[index];

                        return CircleAvatar(child: Text(member.initials));
                      },
                      separatorBuilder: (context, index) => const Gap(AppSpacing.xs),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        if (isEditable)
          Transform.translate(offset: const Offset(0, -AppSpacing.s), child: IconButton.filled(onPressed: onEdit, icon: const Icon(Icons.edit))),
      ],
    );
  }
}
