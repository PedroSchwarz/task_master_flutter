import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:task_master/app/design_system/components/app_skeleton.dart';
import 'package:task_master/app/design_system/theme/app_spacing.dart';
import 'package:task_master/progress/domain/models/weekly_task_progression.dart';
import 'package:task_master/progress/ui/view/components/progression_carousel.dart';
import 'package:task_master/progress/ui/view/screens/progression_screen.dart';

class DashboardProgression extends StatelessWidget {
  const DashboardProgression({required this.isLoading, required this.progression, super.key});

  final bool isLoading;
  final List<WeeklyTaskProgression?> progression;

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Padding(padding: EdgeInsets.all(AppSpacing.s), child: AppSkeleton(isLoading: true, child: SizedBox(height: 150)));
    }

    return ProgressionCarousel(
      height: 150,
      progression: progression,
      onCompletionPressed: () {
        context.pushNamed(ProgressionScreen.routeName);
      },
      onOverduePressed: () {
        context.pushNamed(ProgressionScreen.routeName);
      },
      onPriorityPressed: () {
        context.pushNamed(ProgressionScreen.routeName);
      },
      onStatusPressed: () {
        context.pushNamed(ProgressionScreen.routeName);
      },
    ).animate().fade(delay: 150.ms);
  }
}
