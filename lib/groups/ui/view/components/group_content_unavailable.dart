import 'package:flutter/material.dart';
import 'package:task_master/app/design_system/theme/app_spacing.dart';

class GroupContentUnavailable extends StatelessWidget {
  const GroupContentUnavailable({required this.onRefresh, super.key});

  final RefreshCallback onRefresh;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return LayoutBuilder(
      builder: (context, constraints) {
        return RefreshIndicator(
          onRefresh: onRefresh,
          child: SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.s),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text("You don't belong to any groups yet.", style: theme.textTheme.titleLarge, textAlign: TextAlign.center),
                    RichText(
                      text: TextSpan(
                        style: theme.textTheme.titleMedium,
                        children: [
                          const TextSpan(text: 'You can create a new group by tapping the'),
                          TextSpan(text: ' + ', style: theme.textTheme.headlineLarge?.copyWith(color: theme.colorScheme.primary)),
                          const TextSpan(text: 'button or join an existing one.'),
                        ],
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
