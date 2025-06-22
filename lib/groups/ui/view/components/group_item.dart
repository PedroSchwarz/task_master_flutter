import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:gap/gap.dart';
import 'package:task_master/app/design_system/theme/app_spacing.dart';
import 'package:task_master/groups/groups.dart';

class GroupItem extends StatelessWidget {
  const GroupItem({required this.group, required this.position, required this.isEditable, required this.onTap, required this.onEdit, super.key});

  final GroupResponse group;
  final int position;
  final bool isEditable;
  final VoidCallback onTap;
  final VoidCallback onEdit;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final groupColor = group.color;

    return Stack(
      alignment: Alignment.topRight,
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppSpacing.xxs),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                theme.colorScheme.surfaceContainer,
                theme.colorScheme.surfaceContainer,
                if (groupColor != null) Color(groupColor).withValues(alpha: 0.3) else theme.colorScheme.surfaceContainer,
              ],
              stops: const [0, 0.4, 1],
            ),
            boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.1), blurRadius: 4, offset: const Offset(0, 2))],
          ),
          child: Card(
            color: Colors.transparent,
            elevation: 0,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppSpacing.xs)),
            margin: EdgeInsets.zero,
            child: InkWell(
              borderRadius: BorderRadius.circular(AppSpacing.xs),
              onTap: onTap,
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.s),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(group.name, maxLines: 1, overflow: TextOverflow.ellipsis, style: theme.textTheme.titleLarge),
                        Text(group.description, maxLines: 2, overflow: TextOverflow.ellipsis),
                      ],
                    ),
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
        ),
        if (isEditable)
          Transform.translate(
            offset: const Offset(AppSpacing.s, -AppSpacing.s),
            child: IconButton.filled(onPressed: onEdit, icon: const Icon(Icons.edit)),
          ),
      ],
    ).animate().fade(delay: Duration(milliseconds: min(150 * (position + 1), 500)));
  }
}
