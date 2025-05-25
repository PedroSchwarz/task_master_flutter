import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:task_master/app/app.dart';

class DashboardDrawer extends StatelessWidget {
  const DashboardDrawer({required this.initials, required this.title, required this.subtitle, required this.onSignOut, super.key});

  final String initials;
  final String title;
  final String subtitle;
  final VoidCallback onSignOut;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Drawer(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(AppSpacing.s, AppSpacing.s, AppSpacing.s, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const AppLogo(size: AppSpacing.xm),
              const Gap(AppSpacing.s),
              Row(
                spacing: AppSpacing.s,
                children: [
                  CircleAvatar(radius: 30, child: Text(initials, style: theme.textTheme.headlineSmall)),
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [Text(title, style: theme.textTheme.headlineSmall), Text(subtitle, style: theme.textTheme.labelSmall)],
                    ),
                  ),
                ],
              ),
              const Spacer(),
              FilledButton.tonal(onPressed: onSignOut, child: const Text('Sign Out')),
            ],
          ),
        ),
      ),
    );
  }
}
