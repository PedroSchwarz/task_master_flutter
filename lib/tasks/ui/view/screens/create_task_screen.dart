import 'package:flutter/material.dart';
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

    return BlocListener<CreateTaskCubit, CreateTaskState>(
      bloc: bloc,
      listenWhen: (previous, current) => previous.shouldGoBack != current.shouldGoBack,
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
                  buildWhen: (previous, current) => previous.isUpdating != current.isUpdating || previous.isLoading != current.isLoading,
                  builder:
                      (context, state) => state.isLoading ? const Text('Loading Task...') : Text('${state.isUpdating ? 'Update' : 'Create'} Task'),
                ),
                actions: [
                  BlocBuilder<CreateTaskCubit, CreateTaskState>(
                    bloc: bloc,
                    buildWhen: (previous, current) => previous.isLoading != current.isLoading || previous.priority != current.priority,
                    builder:
                        (context, state) => AppSkeleton(
                          isLoading: state.isLoading,
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            width: 24,
                            height: 24,
                            decoration: BoxDecoration(border: Border.all(color: state.priority.color, width: 3), shape: BoxShape.circle),
                            alignment: Alignment.center,
                            child: Text(
                              state.priority.title.substring(0, 1),
                              style: TextStyle(color: state.priority.color, fontWeight: FontWeight.bold, height: 1),
                            ),
                          ),
                        ),
                  ),
                  const Gap(AppSpacing.xs),
                  BlocBuilder<CreateTaskCubit, CreateTaskState>(
                    bloc: bloc,
                    buildWhen: (previous, current) => previous.isLoading != current.isLoading || previous.status != current.status,
                    builder:
                        (context, state) => AppSkeleton(
                          isLoading: state.isLoading,
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            width: 21,
                            height: 21,
                            child: CircularProgressIndicator(
                              color: state.status.color,
                              value: switch (state.status) {
                                TaskStatus.todo => 0.01,
                                TaskStatus.inProgress => null,
                                TaskStatus.done => 1,
                              },
                            ),
                          ),
                        ),
                  ),
                  const Gap(AppSpacing.xs),
                ],
                bottom: PreferredSize(
                  preferredSize: const Size(0, AppSpacing.s),
                  child: BlocSelector<CreateTaskCubit, CreateTaskState, bool>(
                    bloc: bloc,
                    selector: (state) => state.isLoading || state.isSubmitting,
                    builder: (context, isLoading) => isLoading ? const LinearProgressIndicator() : const SizedBox.shrink(),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(AppSpacing.s, AppSpacing.s, AppSpacing.s, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    spacing: AppSpacing.s,
                    children: [
                      BlocBuilder<CreateTaskCubit, CreateTaskState>(
                        bloc: bloc,
                        buildWhen:
                            (previous, current) =>
                                previous.isLoading != current.isLoading || //
                                previous.title != current.title,
                        builder: (context, state) {
                          return AppSkeleton(
                            isLoading: state.isLoading,
                            child: AppTextField(
                              label: 'Title',
                              initialValue: state.title,
                              onChanged: bloc.updateTitle,
                              textCapitalization: TextCapitalization.words,
                            ),
                          );
                        },
                      ),
                      BlocBuilder<CreateTaskCubit, CreateTaskState>(
                        bloc: bloc,
                        buildWhen:
                            (previous, current) =>
                                previous.isLoading != current.isLoading || //
                                previous.description != current.description,
                        builder: (context, state) {
                          return AppSkeleton(
                            isLoading: state.isLoading,
                            child: AppTextField(
                              label: 'Description',
                              initialValue: state.description,
                              onChanged: bloc.updateDescription,
                              maxLines: 5,
                            ),
                          );
                        },
                      ),
                      const Gap(AppSpacing.xs),
                      Row(
                        spacing: AppSpacing.s,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: BlocBuilder<CreateTaskCubit, CreateTaskState>(
                              bloc: bloc,
                              buildWhen:
                                  (previous, current) =>
                                      previous.isLoading != current.isLoading || //
                                      previous.priority != current.priority,
                              builder: (context, state) {
                                return AppSkeleton(
                                  isLoading: state.isLoading,
                                  child: DropdownMenu(
                                    label: const Text('Priority'),
                                    initialSelection: state.priority,
                                    inputDecorationTheme: InputDecorationTheme(
                                      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(100)),
                                      isCollapsed: true,
                                      contentPadding: const EdgeInsets.symmetric(horizontal: AppSpacing.s),
                                    ),
                                    menuStyle: MenuStyle(
                                      backgroundColor: WidgetStateProperty.all(theme.scaffoldBackgroundColor),
                                      shape: WidgetStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
                                    ),
                                    onSelected: bloc.updatePriority,
                                    dropdownMenuEntries:
                                        TaskPriority.values
                                            .map(
                                              (priority) => DropdownMenuEntry(
                                                value: priority,
                                                label: priority.title,
                                                leadingIcon: Icon(priority.icon, color: priority.color),
                                              ),
                                            )
                                            .toList(),
                                  ),
                                );
                              },
                            ),
                          ),
                          Flexible(
                            child: BlocBuilder<CreateTaskCubit, CreateTaskState>(
                              bloc: bloc,
                              buildWhen:
                                  (previous, current) =>
                                      previous.isLoading != current.isLoading || //
                                      previous.status != current.status,
                              builder: (context, state) {
                                return AppSkeleton(
                                  isLoading: state.isLoading,
                                  child: DropdownMenu(
                                    label: const Text('Status'),
                                    initialSelection: state.status,
                                    inputDecorationTheme: InputDecorationTheme(
                                      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(100)),
                                      isCollapsed: true,
                                      contentPadding: const EdgeInsets.symmetric(horizontal: AppSpacing.s),
                                    ),
                                    menuStyle: MenuStyle(
                                      backgroundColor: WidgetStateProperty.all(theme.scaffoldBackgroundColor),
                                      shape: WidgetStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
                                    ),
                                    onSelected: bloc.updateStatus,
                                    dropdownMenuEntries:
                                        TaskStatus.values
                                            .map(
                                              (status) => DropdownMenuEntry(
                                                value: status,
                                                label: status.title,
                                                leadingIcon: Icon(status.icon, color: status.color),
                                              ),
                                            )
                                            .toList(),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                      Text('Due Date and Time', style: theme.textTheme.titleMedium),
                      Row(
                        spacing: AppSpacing.s,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: BlocBuilder<CreateTaskCubit, CreateTaskState>(
                              bloc: bloc,
                              buildWhen:
                                  (previous, current) =>
                                      previous.isLoading != current.isLoading || //
                                      previous.date != current.date,
                              builder: (context, state) {
                                return AppSkeleton(
                                  isLoading: state.isLoading,
                                  child: FilledButton(
                                    onPressed: () async {
                                      final date = await showDatePicker(
                                        context: context,
                                        initialDate: state.date,
                                        firstDate: DateTime.now(),
                                        lastDate: DateTime.now().add(const Duration(days: 365)),
                                      );
                                      bloc.updateDate(date);
                                    },
                                    child: Row(
                                      children: [const Icon(Icons.calendar_month_outlined), const Gap(AppSpacing.xs), Text(state.formattedDate)],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          Expanded(
                            child: BlocBuilder<CreateTaskCubit, CreateTaskState>(
                              bloc: bloc,
                              buildWhen:
                                  (previous, current) =>
                                      previous.isLoading != current.isLoading || //
                                      previous.time != current.time,
                              builder: (context, state) {
                                return AppSkeleton(
                                  isLoading: state.isLoading,
                                  child: FilledButton.tonal(
                                    onPressed: () async {
                                      final time = await showTimePicker(context: context, initialTime: state.time);
                                      bloc.updateTime(time);
                                    },
                                    child: Row(
                                      children: [const Icon(Icons.watch_later_outlined), const Gap(AppSpacing.xs), Text(state.formattedTime)],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                      const Divider(),
                      Text('Assigne to', style: theme.textTheme.titleMedium),
                    ],
                  ),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.all(AppSpacing.s),
                sliver: BlocBuilder<CreateTaskCubit, CreateTaskState>(
                  bloc: bloc,
                  buildWhen:
                      (previous, current) =>
                          previous.assignableUsers != current.assignableUsers || //
                          previous.assignedIds != current.assignedIds,
                  builder: (context, state) {
                    final assignableUsers = state.assignableUsers;
                    final assignedIds = state.assignedIds;
                    final isLoading = assignableUsers.isEmpty;

                    return SliverGrid.builder(
                      itemCount: isLoading ? 5 : assignableUsers.length,
                      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 40,
                        mainAxisSpacing: AppSpacing.s,
                        crossAxisSpacing: AppSpacing.s,
                      ),
                      itemBuilder: (context, position) {
                        if (isLoading) {
                          return const AppSkeleton(isLoading: true, radius: AppSpacing.max, child: CircleAvatar(child: Text('')));
                        }

                        final member = assignableUsers[position];
                        final isAssigned = assignedIds.contains(member.id);

                        return GestureDetector(
                          onTap: () => bloc.toggleAssignment(member.id),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            decoration: BoxDecoration(
                              border: isAssigned ? Border.all(color: theme.colorScheme.primary) : null,
                              shape: BoxShape.circle,
                            ),
                            child: CircleAvatar(
                              backgroundColor: isAssigned ? null : theme.colorScheme.surfaceContainer,
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
                    padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s),
                    child: BlocBuilder<CreateTaskCubit, CreateTaskState>(
                      bloc: bloc,
                      buildWhen:
                          (previous, current) =>
                              previous.canSubmit != current.canSubmit || //
                              previous.isUpdating != current.isUpdating,
                      builder: (context, state) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            FilledButton(
                              onPressed: state.canSubmit ? bloc.saveTask : null,
                              child: Text('${state.isUpdating ? 'Update' : 'Create'} Task'),
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

  Future<void> _listenNavigationFlow(BuildContext context, CreateTaskState state) async {
    if (state.shouldGoBack) {
      context.pop(true);
    }
  }
}
