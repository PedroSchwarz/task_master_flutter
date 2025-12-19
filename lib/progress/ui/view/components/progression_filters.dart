import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:task_master/app/design_system/components/app_skeleton.dart';
import 'package:task_master/app/design_system/theme/app_spacing.dart';
import 'package:task_master/app/extensions/build_context_extensions.dart';
import 'package:task_master/progress/domain/models/task_progression_selection.dart';

class ProgressionFilters extends StatefulWidget {
  const ProgressionFilters({
    required this.isLoading,
    required this.selection,
    required this.onSelection,
    super.key,
  });

  final bool isLoading;
  final TaskProgressionSelection selection;
  final void Function(TaskProgressionSelection) onSelection;

  @override
  State<ProgressionFilters> createState() =>
      _DashboardProgressionFiltersState();
}

class _DashboardProgressionFiltersState extends State<ProgressionFilters> {
  double _dragOffset = 0;
  double _totalDragDistance = 0;

  @override
  void didUpdateWidget(ProgressionFilters oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Reset drag offset when selection changes externally
    if (oldWidget.selection != widget.selection) {
      _dragOffset = 0;
      _totalDragDistance = 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    final localization = context.localization;
    final theme = Theme.of(context);

    return Padding(
      padding: const .fromLTRB(
        AppSpacing.s,
        AppSpacing.s,
        AppSpacing.s,
        AppSpacing.xs,
      ),
      child: AppSkeleton(
        isLoading: widget.isLoading,
        radius: AppSpacing.max,
        child: Container(
          padding: const .all(AppSpacing.xxs),
          decoration: BoxDecoration(
            color: theme.colorScheme.surfaceContainer,
            borderRadius: .circular(AppSpacing.max),
          ),
          child: LayoutBuilder(
            builder: (context, constraints) {
              return Stack(
                children: [
                  ClipRRect(
                    borderRadius: .circular(AppSpacing.max),
                    child: Row(
                      children: TaskProgressionSelection.values.map((
                        progression,
                      ) {
                        return Expanded(
                          child: Material(
                            color: theme.colorScheme.surfaceContainer,
                            child: InkWell(
                              borderRadius: .circular(AppSpacing.max),
                              onTap: () {
                                widget.onSelection(progression);
                              },
                              child: Container(
                                padding: const .all(AppSpacing.xs),
                                alignment: .center,
                                child: AnimatedOpacity(
                                  opacity: widget.selection != progression
                                      ? 1
                                      : 0,
                                  duration: const Duration(milliseconds: 300),
                                  child: Text(
                                    switch (progression) {
                                      .assigned => localization.filter_assigned,
                                      .owned => localization.filter_owned,
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ).animate().fade(delay: 100.ms),
                  ),
                  AnimatedPositioned(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeOut,
                    left: () {
                      final basePosition = widget.selection == .assigned
                          ? 0.0
                          : constraints.maxWidth / 2;
                      return basePosition + _dragOffset;
                    }(),
                    child: GestureDetector(
                      onHorizontalDragStart: (_) {
                        setState(() {
                          _totalDragDistance = 0;
                        });
                      },
                      onHorizontalDragUpdate: (details) {
                        final halfWidth = constraints.maxWidth / 2;
                        setState(() {
                          _dragOffset += details.delta.dx;
                          _totalDragDistance += details.delta.dx;

                          // Clamp the drag offset to prevent dragging too far
                          if (widget.selection == .assigned) {
                            _dragOffset = _dragOffset.clamp(0.0, halfWidth);
                          } else {
                            _dragOffset = _dragOffset.clamp(-halfWidth, 0.0);
                          }
                        });
                      },
                      onHorizontalDragEnd: (details) {
                        const threshold = 10.0;
                        final shouldSwitch = switch (widget.selection) {
                          .assigned => _totalDragDistance > threshold,
                          .owned => _totalDragDistance < -threshold,
                        };

                        if (shouldSwitch) {
                          final newSelection = switch (widget.selection) {
                            .assigned => TaskProgressionSelection.owned,
                            .owned => TaskProgressionSelection.assigned,
                          };
                          // Reset offset before switching to allow smooth animation
                          setState(() {
                            _dragOffset = 0;
                            _totalDragDistance = 0;
                          });
                          widget.onSelection(newSelection);
                        } else {
                          // Reset to original position
                          setState(() {
                            _dragOffset = 0;
                            _totalDragDistance = 0;
                          });
                        }
                      },
                      onHorizontalDragCancel: () {
                        // Reset if drag is cancelled
                        setState(() {
                          _dragOffset = 0;
                          _totalDragDistance = 0;
                        });
                      },
                      child: Container(
                        constraints: BoxConstraints(
                          maxWidth: constraints.maxWidth / 2,
                        ),
                        padding: const .all(AppSpacing.xs),
                        decoration: BoxDecoration(
                          color: theme.colorScheme.primaryContainer,
                          borderRadius: .circular(AppSpacing.max),
                        ),
                        alignment: .center,
                        child: Text(
                          switch (widget.selection) {
                            .assigned => localization.filter_assigned,
                            .owned => localization.filter_owned,
                          },
                          style: theme.textTheme.bodyMedium?.copyWith(
                            fontWeight: .bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
