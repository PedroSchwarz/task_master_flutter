import 'package:flutter/material.dart';
import 'package:task_master/app/app.dart';

class GroupContentUnavailable extends StatelessWidget {
  const GroupContentUnavailable({super.key});

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
              localization.empty_groups_title,
              style: theme.textTheme.titleLarge,
              textAlign: .center,
            ),
            RichText(
              text: TextSpan(
                style: theme.textTheme.titleMedium,
                children: [
                  TextSpan(
                    text: localization.empty_groups_description_1,
                  ),
                  TextSpan(
                    text: ' + ',
                    style: theme.textTheme.titleLarge?.copyWith(
                      color: theme.colorScheme.primary,
                    ),
                  ),
                  TextSpan(
                    text: localization.empty_groups_description_2,
                  ),
                ],
              ),
              textAlign: .center,
            ),
          ],
        ),
      ),
    );
  }
}
