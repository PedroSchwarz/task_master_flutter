import 'package:calendar_pager/calendar_pager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:task_master/app/app.dart';
import 'package:task_master/groups/ui/cubit/group_details_cubit.dart';
import 'package:task_master/groups/ui/view/drawer/group_details_filters_drawer.dart';
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
  void dispose() {
    bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocListener<GroupDetailsCubit, GroupDetailsState>(
      bloc: bloc,
      listenWhen: (previous, current) => previous.shouldGoBack != current.shouldGoBack,
      listener: _listenNavigationFlow,
      child: BlocListener<GroupDetailsCubit, GroupDetailsState>(
        bloc: bloc,
        listenWhen: (previous, current) => previous.taskToDelete != current.taskToDelete,
        listener: _listenTaskToDelete,
        child: Scaffold(
          endDrawer: Drawer(
            child: BlocBuilder<GroupDetailsCubit, GroupDetailsState>(
              bloc: bloc,
              builder: (context, state) {
                return GroupDetailsFiltersDrawer(
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
                );
              },
            ),
          ),
          body: NestedScrollView(
            floatHeaderSlivers: true,
            headerSliverBuilder: (_, __) {
              return [
                SliverAppBar.medium(
                  title: BlocSelector<GroupDetailsCubit, GroupDetailsState, String?>(
                    bloc: bloc,
                    selector: (state) => state.group?.name,
                    builder: (context, name) {
                      return Text(name ?? title);
                    },
                  ),
                  bottom: PreferredSize(
                    preferredSize: const Size(0, AppSpacing.s),
                    child: BlocSelector<GroupDetailsCubit, GroupDetailsState, bool>(
                      bloc: bloc,
                      selector: (state) => state.isLoading || state.isRefreshing,
                      builder: (context, isLoading) => isLoading ? const LinearProgressIndicator() : const SizedBox.shrink(),
                    ),
                  ),
                ),
                BlocBuilder<GroupDetailsCubit, GroupDetailsState>(
                  bloc: bloc,
                  buildWhen: (previous, current) => previous.isCalendarView != current.isCalendarView,
                  builder: (context, state) {
                    if (state.isCalendarView) {
                      return AppSliverHeaderWrapper.floating(
                        maxSize: CalendarPagerViewConstants.collapsedHeight,
                        padding: 0,
                        child: Container(
                          clipBehavior: Clip.antiAlias,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(AppSpacing.m), bottomRight: Radius.circular(AppSpacing.m)),
                          ),
                          child: CalendarPagerView(
                            theme: CalendarPagerTheme.from(
                              background: theme.scaffoldBackgroundColor,
                              accent: theme.colorScheme.primary,
                              headerTitle: theme.textTheme.headlineLarge!,
                              itemBorder: theme.colorScheme.primary,
                              onAccent: theme.colorScheme.onPrimary,
                              hasShadow: false,
                            ),
                            hasHeader: false,
                            onDateSelected: bloc.updateSelectedDate,
                          ),
                        ),
                      );
                    } else {
                      return const SliverToBoxAdapter(child: SizedBox.shrink());
                    }
                  },
                ),
              ];
            },
            body: BlocBuilder<GroupDetailsCubit, GroupDetailsState>(
              bloc: bloc,
              builder: (context, state) {
                if (state.isLoading) {
                  return const TasksListLoading();
                }

                if (state.tasks.isEmpty) {
                  return const TaskContentUnavailable();
                }

                if (state.filteredTasks.isEmpty) {
                  return const TaskFilteredContentUnavailable();
                }

                return TasksList(
                  tasks: state.filteredTasks,
                  currentUserId: bloc.currentUser.id,
                  onPressed: (task) async {
                    if (context.mounted) {
                      final result = await context.pushNamed<bool>(TaskDetailsScreen.routeName, pathParameters: {'id': task.id});

                      if (result ?? false) {
                        bloc.updateTasksForMember(taskId: task.id);
                      }
                    }
                  },
                  onComplete: bloc.toggleTaskStatus,
                  onPending: bloc.toggleTaskStatus,
                  onDelete: bloc.setTaskToDelete,
                  onRefresh: () async => await bloc.refresh(groupId: widget.id),
                );
              },
            ),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () async {
              if (context.mounted) {
                final result = await context.pushNamed<bool>(CreateTaskScreen.routeName, pathParameters: {'id': widget.id});

                if (result ?? false) {
                  bloc.updateGroupForMember(groupId: widget.id);
                }
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

  void _listenNavigationFlow(BuildContext context, GroupDetailsState state) {
    if (state.shouldGoBack) {
      context.pop();
    }
  }
}
