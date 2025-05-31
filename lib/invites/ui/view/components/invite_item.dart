import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:task_master/app/app.dart';
import 'package:task_master/invites/data/models/invite_response.dart';

class InviteItem extends StatelessWidget {
  const InviteItem({required this.invite, required this.onAccepted, required this.onRejected, super.key});

  final InviteResponse invite;
  final Function(InviteResponse) onAccepted;
  final Function(InviteResponse) onRejected;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final localizations = context.localization;

    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: AppSpacing.s),
      leading:
          invite.status == InviteStatus.accepted
              ? CircleAvatar(
                backgroundColor: theme.scaffoldBackgroundColor,
                child: const Icon(Icons.check, color: Colors.green, size: AppSpacing.xxm),
              ).animate().fade(delay: 50.ms)
              : null,
      title: Text(invite.group.name),
      subtitle: Text('${localizations.invited_by} ${invite.from.completeName}'),
      trailing:
          invite.status == InviteStatus.pending
              ? Row(
                spacing: AppSpacing.xs,
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton.outlined(
                    onPressed: () {
                      HapticFeedback.heavyImpact();
                      onAccepted(invite);
                    },
                    icon: const Icon(Icons.check),
                    color: Colors.green,
                    style: IconButton.styleFrom(side: const BorderSide(color: Colors.green)),
                  ),
                  IconButton.outlined(
                    onPressed: () {
                      HapticFeedback.heavyImpact();
                      onRejected(invite);
                    },
                    color: Colors.red,
                    icon: const Icon(Icons.close),
                    style: IconButton.styleFrom(side: const BorderSide(color: Colors.red)),
                  ),
                ],
              )
              : null,
    );
  }
}
