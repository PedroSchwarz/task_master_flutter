import 'package:flutter/material.dart';
import 'package:task_master/app/app.dart';

class GroupFilteredContentUnavailable extends StatelessWidget {
  const GroupFilteredContentUnavailable({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final localization = context.localization;

    return SliverPadding(
      padding: const .all(AppSpacing.s),
      sliver: SliverToBoxAdapter(
        child: Column(
          mainAxisAlignment: .center,
          crossAxisAlignment: .stretch,
          children: [
            Text(
              localization.empty_filtered_groups_title,
              style: theme.textTheme.titleLarge,
              textAlign: .center,
            ),
          ],
        ),
      ),
    );
  }
}
