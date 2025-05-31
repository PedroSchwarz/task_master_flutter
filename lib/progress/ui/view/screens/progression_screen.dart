import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:task_master/app/app.dart';
import 'package:task_master/progress/progress.dart';
import 'package:task_master/progress/ui/view/components/progression_item_chart.dart';
import 'package:task_master/tasks/data/models/task_values.dart';

class ProgressionScreen extends StatefulWidget {
  const ProgressionScreen({super.key});

  static final String routeName = 'progression';

  @override
  State<ProgressionScreen> createState() => _ProgressionScreenState();
}

class _ProgressionScreenState extends State<ProgressionScreen> {
  final bloc = getIt<ProgressionCubit>();

  Set<int> leftLabels = {};

  @override
  void initState() {
    super.initState();
    bloc.load();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final localization = context.localization;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar.medium(
            title: Text(localization.progression),
            bottom: PreferredSize(
              preferredSize: const Size(0, AppSpacing.s),
              child: BlocSelector<ProgressionCubit, ProgressionState, bool>(
                bloc: bloc,
                selector: (state) => state.isLoading || state.isRefreshing,
                builder: (context, isLoading) => isLoading ? const LinearProgressIndicator() : const SizedBox.shrink(),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: BlocSelector<ProgressionCubit, ProgressionState, TaskProgressionSelection>(
              bloc: bloc,
              selector: (state) => state.selection,
              builder: (context, selection) {
                return Padding(
                  padding: const EdgeInsets.fromLTRB(AppSpacing.s, AppSpacing.s, AppSpacing.s, 0),
                  child: Row(
                    spacing: AppSpacing.s,
                    children:
                        TaskProgressionSelection.values.map((progression) {
                          return ChoiceChip(
                            label: Text(switch (progression) {
                              TaskProgressionSelection.assigned => localization.filter_assigned,
                              TaskProgressionSelection.owned => localization.filter_owned,
                            }),
                            selected: progression == selection,
                            onSelected: (_) {
                              bloc.updateSelection(progression);
                            },
                          );
                        }).toList(),
                  ),
                ).animate().fade(delay: 100.ms);
              },
            ),
          ),
          AppSliverHeaderWrapper.floating(
            maxSize: 60,
            padding: 0,
            child: BlocSelector<ProgressionCubit, ProgressionState, ProgressionPeriod>(
              bloc: bloc,
              selector: (state) => state.period,
              builder: (context, selectedPeriod) {
                return ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s),
                  itemCount: ProgressionPeriod.values.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, position) {
                    final period = ProgressionPeriod.values[position];

                    return FilterChip(
                      selected: selectedPeriod == period,
                      label: switch (period) {
                        ProgressionPeriod.oneMonth => Text(localization.one_month),
                        ProgressionPeriod.threeMonths => Text(localization.three_months),
                        ProgressionPeriod.sixMonths => Text(localization.six_months),
                        ProgressionPeriod.oneYear => Text(localization.one_year),
                      },
                      onSelected: (_) => bloc.updatePeriod(period),
                    );
                  },
                  separatorBuilder: (context, index) => const Gap(AppSpacing.s),
                ).animate().fade(delay: 150.ms);
              },
            ),
          ),
          BlocBuilder<ProgressionCubit, ProgressionState>(
            bloc: bloc,
            builder: (context, state) {
              if (state.isLoading) {
                return const SliverPadding(
                  padding: EdgeInsets.all(AppSpacing.s),
                  sliver: SliverToBoxAdapter(child: AppSkeleton(isLoading: true, child: SizedBox(height: 300, width: double.infinity))),
                );
              }
              late final List<BarChartGroupData> bars = _generateBars(state.progression);

              return SliverPadding(
                padding: const EdgeInsets.all(AppSpacing.s),
                sliver: SliverToBoxAdapter(
                  child: SafeArea(
                    top: false,
                    child: Column(
                      spacing: AppSpacing.s,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SizedBox(
                          height: 300,
                          child: BarChart(
                            BarChartData(
                              groupsSpace: AppSpacing.s,
                              alignment: BarChartAlignment.spaceAround,
                              maxY: state.maxTotal + 1,
                              barTouchData: BarTouchData(
                                touchTooltipData: BarTouchTooltipData(
                                  getTooltipColor: ((_) => Colors.black54),
                                  getTooltipItem: (group, groupIndex, rod, rodIndex) {
                                    return BarTooltipItem(rod.toY.toString(), theme.textTheme.titleMedium!.copyWith(color: Colors.white));
                                  },
                                ),
                              ),
                              titlesData: FlTitlesData(
                                show: true,
                                rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                                topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                                bottomTitles: AxisTitles(
                                  sideTitles: SideTitles(
                                    showTitles: true,
                                    reservedSize: 35,
                                    getTitlesWidget: (value, meta) => bottomTitles(progression: state.progression[value.toInt()], meta: meta),
                                  ),
                                ),
                                leftTitles: AxisTitles(
                                  sideTitles: SideTitles(
                                    minIncluded: false,
                                    showTitles: true,
                                    interval: 1,
                                    getTitlesWidget: (value, meta) => leftTitles(state.maxTotal + 1, value, meta),
                                  ),
                                ),
                              ),
                              borderData: FlBorderData(show: false),
                              barGroups: bars,
                              backgroundColor: theme.colorScheme.primaryContainer,
                              gridData: const FlGridData(show: false),
                            ),
                          ),
                        ).animate().fade(delay: 200.ms),
                        Wrap(
                          spacing: AppSpacing.m,
                          runSpacing: AppSpacing.s,
                          children: [
                            Row(
                              spacing: AppSpacing.xs,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const CircleAvatar(radius: AppSpacing.xs, backgroundColor: Colors.green),
                                Text(localization.completed_tasks),
                              ],
                            ),
                            Row(
                              spacing: AppSpacing.xs,
                              mainAxisSize: MainAxisSize.min,
                              children: [const CircleAvatar(radius: AppSpacing.xs, backgroundColor: Colors.red), Text(localization.overdue_tasks)],
                            ),
                            Row(
                              spacing: AppSpacing.xs,
                              mainAxisSize: MainAxisSize.min,
                              children: [const CircleAvatar(radius: AppSpacing.xs, backgroundColor: Colors.blue), Text(localization.total_tasks)],
                            ),
                          ],
                        ).animate().fade(delay: 200.ms),
                        const Divider(),
                        Text(localization.priority_summary, style: theme.textTheme.titleLarge).animate().fade(delay: 300.ms),
                        Wrap(
                          spacing: AppSpacing.m,
                          runSpacing: AppSpacing.s,
                          alignment: WrapAlignment.start,
                          children:
                              state.progression.map((progression) {
                                return Column(
                                  spacing: AppSpacing.s,
                                  children: [
                                    if (progression == null || progression.tasks.isEmpty)
                                      const CircleAvatar(radius: 36, child: Icon(Icons.close))
                                    else
                                      ProgressionItemChart(
                                        width: 70,
                                        height: 70,
                                        items: TaskPriority.values,
                                        builder: (priority) {
                                          final count = progression.tasks.where((item) => item.priority == priority).length;

                                          return PieChartSectionData(
                                            color: priority.color.withValues(alpha: 0.8),
                                            borderSide: BorderSide(color: priority.color, width: 3),
                                            value: count.toDouble(),
                                            radius: 30,
                                            titlePositionPercentageOffset: 0.55,
                                            title: '$count',
                                            titleStyle: theme.textTheme.titleMedium?.copyWith(color: Colors.white),
                                          );
                                        },
                                      ),
                                    if (progression == null)
                                      const SizedBox.shrink()
                                    else
                                      Text('${progression.startDate.day}-${progression.endDate.day} / ${progression.endDate.month}'),
                                  ],
                                );
                              }).toList(),
                        ).animate().fade(delay: 300.ms),
                        Wrap(
                          spacing: AppSpacing.m,
                          runSpacing: AppSpacing.s,
                          children:
                              TaskPriority.values.map((priority) {
                                return Row(
                                  spacing: AppSpacing.xs,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    CircleAvatar(radius: AppSpacing.xs, backgroundColor: priority.color),
                                    Text(switch (priority) {
                                      TaskPriority.low => localization.low,
                                      TaskPriority.medium => localization.medium,
                                      TaskPriority.high => localization.high,
                                    }),
                                  ],
                                );
                              }).toList(),
                        ).animate().fade(delay: 300.ms),
                        const Divider(),
                        Text(localization.status_summary, style: theme.textTheme.titleLarge).animate().fade(delay: 500.ms),
                        Wrap(
                          spacing: AppSpacing.m,
                          runSpacing: AppSpacing.s,
                          alignment: WrapAlignment.start,
                          children:
                              state.progression.map((progression) {
                                return Column(
                                  spacing: AppSpacing.s,
                                  children: [
                                    if (progression == null || progression.tasks.isEmpty)
                                      const CircleAvatar(radius: 36, child: Icon(Icons.close))
                                    else
                                      ProgressionItemChart(
                                        width: 70,
                                        height: 70,
                                        items: TaskStatus.values,
                                        builder: (status) {
                                          final count = progression.tasks.where((item) => item.status == status).length;

                                          return PieChartSectionData(
                                            color: status.color.withValues(alpha: 0.8),
                                            borderSide: BorderSide(color: status.color, width: 3),
                                            value: count.toDouble(),
                                            radius: 30,
                                            titlePositionPercentageOffset: 0.55,
                                            title: '$count',
                                            titleStyle: theme.textTheme.titleMedium?.copyWith(color: Colors.white),
                                          );
                                        },
                                      ),
                                    if (progression == null)
                                      const SizedBox.shrink()
                                    else
                                      Text('${progression.startDate.day}-${progression.endDate.day} / ${progression.endDate.month}'),
                                  ],
                                );
                              }).toList(),
                        ).animate().fade(delay: 400.ms),
                        Wrap(
                          spacing: AppSpacing.m,
                          runSpacing: AppSpacing.s,
                          children:
                              TaskStatus.values.map((status) {
                                return Row(
                                  spacing: AppSpacing.xs,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    CircleAvatar(radius: AppSpacing.xs, backgroundColor: status.color),
                                    Text(switch (status) {
                                      TaskStatus.todo => localization.to_do,
                                      TaskStatus.inProgress => localization.in_progress,
                                      TaskStatus.done => localization.done,
                                    }),
                                  ],
                                );
                              }).toList(),
                        ).animate().fade(delay: 400.ms),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget leftTitles(double max, double value, TitleMeta meta) {
    if (value > max) {
      return const SizedBox.shrink();
    }

    final Widget text = Text('${value.toInt()}');

    return SideTitleWidget(meta: meta, space: AppSpacing.s, child: text);
  }

  Widget bottomTitles({required WeeklyTaskProgression? progression, required TitleMeta meta}) {
    if (progression == null) {
      return const SizedBox.shrink();
    }

    final Widget text = Text('${progression.startDate.day}-${progression.endDate.day} / ${progression.startDate.month}');

    return SideTitleWidget(meta: meta, space: AppSpacing.xs, child: text);
  }

  List<BarChartGroupData> _generateBars(List<WeeklyTaskProgression?> progressions) {
    return progressions.asMap().entries.map((entry) {
      final index = entry.key;
      final data = entry.value;

      return BarChartGroupData(
        barsSpace: AppSpacing.xxs,
        x: index,
        barRods:
            data == null
                ? []
                : [
                  BarChartRodData(toY: data.completed.toDouble(), color: Colors.green, width: AppSpacing.xs),
                  BarChartRodData(toY: data.overdue.toDouble(), color: Colors.red, width: AppSpacing.xs),
                  BarChartRodData(toY: data.total.toDouble(), color: Colors.blue, width: AppSpacing.xs),
                ],
      );
    }).toList();
  }
}

enum ProgressionInfo { complete, total, overdue }
