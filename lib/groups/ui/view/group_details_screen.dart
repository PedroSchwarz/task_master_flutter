import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:task_master/app/app.dart';
import 'package:task_master/groups/ui/cubit/group_details_cubit.dart';
import 'package:task_master/tasks/tasks.dart';

class GroupDetailsScreen extends StatefulWidget {
  const GroupDetailsScreen({required this.id, required this.name, super.key});

  static const String routeName = 'group';

  final String id;
  final String name;

  @override
  State<GroupDetailsScreen> createState() => _GroupDetailsScreenState();
}

class _GroupDetailsScreenState extends State<GroupDetailsScreen> {
  final bloc = getIt<GroupDetailsCubit>();
  late final String title;

  @override
  void initState() {
    super.initState();
    title = widget.name;
    bloc.load(groupId: widget.id);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocListener<GroupDetailsCubit, GroupDetailsState>(
      bloc: bloc,
      listenWhen: (previous, current) => previous.taskToDelete != current.taskToDelete,
      listener: _listenTaskToDelete,
      child: Scaffold(
        endDrawer: BlocBuilder<GroupDetailsCubit, GroupDetailsState>(
          bloc: bloc,
          builder:
              (context, state) => Drawer(
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(AppSpacing.m, AppSpacing.m, AppSpacing.m, 0),
                    child: Column(
                      spacing: AppSpacing.s,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Text('Assignee', style: theme.textTheme.titleLarge),
                                const Divider(),
                                Wrap(
                                  spacing: AppSpacing.xs,
                                  children:
                                      TaskUserFilter.values
                                          .map(
                                            (filter) => FilterChip(
                                              selected: state.userFilter == filter,
                                              label: Text(filter.title),
                                              onSelected: (value) {
                                                bloc.updateUserFilter(filter, value: value);
                                              },
                                            ),
                                          )
                                          .toList(),
                                ),
                                if (state.userFilter == TaskUserFilter.others)
                                  Wrap(
                                    spacing: AppSpacing.xs,
                                    children:
                                        state.assignedUsers
                                            .map(
                                              (user) => FilterChip(
                                                selected: state.userToFilterBy == user,
                                                label: Text(user.lastName),
                                                onSelected: (value) {
                                                  bloc.updateUserToFilterBy(user);
                                                },
                                                avatar: state.userToFilterBy == user ? null : CircleAvatar(child: Text(user.firstName[0])),
                                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
                                              ),
                                            )
                                            .toList(),
                                  ),
                                const Gap(AppSpacing.s),
                                Text('Completion', style: theme.textTheme.titleLarge),
                                const Divider(),
                                Wrap(
                                  spacing: AppSpacing.xs,
                                  children:
                                      TaskCompletionFilter.values
                                          .map(
                                            (filter) => FilterChip(
                                              selected: state.completionFilter == filter,
                                              label: Text(filter.title),
                                              onSelected: (value) {
                                                bloc.updateCompletionFilter(filter, value: value);
                                              },
                                            ),
                                          )
                                          .toList(),
                                ),
                                const Gap(AppSpacing.s),
                                Text('Status', style: theme.textTheme.titleLarge),
                                const Divider(),
                                Wrap(
                                  spacing: AppSpacing.xs,
                                  children:
                                      TaskStatusFilter.values
                                          .map(
                                            (filter) => FilterChip(
                                              selected: state.statusFilter == filter,
                                              label: Text(filter.title),
                                              onSelected: (value) {
                                                bloc.updateStatusFilter(filter, value: value);
                                              },
                                            ),
                                          )
                                          .toList(),
                                ),
                                const Gap(AppSpacing.s),
                                Text('Priority', style: theme.textTheme.titleLarge),
                                const Divider(),
                                Wrap(
                                  spacing: AppSpacing.xs,
                                  children:
                                      TaskPriorityFilter.values
                                          .map(
                                            (filter) => FilterChip(
                                              selected: state.priorityFilter == filter,
                                              label: Text(filter.title),
                                              onSelected: (value) {
                                                bloc.updatePriorityFilter(filter, value: value);
                                              },
                                            ),
                                          )
                                          .toList(),
                                ),
                                const Gap(AppSpacing.s),
                                Text('Sort Date', style: theme.textTheme.titleLarge),
                                const Divider(),
                                Wrap(
                                  spacing: AppSpacing.xs,
                                  children:
                                      TaskDateSort.values
                                          .map(
                                            (sort) => FilterChip(
                                              selected: state.dateSort == sort,
                                              label: Text(sort.title),
                                              onSelected: (value) {
                                                bloc.updateDateSort(sort, value: value);
                                              },
                                            ),
                                          )
                                          .toList(),
                                ),
                                const Gap(AppSpacing.s),
                                Text('Sort Priority', style: theme.textTheme.titleLarge),
                                const Divider(),
                                Wrap(
                                  spacing: AppSpacing.xs,
                                  children:
                                      TaskPrioritySort.values
                                          .map(
                                            (sort) => FilterChip(
                                              selected: state.prioritySort == sort,
                                              label: Text(sort.title),
                                              onSelected: (value) {
                                                bloc.updatePrioritySort(sort, value: value);
                                              },
                                            ),
                                          )
                                          .toList(),
                                ),
                              ],
                            ),
                          ),
                        ),
                        FilledButton(onPressed: bloc.resetFiltersAndSort, child: const Text('Reset')),
                      ],
                    ),
                  ),
                ),
              ),
        ),
        body: Column(
          children: [
            BlocBuilder<GroupDetailsCubit, GroupDetailsState>(
              bloc: bloc,
              builder:
                  (context, state) => Expanded(
                    child: CustomScrollView(
                      slivers: [
                        SliverAppBar(
                          pinned: true,
                          title: Text(title),
                          bottom: state.isLoading ? const PreferredSize(preferredSize: Size(0, 0), child: LinearProgressIndicator()) : null,
                        ),
                        SliverList.separated(
                          itemCount: state.filteredTasks.length,
                          itemBuilder: (context, position) {
                            final task = state.filteredTasks[position];
                            return TaskItem(
                              task: task,
                              onTap: () {},
                              onComplete: () async {
                                await bloc.toggleTaskStatus(task);
                                return false;
                              },
                              onPending: () async {
                                await bloc.toggleTaskStatus(task);
                                return false;
                              },
                              onDelete: () async {
                                bloc.setTaskToDelete(task);
                                return false;
                              },
                            );
                          },
                          separatorBuilder: (context, position) => const Divider(),
                        ),
                        const SliverToBoxAdapter(child: Gap(AppSpacing.max)),
                      ],
                    ),
                  ),
            ),
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () async {
            if (context.mounted) {
              await context.pushNamed(CreateTaskScreen.routeName, pathParameters: {'id': widget.id});
              bloc.loadTasks(groupId: widget.id);
            }
          },
          label: const Text('Create task'),
          icon: const Icon(Icons.add),
        ),
      ),
    );
  }

  void _listenTaskToDelete(BuildContext context, GroupDetailsState state) {
    final task = state.taskToDelete;

    if (task != null) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Delete ${task.title}?'),
            content: const Text('This action cannot be undone.'),
            actions: [
              TextButton(onPressed: () => bloc.setTaskToDelete(null), child: const Text('Cancel', textAlign: TextAlign.end)),
              TextButton(onPressed: () => bloc.deleteTask(task), child: const Text('Delete', textAlign: TextAlign.end)),
            ],
          );
        },
      );
    } else {
      context.pop();
    }
  }
}
