import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:task_master/app/app.dart';
import 'package:task_master/tasks/data/models/task_values.dart';
import 'package:task_master/tasks/ui/cubit/create_task_cubit.dart';

class CreateTaskScreen extends StatefulWidget {
  const CreateTaskScreen({required this.groupId, this.taskId, super.key});

  static const String routeName = 'tasks/create';
  final String groupId;
  final String? taskId;

  @override
  State<CreateTaskScreen> createState() => _CreateTaskScreenState();
}

class _CreateTaskScreenState extends State<CreateTaskScreen> {
  final bloc = getIt<CreateTaskCubit>();

  @override
  void initState() {
    super.initState();
    bloc.load(groupId: widget.groupId, taskId: widget.taskId);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final localization = context.localization;

    return BlocListener<CreateTaskCubit, CreateTaskState>(
      bloc: bloc,
      listenWhen: (previous, current) =>
          previous.shouldGoBack != current.shouldGoBack,
      listener: _listenNavigationFlow,
      child: GestureDetector(
        onTap: () {
          final focus = FocusScope.of(context);
          if (!focus.hasPrimaryFocus) {
            focus.unfocus();
          }
        },
        child: Scaffold(
          body: CustomScrollView(
            slivers: [
              SliverAppBar.medium(
                title: BlocBuilder<CreateTaskCubit, CreateTaskState>(
                  bloc: bloc,
                  buildWhen: (previous, current) =>
                      previous.isUpdating != current.isUpdating ||
                      previous.isLoading != current.isLoading,
                  builder: (context, state) {
                    return AppSkeleton(
                      isLoading: state.isLoading,
                      child: Text(
                        state.isUpdating
                            ? localization.update_task
                            : localization.create_task,
                      ),
                    );
                  },
                ),
                bottom: PreferredSize(
                  preferredSize: const Size(0, AppSpacing.s),
                  child: BlocSelector<CreateTaskCubit, CreateTaskState, bool>(
                    bloc: bloc,
                    selector: (state) => state.isLoading || state.isSubmitting,
                    builder: (context, isLoading) => isLoading
                        ? const LinearProgressIndicator()
                        : const SizedBox.shrink(),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const .fromLTRB(
                    AppSpacing.s,
                    AppSpacing.s,
                    AppSpacing.s,
                    0,
                  ),
                  child: Column(
                    crossAxisAlignment: .stretch,
                    spacing: AppSpacing.s,
                    children: [
                      BlocBuilder<CreateTaskCubit, CreateTaskState>(
                        bloc: bloc,
                        buildWhen: (previous, current) =>
                            previous.isLoading != current.isLoading || //
                            previous.title != current.title,
                        builder: (context, state) {
                          return AppSkeleton(
                            isLoading: state.isLoading,
                            child: AppTextField(
                              label: localization.title,
                              initialValue: state.title,
                              onChanged: bloc.updateTitle,
                              textCapitalization: .words,
                            ),
                          );
                        },
                      ),
                      BlocBuilder<CreateTaskCubit, CreateTaskState>(
                        bloc: bloc,
                        buildWhen: (previous, current) =>
                            previous.isLoading != current.isLoading || //
                            previous.description != current.description,
                        builder: (context, state) {
                          return AppSkeleton(
                            isLoading: state.isLoading,
                            child: AppTextField(
                              label: localization.description,
                              initialValue: state.description,
                              onChanged: bloc.updateDescription,
                              maxLines: 5,
                              keyboardType: .multiline,
                              textInputAction: .newline,
                            ),
                          );
                        },
                      ),
                      BlocBuilder<CreateTaskCubit, CreateTaskState>(
                        bloc: bloc,
                        buildWhen: (previous, current) =>
                            previous.isLoading != current.isLoading || //
                            previous.checklist != current.checklist,
                        builder: (context, state) {
                          return AppSkeleton(
                            isLoading: state.isLoading,
                            child: ReorderableListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              header: Row(
                                mainAxisAlignment: .spaceBetween,
                                children: [
                                  Text(
                                    localization.checklist,
                                    style: theme.textTheme.titleMedium,
                                  ),
                                  IconButton(
                                    onPressed: bloc.addChecklistItem,
                                    color: theme.colorScheme.primary,
                                    icon: const Icon(Icons.add),
                                  ),
                                ],
                              ),
                              footer: state.checklist.isNotEmpty
                                  ? const Gap(AppSpacing.s)
                                  : null,
                              proxyDecorator: (child, index, animation) {
                                return Material(
                                  elevation: AppSpacing.xxs,
                                  color: theme.colorScheme.surfaceContainer,
                                  shadowColor: Colors.black45,
                                  borderRadius: .circular(
                                    AppSpacing.s,
                                  ),
                                  child: child,
                                );
                              },
                              shrinkWrap: true,
                              itemCount: state.checklist.length,
                              onReorder: bloc.reorderChecklistItem,
                              itemBuilder: (context, position) {
                                final item = state.checklist[position];

                                return Container(
                                  key: ValueKey(item.id),
                                  padding: const .all(AppSpacing.xs),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: AppTextField(
                                          label: 'Item ${item.order + 1}',
                                          initialValue: item.title,
                                          onChanged: (value) {
                                            bloc.updateChecklistItem(
                                              index: position,
                                              value: value,
                                            );
                                          },
                                        ),
                                      ),
                                      IconButton(
                                        color: Colors.red,
                                        onPressed: () {
                                          bloc.removeChecklistItem(
                                            index: position,
                                          );
                                        },
                                        icon: const Icon(Icons.delete),
                                      ),
                                      const Icon(Icons.drag_handle),
                                    ],
                                  ).animate().fade(delay: 100.ms),
                                );
                              },
                            ),
                          );
                        },
                      ),
                      Row(
                        spacing: AppSpacing.s,
                        mainAxisAlignment: .spaceBetween,
                        children: [
                          Flexible(
                            child: LayoutBuilder(
                              builder: (context, constraints) {
                                return BlocBuilder<
                                  CreateTaskCubit,
                                  CreateTaskState
                                >(
                                  bloc: bloc,
                                  buildWhen: (previous, current) =>
                                      previous.isLoading !=
                                          current.isLoading || //
                                      previous.priority != current.priority,
                                  builder: (context, state) {
                                    return AppSkeleton(
                                      isLoading: state.isLoading,
                                      child: DropdownMenu(
                                        width: constraints.maxWidth,
                                        label: Row(
                                          spacing: AppSpacing.xs,
                                          mainAxisSize: .min,
                                          children: [
                                            Icon(
                                              state.priority.icon,
                                              color: state.priority.color,
                                            ),
                                            Flexible(
                                              child: Text(
                                                localization.priority,
                                              ),
                                            ),
                                          ],
                                        ),
                                        initialSelection: state.priority,
                                        inputDecorationTheme:
                                            InputDecorationTheme(
                                              enabledBorder: OutlineInputBorder(
                                                borderRadius: .circular(100),
                                              ),
                                              isCollapsed: true,
                                              contentPadding: .symmetric(
                                                horizontal: AppSpacing.s,
                                                vertical: Platform.isMacOS
                                                    ? AppSpacing.m
                                                    : 0,
                                              ),
                                            ),
                                        menuStyle: MenuStyle(
                                          backgroundColor: .all(
                                            theme.scaffoldBackgroundColor,
                                          ),
                                          shape: .all(
                                            RoundedRectangleBorder(
                                              borderRadius: .circular(20),
                                            ),
                                          ),
                                        ),
                                        onSelected: bloc.updatePriority,
                                        dropdownMenuEntries: TaskPriority.values
                                            .map(
                                              (priority) => DropdownMenuEntry(
                                                value: priority,
                                                label: switch (priority) {
                                                  .low => localization.low,
                                                  .medium =>
                                                    localization.medium,
                                                  .high => localization.high,
                                                },
                                                leadingIcon: Icon(
                                                  priority.icon,
                                                  color: priority.color,
                                                ),
                                                style: ButtonStyle(
                                                  padding: .all(null),
                                                ),
                                              ),
                                            )
                                            .toList(),
                                      ),
                                    );
                                  },
                                );
                              },
                            ),
                          ),
                          Flexible(
                            child: LayoutBuilder(
                              builder: (context, constraints) {
                                return BlocBuilder<
                                  CreateTaskCubit,
                                  CreateTaskState
                                >(
                                  bloc: bloc,
                                  buildWhen: (previous, current) =>
                                      previous.isLoading !=
                                          current.isLoading || //
                                      previous.status != current.status,
                                  builder: (context, state) {
                                    return AppSkeleton(
                                      isLoading: state.isLoading,
                                      child: DropdownMenu(
                                        width: constraints.maxWidth,
                                        label: Row(
                                          spacing: AppSpacing.xs,
                                          mainAxisSize: .min,
                                          children: [
                                            Icon(
                                              state.status.icon,
                                              color: state.status.color,
                                            ),
                                            const Flexible(
                                              child: Text('Status'),
                                            ),
                                          ],
                                        ),
                                        initialSelection: state.status,
                                        inputDecorationTheme:
                                            InputDecorationTheme(
                                              enabledBorder: OutlineInputBorder(
                                                borderRadius: .circular(100),
                                              ),
                                              isCollapsed: true,
                                              contentPadding: .symmetric(
                                                horizontal: AppSpacing.s,
                                                vertical: Platform.isMacOS
                                                    ? AppSpacing.m
                                                    : 0,
                                              ),
                                            ),
                                        menuStyle: MenuStyle(
                                          backgroundColor: .all(
                                            theme.scaffoldBackgroundColor,
                                          ),
                                          shape: .all(
                                            RoundedRectangleBorder(
                                              borderRadius: .circular(20),
                                            ),
                                          ),
                                        ),
                                        onSelected: bloc.updateStatus,
                                        dropdownMenuEntries: TaskStatus.values
                                            .map(
                                              (status) => DropdownMenuEntry(
                                                value: status,
                                                label: switch (status) {
                                                  .todo => localization.to_do,
                                                  .inProgress =>
                                                    localization.in_progress,
                                                  .done => localization.done,
                                                },
                                                leadingIcon: Icon(
                                                  status.icon,
                                                  color: status.color,
                                                ),
                                                style: ButtonStyle(
                                                  padding: .all(null),
                                                ),
                                              ),
                                            )
                                            .toList(),
                                      ),
                                    );
                                  },
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                      Text(
                        localization.due_date_time,
                        style: theme.textTheme.titleMedium,
                      ),
                      Row(
                        spacing: AppSpacing.s,
                        mainAxisAlignment: .spaceBetween,
                        children: [
                          Expanded(
                            child:
                                BlocBuilder<CreateTaskCubit, CreateTaskState>(
                                  bloc: bloc,
                                  buildWhen: (previous, current) =>
                                      previous.isLoading !=
                                          current.isLoading || //
                                      previous.date != current.date,
                                  builder: (context, state) {
                                    return AppSkeleton(
                                      isLoading: state.isLoading,
                                      child: FilledButton(
                                        onPressed: () async {
                                          final date = await showDatePicker(
                                            context: context,
                                            initialDate: state.date,
                                            firstDate:
                                                DateTime.now().isAfter(
                                                  state.date,
                                                )
                                                ? state.date
                                                : DateTime.now(),
                                            lastDate: DateTime.now().add(
                                              const Duration(days: 365),
                                            ),
                                          );
                                          bloc.updateDate(date);
                                        },
                                        child: Row(
                                          mainAxisAlignment: .center,
                                          children: [
                                            const Icon(
                                              Icons.calendar_month_outlined,
                                            ),
                                            const Gap(AppSpacing.xs),
                                            Flexible(
                                              child: Text(state.formattedDate),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                          ),
                          Expanded(
                            child:
                                BlocBuilder<CreateTaskCubit, CreateTaskState>(
                                  bloc: bloc,
                                  buildWhen: (previous, current) =>
                                      previous.isLoading !=
                                          current.isLoading || //
                                      previous.time != current.time,
                                  builder: (context, state) {
                                    return AppSkeleton(
                                      isLoading: state.isLoading,
                                      child: FilledButton.tonal(
                                        onPressed: () async {
                                          final time = await showTimePicker(
                                            context: context,
                                            initialTime: state.time,
                                          );
                                          bloc.updateTime(time);
                                        },
                                        child: Row(
                                          mainAxisAlignment: .center,
                                          children: [
                                            const Icon(
                                              Icons.watch_later_outlined,
                                            ),
                                            const Gap(AppSpacing.xs),
                                            Flexible(
                                              child: Text(state.formattedTime),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: .stretch,
                        children: [
                          BlocBuilder<CreateTaskCubit, CreateTaskState>(
                            bloc: bloc,
                            buildWhen: (previous, current) =>
                                previous.isLoading != current.isLoading || //
                                previous.recurring != current.recurring,
                            builder: (context, state) {
                              return AppSkeleton(
                                isLoading: state.isLoading,
                                child: Row(
                                  spacing: AppSpacing.s,
                                  mainAxisSize: .max,
                                  mainAxisAlignment: .spaceBetween,
                                  children: [
                                    Text(
                                      localization.recurring,
                                      style: theme.textTheme.titleMedium,
                                    ),
                                    Switch(
                                      value: state.recurring,
                                      onChanged: bloc.updateRecurring,
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                          BlocBuilder<CreateTaskCubit, CreateTaskState>(
                            bloc: bloc,
                            buildWhen: (previous, current) =>
                                previous.isLoading != current.isLoading || //
                                previous.recurring != current.recurring || //
                                previous.recurrencePattern !=
                                    current.recurrencePattern,
                            builder: (context, state) {
                              if (state.recurring) {
                                return AppSkeleton(
                                  isLoading: state.isLoading,
                                  child: Padding(
                                    padding: const .only(
                                      top: AppSpacing.xs,
                                    ),
                                    child: Wrap(
                                      spacing: AppSpacing.xs,
                                      runSpacing: AppSpacing.xs,
                                      children: TaskRecurrence.values.map((
                                        pattern,
                                      ) {
                                        return ChoiceChip(
                                          label: Text(switch (pattern) {
                                            .daily =>
                                              localization.recurrence_daily,
                                            .weekly =>
                                              localization.recurrence_weekly,
                                            .monthly =>
                                              localization.recurrence_monthly,
                                          }, style: theme.textTheme.bodyLarge),
                                          selected:
                                              state.recurrencePattern ==
                                              pattern,
                                          onSelected: (value) {
                                            bloc.updatePattern(pattern);
                                          },
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                );
                              }
                              return const SizedBox.shrink();
                            },
                          ),
                          BlocBuilder<CreateTaskCubit, CreateTaskState>(
                            bloc: bloc,
                            buildWhen: (previous, current) =>
                                previous.isLoading != current.isLoading || //
                                previous.recurring != current.recurring || //
                                previous.recurrenceEndDate !=
                                    current.recurrenceEndDate,
                            builder: (context, state) {
                              if (state.recurring) {
                                return AppSkeleton(
                                  isLoading: state.isLoading,
                                  child: Padding(
                                    padding: const .only(
                                      top: AppSpacing.s,
                                    ),
                                    child: OutlinedButton(
                                      onPressed: () async {
                                        final date = await showDatePicker(
                                          context: context,
                                          initialDate: DateTime.now(),
                                          firstDate: DateTime.now(),
                                          lastDate: DateTime.now().add(
                                            const Duration(days: 365),
                                          ),
                                        );
                                        bloc.updateRecurrenceEndDate(date);
                                      },
                                      child: Text(
                                        '${localization.ending_on}: ${state.formattedRecurrenceEndDate ?? localization.never}',
                                        style: theme.textTheme.bodyLarge
                                            ?.copyWith(
                                              color: theme.colorScheme.primary,
                                            ),
                                      ),
                                    ),
                                  ),
                                );
                              }
                              return const SizedBox.shrink();
                            },
                          ),
                        ],
                      ),
                      const Divider(),
                      Text(
                        localization.assign_to,
                        style: theme.textTheme.titleMedium,
                      ),
                    ],
                  ),
                ),
              ),
              SliverPadding(
                padding: const .only(
                  top: AppSpacing.s,
                  left: AppSpacing.s,
                  right: AppSpacing.s,
                  bottom: AppSpacing.l,
                ),
                sliver: BlocBuilder<CreateTaskCubit, CreateTaskState>(
                  bloc: bloc,
                  buildWhen: (previous, current) =>
                      previous.assignableUsers != current.assignableUsers || //
                      previous.assignedIds != current.assignedIds,
                  builder: (context, state) {
                    final assignableUsers = state.assignableUsers;
                    final assignedIds = state.assignedIds;
                    final isLoading = assignableUsers.isEmpty;

                    return SliverGrid.builder(
                      itemCount: isLoading ? 5 : assignableUsers.length,
                      gridDelegate:
                          const SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 40,
                            mainAxisSpacing: AppSpacing.s,
                            crossAxisSpacing: AppSpacing.s,
                          ),
                      itemBuilder: (context, position) {
                        if (isLoading) {
                          return const AppSkeleton(
                            isLoading: true,
                            radius: AppSpacing.max,
                            child: CircleAvatar(child: Text('')),
                          );
                        }

                        final member = assignableUsers[position];
                        final isAssigned = assignedIds.contains(member.id);

                        return GestureDetector(
                          onTap: () => bloc.toggleAssignment(member.id),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            decoration: BoxDecoration(
                              border: isAssigned
                                  ? .all(color: theme.colorScheme.primary)
                                  : null,
                              shape: .circle,
                            ),
                            child: CircleAvatar(
                              backgroundColor: isAssigned
                                  ? null
                                  : theme.colorScheme.surfaceContainer,
                              child: Text(member.initials),
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
              SliverFillRemaining(
                hasScrollBody: false,
                child: SafeArea(
                  top: false,
                  child: Padding(
                    padding: .fromLTRB(
                      AppSpacing.s,
                      AppSpacing.s,
                      AppSpacing.s,
                      Platform.isMacOS ? AppSpacing.s : 0,
                    ),
                    child: BlocBuilder<CreateTaskCubit, CreateTaskState>(
                      bloc: bloc,
                      buildWhen: (previous, current) =>
                          previous.canSubmit != current.canSubmit || //
                          previous.isUpdating != current.isUpdating,
                      builder: (context, state) {
                        return Column(
                          crossAxisAlignment: .stretch,
                          mainAxisAlignment: .end,
                          children: [
                            FilledButton(
                              onPressed: state.canSubmit ? bloc.saveTask : null,
                              child: Text(
                                state.isUpdating
                                    ? localization.update
                                    : localization.create,
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _listenNavigationFlow(
    BuildContext context,
    CreateTaskState state,
  ) async {
    if (state.shouldGoBack) {
      context.pop(true);
    }
  }
}
