import 'dart:io';

import 'package:flutter/material.dart';
import 'package:task_master/app/app.dart';

class DashboardDrawer extends StatelessWidget {
  const DashboardDrawer({
    required this.initials,
    required this.title,
    required this.subtitle,
    required this.showingProgression,
    required this.showingHighlights,
    required this.onProgressionPressed,
    required this.onHighlightsPressed,
    required this.onSignOut,
    super.key,
  });

  final String initials;
  final String title;
  final String subtitle;
  final bool showingProgression;
  final bool showingHighlights;
  final ValueChanged<bool> onProgressionPressed;
  final ValueChanged<bool> onHighlightsPressed;
  final VoidCallback onSignOut;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final localization = context.localization;

    return Drawer(
      child: SafeArea(
        child: Padding(
          padding: .fromLTRB(
            AppSpacing.s,
            AppSpacing.s,
            AppSpacing.s,
            Platform.isMacOS ? AppSpacing.s : 0,
          ),
          child: Column(
            spacing: AppSpacing.s,
            crossAxisAlignment: .stretch,
            children: [
              const AppLogo(size: AppSpacing.xm),
              Row(
                spacing: AppSpacing.s,
                children: [
                  CircleAvatar(
                    radius: 30,
                    child: Text(initials, style: theme.textTheme.headlineSmall),
                  ),
                  Flexible(
                    child: Column(
                      crossAxisAlignment: .start,
                      children: [
                        Text(title, style: theme.textTheme.headlineSmall),
                        Text(subtitle, style: theme.textTheme.labelSmall),
                      ],
                    ),
                  ),
                ],
              ),
              const Divider(),
              Row(
                mainAxisAlignment: .spaceBetween,
                children: [
                  Text(
                    localization.dashboard_showing_progression,
                    style: theme.textTheme.bodyLarge,
                  ),
                  Switch(
                    value: showingProgression,
                    onChanged: onProgressionPressed,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: .spaceBetween,
                children: [
                  Text(
                    localization.dashboard_showing_highlights,
                    style: theme.textTheme.bodyLarge,
                  ),
                  Switch(
                    value: showingHighlights,
                    onChanged: onHighlightsPressed,
                  ),
                ],
              ),
              const Spacer(),
              const Divider(),
              FilledButton.tonal(
                onPressed: onSignOut,
                child: Text(localization.sign_out),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
