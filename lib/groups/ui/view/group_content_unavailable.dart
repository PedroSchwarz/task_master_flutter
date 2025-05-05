import 'package:flutter/material.dart';

class GroupContentUnavailable extends StatelessWidget {
  const GroupContentUnavailable({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Spacer(),
        Text("You don't belong to any groups yet.", style: theme.textTheme.titleLarge, textAlign: TextAlign.center),
        RichText(
          text: TextSpan(
            style: theme.textTheme.titleMedium,
            children: [
              const TextSpan(text: 'You can create a new group by tapping the'),
              TextSpan(text: ' + ', style: theme.textTheme.headlineLarge?.copyWith(fontWeight: FontWeight.bold, color: theme.colorScheme.primary)),
              const TextSpan(text: 'button or join an existing one.'),
            ],
          ),
          textAlign: TextAlign.center,
        ),
        const Spacer(),
      ],
    );
  }
}
