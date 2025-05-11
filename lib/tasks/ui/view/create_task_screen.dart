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
          appBar: AppBar(
            title: BlocBuilder<CreateTaskCubit, CreateTaskState>(
              bloc: bloc,
              buildWhen: (previous, current) => previous.isUpdating != current.isUpdating || previous.isLoading != current.isLoading,
              builder: (context, state) => state.isLoading ? const SizedBox.shrink() : Text('${state.isUpdating ? 'Update' : 'Create'} Task'),
            ),
            actions: [
              BlocSelector<CreateTaskCubit, CreateTaskState, TaskPriority>(
                bloc: bloc,
                selector: (state) => state.priority,
                builder:
                    (context, priority) => AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      width: 24,
                      height: 24,
                      decoration: BoxDecoration(border: Border.all(color: priority.color, width: 3), shape: BoxShape.circle),
                      alignment: Alignment.center,
                      child: Text(priority.title.substring(0, 1), style: TextStyle(color: priority.color, fontWeight: FontWeight.bold, height: 1)),
                    ),
              ),
              const Gap(AppSpacing.xs),
              BlocSelector<CreateTaskCubit, CreateTaskState, TaskStatus>(
                bloc: bloc,
                selector: (state) => state.status,
                builder:
                    (context, status) => AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      width: 21,
                      height: 21,
                      child: CircularProgressIndicator(
                        color: status.color,
                        value: switch (status) {
                          TaskStatus.todo => 0.01,
                          TaskStatus.inProgress => null,
                          TaskStatus.done => 1,
                        },
                      ),
                    ),
              ),
              const Gap(AppSpacing.xs),
            ],
            bottom: PreferredSize(
              preferredSize: const Size(0, 10),
              child: BlocSelector<CreateTaskCubit, CreateTaskState, bool>(
                bloc: bloc,
                selector: (state) => state.isLoading,
                builder: (context, isLoading) => isLoading ? const LinearProgressIndicator() : const SizedBox.shrink(),
              ),
            ),
          ),
          body: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                BlocBuilder<CreateTaskCubit, CreateTaskState>(
                  bloc: bloc,
                  builder:
                      (context, state) =>
                          state.isLoading
                              ? const Expanded(child: SizedBox.shrink())
                              : Expanded(
                                child: CustomScrollView(
                                  slivers: [
                                    SliverPadding(
                                      padding: const EdgeInsets.all(AppSpacing.s),
                                      sliver: SliverToBoxAdapter(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.stretch,
                                          spacing: AppSpacing.s,
                                          children: [
                                            AppTextField(
                                              label: 'Title',
                                              initialValue: state.title,
                                              onChanged: bloc.updateTitle,
                                              textCapitalization: TextCapitalization.words,
                                            ),
                                            AppTextField(
                                              label: 'Description',
                                              initialValue: state.description,
                                              onChanged: bloc.updateDescription,
                                              maxLines: 5,
                                            ),
                                            Row(
                                              spacing: AppSpacing.s,
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Flexible(
                                                  child: DropdownMenu(
                                                    label: const Text('Priority'),
                                                    initialSelection: state.priority,
                                                    inputDecorationTheme: InputDecorationTheme(
                                                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(100)),
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
                                                ),
                                                Flexible(
                                                  child: DropdownMenu(
                                                    label: const Text('Status'),
                                                    initialSelection: state.status,
                                                    inputDecorationTheme: InputDecorationTheme(
                                                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(100)),
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
                                                ),
                                              ],
                                            ),
                                            Text('Due Date and Time', style: theme.textTheme.titleSmall),
                                            Row(
                                              spacing: AppSpacing.s,
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Expanded(
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
                                                      children: [
                                                        const Icon(Icons.calendar_month_outlined),
                                                        const Gap(AppSpacing.xs),
                                                        Text(state.formattedDate),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: FilledButton.tonal(
                                                    onPressed: () async {
                                                      final time = await showTimePicker(context: context, initialTime: state.time);
                                                      bloc.updateTime(time);
                                                    },
                                                    child: Row(
                                                      children: [
                                                        const Icon(Icons.watch_later_outlined),
                                                        const Gap(AppSpacing.xs),
                                                        Text(state.formattedTime),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    SliverPadding(
                                      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s),
                                      sliver: SliverGrid.builder(
                                        itemCount: state.assignableUsers.length,
                                        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                                          maxCrossAxisExtent: 40,
                                          mainAxisSpacing: AppSpacing.s,
                                          crossAxisSpacing: AppSpacing.s,
                                        ),
                                        itemBuilder: (context, position) {
                                          final member = state.assignableUsers[position];
                                          final isAssigned = state.assignedIds.contains(member.id);

                                          return Theme(
                                            data: AppTheme.lightTheme,
                                            child: GestureDetector(
                                              onTap: () => bloc.toggleAssignment(member.id),
                                              child: AnimatedContainer(
                                                duration: const Duration(milliseconds: 300),
                                                decoration: BoxDecoration(
                                                  border: isAssigned ? Border.all(color: theme.colorScheme.primary) : null,
                                                  shape: BoxShape.circle,
                                                ),
                                                child: CircleAvatar(
                                                  backgroundColor: isAssigned ? null : Colors.grey.shade300,
                                                  child: Text('${member.firstName.substring(0, 1)}${member.lastName.substring(0, 1)}'),
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                ),
                const Gap(AppSpacing.s),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s),
                  child: BlocBuilder<CreateTaskCubit, CreateTaskState>(
                    bloc: bloc,
                    buildWhen:
                        (previous, current) => previous.isButtonEnabled != current.isButtonEnabled || previous.isUpdating != current.isUpdating,
                    builder:
                        (context, state) => FilledButton(
                          onPressed: state.isButtonEnabled ? bloc.saveTask : null,
                          child: Text('${state.isUpdating ? 'Update' : 'Create'} Task'),
                        ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _listenNavigationFlow(BuildContext context, CreateTaskState state) async {
    if (state.shouldGoBack) {
      context.pop();
    }
  }
}
