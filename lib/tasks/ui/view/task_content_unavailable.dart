import 'package:flutter/material.dart';

class TaskContentUnavailable extends StatelessWidget {
  const TaskContentUnavailable({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Spacer(),
        Text("No tasks were created yet.", style: theme.textTheme.titleLarge, textAlign: TextAlign.center),
        RichText(
          text: TextSpan(
            style: theme.textTheme.titleMedium,
            children: [
              const TextSpan(text: 'You can create a new task by tapping the'),
              TextSpan(text: ' + ', style: theme.textTheme.headlineLarge?.copyWith(fontWeight: FontWeight.bold, color: theme.colorScheme.primary)),
              const TextSpan(text: 'button.'),
            ],
          ),
          textAlign: TextAlign.center,
        ),
        const Spacer(),
      ],
    );
  }
}
