import 'package:calendar_pager/calendar_pager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:task_master/app/app.dart';
import 'package:task_master/groups/ui/cubit/group_details_cubit.dart';
import 'package:task_master/groups/ui/view/group_details_filters.dart';
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
      child: BlocBuilder<GroupDetailsCubit, GroupDetailsState>(
        bloc: bloc,
        builder:
            (context, state) => Scaffold(
              appBar: AppBar(
                title: Text(title),
                bottom: state.isLoading ? const PreferredSize(preferredSize: Size(0, 10), child: LinearProgressIndicator()) : null,
              ),
              endDrawer: Drawer(
                child: GroupDetailsFilters(
                  listView: state.listView,
                  userFilter: state.userFilter,
                  completionFilter: state.completionFilter,
                  statusFilter: state.statusFilter,
                  priorityFilter: state.priorityFilter,
                  dateSort: state.dateSort,
                  prioritySort: state.prioritySort,
                  assignedUsers: state.assignedUsers,
                  userToFilterBy: state.userToFilterBy,
                  toggleListView: bloc.toggleListView,
                  updateUserFilter: bloc.updateUserFilter,
                  updateUserToFilterBy: bloc.updateUserToFilterBy,
                  updateCompletionFilter: bloc.updateCompletionFilter,
                  updateStatusFilter: bloc.updateStatusFilter,
                  updatePriorityFilter: bloc.updatePriorityFilter,
                  updateDateSort: bloc.updateDateSort,
                  updatePrioritySort: bloc.updatePrioritySort,
                  resetFiltersAndSort: bloc.resetFiltersAndSort,
                ),
              ),
              body: RefreshIndicator(
                onRefresh: () async {
                  await bloc.load(groupId: widget.id);
                },
                child: CustomScrollView(
                  slivers: [
                    if (state.isCalendarView)
                      AppSliverHeaderWrapper.floating(
                        maxSize: 112,
                        padding: 0,
                        child: Container(
                          clipBehavior: Clip.antiAlias,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(AppSpacing.m), bottomRight: Radius.circular(AppSpacing.m)),
                          ),
                          child: CalendarPagerView(
                            theme: CalendarPagerTheme.from(
                              background: theme.scaffoldBackgroundColor,
                              accent: AppTheme.darkTheme.colorScheme.primaryContainer,
                              headerTitle: theme.textTheme.headlineLarge!,
                              itemBorder: AppTheme.darkTheme.colorScheme.primaryContainer,
                              onAccent: AppTheme.darkTheme.colorScheme.onPrimaryContainer,
                            ),
                            hasHeader: false,
                            onDateSelected: bloc.updateSelectedDate,
                          ),
                        ),
                      ),
                    if (state.tasks.isEmpty)
                      const SliverFillRemaining(child: Padding(padding: EdgeInsets.all(AppSpacing.s), child: TaskContentUnavailable()))
                    else if (state.filteredTasks.isEmpty)
                      const SliverFillRemaining(child: Padding(padding: EdgeInsets.all(AppSpacing.s), child: TaskFilteredContentUnavailable()))
                    else
                      SliverList.separated(
                        itemCount: state.filteredTasks.length,
                        itemBuilder: (context, position) {
                          final task = state.filteredTasks[position];
                          return TaskItem(
                            task: task,
                            canDelete: bloc.getTaskOwnership(task),
                            onTap: () async {
                              await context.pushNamed(TaskDetailsScreen.routeName, pathParameters: {'id': task.id});
                              bloc.loadTasks(groupId: widget.id);
                            },
                            onComplete: bloc.toggleTaskStatus,
                            onPending: bloc.toggleTaskStatus,
                            onDelete: bloc.setTaskToDelete,
                          );
                        },
                        separatorBuilder: (context, position) => const Divider(),
                      ),
                    const SliverToBoxAdapter(child: Gap(AppSpacing.max)),
                  ],
                ),
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
      ),
    );
  }

  void _listenTaskToDelete(BuildContext context, GroupDetailsState state) {
    final task = state.taskToDelete;

    if (task != null) {
      showDialog(
        barrierDismissible: false,
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
