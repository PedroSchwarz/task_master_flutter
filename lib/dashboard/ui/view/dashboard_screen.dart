import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:task_master/app/app.dart';
import 'package:task_master/groups/ui/view/create_group_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  static const String routeName = 'dashboard';

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Dashboard')),
      body: Padding(
        padding: const EdgeInsets.all(AppSpacing.s),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "You don't belong to any groups yet.",
                style: theme.textTheme.titleLarge,
                textAlign: TextAlign.center,
              ),
              RichText(
                text: TextSpan(
                  style: theme.textTheme.titleMedium,
                  children: [
                    const TextSpan(
                      text: 'You can create a new group by tapping the',
                    ),
                    TextSpan(
                      text: ' + ',
                      style: theme.textTheme.headlineLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: theme.colorScheme.primary,
                      ),
                    ),
                    const TextSpan(text: 'button or join an existing one.'),
                  ],
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        label: const Text('Create Group'),
        icon: const Icon(Icons.add),
        onPressed: () => context.goNamed(CreateGroupScreen.routeName),
      ),
    );
  }
}
