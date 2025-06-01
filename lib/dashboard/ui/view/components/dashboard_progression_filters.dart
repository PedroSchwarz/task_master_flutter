import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:task_master/app/design_system/components/app_skeleton.dart';
import 'package:task_master/app/design_system/theme/app_spacing.dart';
import 'package:task_master/app/extensions/build_context_extensions.dart';
import 'package:task_master/progress/domain/models/task_progression_selection.dart';

class DashboardProgressionFilters extends StatelessWidget {
  const DashboardProgressionFilters({required this.isLoading, required this.selection, required this.onSelection, super.key});

  final bool isLoading;
  final TaskProgressionSelection selection;
  final void Function(TaskProgressionSelection) onSelection;

  @override
  Widget build(BuildContext context) {
    final localization = context.localization;

    return Padding(
      padding: const EdgeInsets.fromLTRB(AppSpacing.s, AppSpacing.s, AppSpacing.s, AppSpacing.xs),
      child: AppSkeleton(
        isLoading: isLoading,
        child: Row(
          spacing: AppSpacing.s,
          children:
              TaskProgressionSelection.values.map((progression) {
                return ChoiceChip(
                  onSelected: (_) {
                    onSelection(progression);
                  },
                  label: Text(switch (progression) {
                    TaskProgressionSelection.assigned => localization.filter_assigned,
                    TaskProgressionSelection.owned => localization.filter_owned,
                  }),
                  selected: selection == progression,
                );
              }).toList(),
        ).animate().fade(delay: 100.ms),
      ),
    );
  }
}
