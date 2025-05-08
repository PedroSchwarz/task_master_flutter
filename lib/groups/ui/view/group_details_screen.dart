import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
    return BlocListener<GroupDetailsCubit, GroupDetailsState>(
      bloc: bloc,
      listenWhen: (previous, current) => previous.taskToDelete != current.taskToDelete,
      listener: _listenTaskToDelete,
      child: Scaffold(
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
                          actions: [
                            IconButton(
                              onPressed: bloc.toggleFiltersVisibility,
                              icon: Icon(state.showFilters ? Icons.filter_alt_off : Icons.filter_alt_rounded),
                            ),
                          ],
                          bottom: state.isLoading ? const PreferredSize(preferredSize: Size(0, 0), child: LinearProgressIndicator()) : null,
                        ),
                        if (state.showFilters)
                          AppSliverHeaderWrapper.floating(
                            maxSize: state.userFilter == TaskUserFilter.others ? 176 : 128,
                            child: Column(
                              children: [
                                Row(
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
                                  Row(
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
                                Row(
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
                              ],
                            ),
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
