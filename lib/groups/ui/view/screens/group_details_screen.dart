import 'package:calendar_pager/calendar_pager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:task_master/app/app.dart';
import 'package:task_master/groups/groups.dart';
import 'package:task_master/tasks/tasks.dart';
import 'package:visibility_detector/visibility_detector.dart';

class GroupDetailsScreen extends StatefulWidget {
  const GroupDetailsScreen({required this.id, required this.name, super.key});

  static const String routeName = 'group';

  final String id;
  final String name;

  @override
  State<GroupDetailsScreen> createState() => _GroupDetailsScreenState();
}

class _GroupDetailsScreenState extends State<GroupDetailsScreen> {
  late final ScrollController _scrollController;
  late final CalendarPagerController _calendarPagerController;
  final GlobalKey<ScaffoldState> _scaffoldKey = .new();
  late final FocusNode _taskSearchFocusNode;

  final bloc = getIt<GroupDetailsCubit>();
  late final String title;

  @override
  void initState() {
    super.initState();
    _scrollController = .new();
    _calendarPagerController = .new();
    _taskSearchFocusNode = .new();
    title = widget.name;
    bloc.load(groupId: widget.id);
  }

  @override
  void dispose() {
    bloc.dispose();
    _scrollController.dispose();
    _taskSearchFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final localization = context.localization;

    return BlocListener<GroupDetailsCubit, GroupDetailsState>(
      bloc: bloc,
      listenWhen: (previous, current) =>
          previous.shouldGoBack != current.shouldGoBack,
      listener: _listenNavigationFlow,
      child: BlocListener<GroupDetailsCubit, GroupDetailsState>(
        bloc: bloc,
        listenWhen: (previous, current) =>
            previous.showLeaveDialog != current.showLeaveDialog,
        listener: _listenLeaveDialog,
        child: BlocListener<GroupDetailsCubit, GroupDetailsState>(
          bloc: bloc,
          listenWhen: (previous, current) =>
              previous.taskToDelete != current.taskToDelete,
          listener: _listenTaskToDelete,
          child: Scaffold(
            key: _scaffoldKey,
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
            body: Stack(
              children: [
                NestedScrollView(
                  controller: _scrollController,
                  floatHeaderSlivers: true,
                  headerSliverBuilder: (_, _) {
                    return [
                      SliverAppBar.medium(
                        title:
                            BlocSelector<
                              GroupDetailsCubit,
                              GroupDetailsState,
                              String?
                            >(
                              bloc: bloc,
                              selector: (state) => state.group?.name,
                              builder: (context, name) {
                                return Text(
                                  name ?? title,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                );
                              },
                            ),
                        actionsPadding: const .only(right: AppSpacing.xs),
                        actions: [
                          BlocSelector<
                            GroupDetailsCubit,
                            GroupDetailsState,
                            bool
                          >(
                            bloc: bloc,
                            selector: (state) => state.showSelectCurrentDate,
                            builder: (context, showSelectCurrentDate) {
                              if (showSelectCurrentDate) {
                                return IconButton(
                                  tooltip: localization.go_to_current_date,
                                  onPressed: () {
                                    bloc.updateSelectedDate(DateTime.now());
                                    _calendarPagerController.goToInitialDate();
                                  },
                                  icon: const Icon(Icons.today),
                                );
                              } else {
                                return const SizedBox.shrink();
                              }
                            },
                          ),
                          BlocSelector<
                            GroupDetailsCubit,
                            GroupDetailsState,
                            bool
                          >(
                            bloc: bloc,
                            selector: (state) => state.showTaskSearch,
                            builder: (context, showTaskSearch) {
                              return IconButton(
                                onPressed: () {
                                  final value = !showTaskSearch;
                                  bloc.updateShowTaskSearch(value: value);
                                  if (value) {
                                    _taskSearchFocusNode.requestFocus();
                                  } else {
                                    _taskSearchFocusNode.unfocus();
                                  }
                                },
                                icon: Icon(
                                  showTaskSearch
                                      ? Icons.search_off
                                      : Icons.search,
                                  color: showTaskSearch
                                      ? theme.colorScheme.error
                                      : theme.colorScheme.onPrimaryContainer,
                                ),
                              );
                            },
                          ),
                          IconButton(
                            onPressed: _scaffoldKey.currentState?.openEndDrawer,
                            icon: const Icon(Icons.menu),
                          ),
                        ],
                        bottom: PreferredSize(
                          preferredSize: const Size(0, AppSpacing.s),
                          child:
                              BlocSelector<
                                GroupDetailsCubit,
                                GroupDetailsState,
                                bool
                              >(
                                bloc: bloc,
                                selector: (state) =>
                                    state.isLoading || state.isRefreshing,
                                builder: (context, isLoading) => isLoading
                                    ? const LinearProgressIndicator()
                                    : const SizedBox.shrink(),
                              ),
                        ),
                      ),
                    ];
                  },
                  body: RefreshIndicator(
                    onRefresh: () async => await bloc.refresh(
                      groupId: widget.id,
                    ),
                    child: CustomScrollView(
                      slivers: [
                        SliverToBoxAdapter(
                          child: BlocBuilder<GroupDetailsCubit, GroupDetailsState>(
                            bloc: bloc,
                            buildWhen: (previous, current) =>
                                previous.group != current.group,
                            builder: (context, state) {
                              final group = state.group;
                              final isOwner =
                                  group?.owner.id == bloc.currentUser.id;

                              return VisibilityDetector(
                                key: const Key('calendar_pager'),
                                onVisibilityChanged: (visibility) {
                                  final isHidden =
                                      visibility.visibleFraction <= 0.5;
                                  bloc.setShowScrollToTopButton(
                                    value: isHidden,
                                  );
                                },
                                child: ExpansionTile(
                                  title: Text(
                                    localization.details,
                                    style: theme.textTheme.titleMedium
                                        ?.copyWith(
                                          color: theme.colorScheme.secondary,
                                        ),
                                  ),
                                  shape: const RoundedRectangleBorder(),
                                  tilePadding: const .symmetric(
                                    horizontal: AppSpacing.s,
                                  ),
                                  children: [
                                    Padding(
                                      padding: const .symmetric(
                                        horizontal: AppSpacing.s,
                                      ),
                                      child: Row(
                                        mainAxisAlignment: .spaceBetween,
                                        crossAxisAlignment: .center,
                                        spacing: AppSpacing.xs,
                                        children: [
                                          AppSkeleton(
                                            isLoading: group == null,
                                            child: Row(
                                              spacing: AppSpacing.xs,
                                              children: [
                                                Text(
                                                  '${localization.actions}:',
                                                ).animate().fade(delay: 100.ms),
                                                IconButton.filledTonal(
                                                  color: theme
                                                      .colorScheme
                                                      .onPrimaryContainer,
                                                  onPressed: isOwner
                                                      ? () async {
                                                          if (context.mounted) {
                                                            final result = await context
                                                                .pushNamed<
                                                                  bool
                                                                >(
                                                                  CreateGroupScreen
                                                                      .routeName,
                                                                  queryParameters: {
                                                                    'id': group!
                                                                        .id,
                                                                  },
                                                                );

                                                            if (result ??
                                                                false) {
                                                              bloc.updateGroupForMember(
                                                                groupId:
                                                                    group.id,
                                                              );
                                                            }
                                                          }
                                                        }
                                                      : null,
                                                  icon: const Icon(
                                                    Icons.edit_outlined,
                                                  ),
                                                ).animate().fade(delay: 200.ms),
                                              ],
                                            ),
                                          ),
                                          IconButton.outlined(
                                            color: Colors.red,
                                            tooltip: localization.leave_group,
                                            onPressed: isOwner
                                                ? null
                                                : bloc.toggleLeaveDialog,
                                            icon: const Icon(Icons.exit_to_app),
                                          ).animate().fade(delay: 200.ms),
                                        ],
                                      ),
                                    ),
                                    const Gap(AppSpacing.xxs),
                                    const Divider(),
                                    const Gap(AppSpacing.xs),
                                    AppSkeleton(
                                      isLoading: group == null,
                                      child: SizedBox(
                                        height: 40,
                                        child: ListView.separated(
                                          scrollDirection: .horizontal,
                                          padding: const .symmetric(
                                            horizontal: AppSpacing.s,
                                          ),
                                          itemCount: group?.members.length ?? 0,
                                          itemBuilder: (context, position) {
                                            final member =
                                                group!.members[position];

                                            if (position == 0) {
                                              return Row(
                                                spacing: AppSpacing.s,
                                                children: [
                                                  Text(
                                                    '${localization.members}:',
                                                  ).animate().fade(
                                                    delay: 100.ms,
                                                  ),
                                                  CircleAvatar(
                                                    child: Text(
                                                      member.initials,
                                                    ),
                                                  ).animate().fade(
                                                    delay: 200.ms,
                                                  ),
                                                ],
                                              );
                                            }
                                            return CircleAvatar(
                                              child: Text(member.initials),
                                            ).animate().fade(delay: 200.ms);
                                          },
                                          separatorBuilder: (_, _) =>
                                              const Gap(AppSpacing.xs),
                                        ),
                                      ),
                                    ),
                                    const Gap(AppSpacing.s),
                                  ],
                                ),
                              );
                            },
                          ).animate().fade(delay: 100.ms),
                        ),
                        BlocBuilder<GroupDetailsCubit, GroupDetailsState>(
                          bloc: bloc,
                          buildWhen: (previous, current) =>
                              previous.formattedWeekMonth !=
                                  current.formattedWeekMonth ||
                              previous.isCalendarView != current.isCalendarView,
                          builder: (context, state) {
                            if (state.isCalendarView) {
                              return SliverPadding(
                                padding: const .symmetric(
                                  horizontal: AppSpacing.s,
                                ),
                                sliver: SliverToBoxAdapter(
                                  child: Text(
                                    state.formattedWeekMonth,
                                    style: theme.textTheme.headlineSmall
                                        ?.copyWith(
                                          color: theme.colorScheme.secondary,
                                        ),
                                  ).animate().fade(delay: 100.ms),
                                ),
                              );
                            } else {
                              return const SliverToBoxAdapter(
                                child: SizedBox.shrink(),
                              );
                            }
                          },
                        ),
                        SliverToBoxAdapter(
                          child:
                              BlocBuilder<GroupDetailsCubit, GroupDetailsState>(
                                bloc: bloc,
                                buildWhen: (previous, current) =>
                                    previous.isCalendarView !=
                                    current.isCalendarView,
                                builder: (context, state) {
                                  if (state.isCalendarView) {
                                    return CalendarPagerView(
                                      controller: _calendarPagerController,
                                      theme: CalendarPagerTheme.from(
                                        background:
                                            theme.scaffoldBackgroundColor,
                                        accent: theme.colorScheme.primary,
                                        headerTitle:
                                            theme.textTheme.headlineLarge!,
                                        itemBorder: theme.colorScheme.primary,
                                        onAccent: theme.colorScheme.onPrimary,
                                        hasShadow: false,
                                      ),
                                      hasHeader: false,
                                      onDateSelected: bloc.updateSelectedDate,
                                      onWeekChanged:
                                          (
                                            week,
                                            initialWeek,
                                            firstDate,
                                            lastDate,
                                          ) {
                                            bloc.setShowSelectCurrentDate(
                                              value: week != initialWeek,
                                            );
                                            bloc.updateFirstAndLastDate(
                                              firstDate: firstDate,
                                              lastDate: lastDate,
                                            );
                                          },
                                    ).animate().fade(delay: 150.ms);
                                  } else {
                                    return const SizedBox.shrink();
                                  }
                                },
                              ),
                        ),
                        BlocBuilder<GroupDetailsCubit, GroupDetailsState>(
                          bloc: bloc,
                          buildWhen: (previous, current) =>
                              previous.formattedSelectedDate !=
                                  current.formattedSelectedDate ||
                              previous.isCalendarView != current.isCalendarView,
                          builder: (context, state) {
                            if (state.isCalendarView) {
                              return SliverToBoxAdapter(
                                child: Column(
                                  crossAxisAlignment: .stretch,
                                  spacing: AppSpacing.s,
                                  children: [
                                    const Divider(),
                                    Padding(
                                      padding: const .symmetric(
                                        horizontal: AppSpacing.s,
                                      ),
                                      child: Text(
                                        state.formattedSelectedDate,
                                        style: theme.textTheme.headlineLarge
                                            ?.copyWith(
                                              color:
                                                  theme.colorScheme.secondary,
                                            ),
                                      ),
                                    ),
                                  ],
                                ).animate().fade(delay: 200.ms),
                              );
                            } else {
                              return const SliverToBoxAdapter(
                                child: SizedBox.shrink(),
                              );
                            }
                          },
                        ),
                        BlocSelector<
                          GroupDetailsCubit,
                          GroupDetailsState,
                          bool
                        >(
                          bloc: bloc,
                          selector: (state) => state.showTaskSearch,
                          builder: (context, showTaskSearch) {
                            return SliverToBoxAdapter(
                              child: showTaskSearch
                                  ? Padding(
                                      padding: const .all(AppSpacing.s),
                                      child:
                                          AppSearchField(
                                                focusNode: _taskSearchFocusNode,
                                                onChanged: (value) {
                                                  bloc.updateTaskSearchQuery(
                                                    value: value,
                                                  );
                                                },
                                                hintText: localization.search,
                                                prefixIcon: Icons.search,
                                              )
                                              .animate()
                                              .fade(delay: 200.ms)
                                              .slide(delay: 100.ms),
                                    )
                                  : const SizedBox.shrink(),
                            );
                          },
                        ),

                        BlocBuilder<GroupDetailsCubit, GroupDetailsState>(
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
                                  final result = await context.pushNamed<bool>(
                                    TaskDetailsScreen.routeName,
                                    pathParameters: {
                                      'id': widget.id,
                                      'taskId': task.id,
                                    },
                                  );

                                  if (result ?? false) {
                                    bloc.updateTasksForMember(taskId: task.id);
                                  }
                                }
                              },
                              onComplete: bloc.toggleTaskStatus,
                              onPending: bloc.toggleTaskStatus,
                              onDelete: bloc.setTaskToDelete,
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                BlocSelector<GroupDetailsCubit, GroupDetailsState, bool>(
                  bloc: bloc,
                  selector: (state) => state.showScrollToTopButton,
                  builder: (context, showScrollToTopButton) {
                    if (showScrollToTopButton) {
                      return Positioned(
                        bottom: AppSpacing.s,
                        right: AppSpacing.s,
                        child: SafeArea(
                          child: FloatingActionButton(
                            heroTag: const ValueKey('scroll_to_top_button'),
                            backgroundColor: theme.colorScheme.primary,
                            shape: const CircleBorder(),
                            onPressed: () {
                              _scrollController.animateTo(
                                0,
                                duration: const Duration(milliseconds: 200),
                                curve: Curves.easeInOut,
                              );
                            },
                            child: Icon(
                              Icons.keyboard_arrow_up,
                              color: theme.colorScheme.onPrimary,
                              size: 32,
                            ),
                          ),
                        ),
                      ).animate().fade(delay: 200.ms);
                    } else {
                      return const SizedBox.shrink();
                    }
                  },
                ),
              ],
            ),
            floatingActionButtonLocation: .centerFloat,
            floatingActionButton: FloatingActionButton.extended(
              onPressed: () async {
                if (context.mounted) {
                  final result = await context.pushNamed<bool>(
                    CreateTaskScreen.routeName,
                    pathParameters: {'id': widget.id},
                  );

                  if (result ?? false) {
                    bloc.updateGroupForMember(groupId: widget.id);
                  }
                }
              },
              label: Text(localization.create_task),
              icon: const Icon(Icons.add),
            ),
          ),
        ),
      ),
    );
  }

  void _listenLeaveDialog(BuildContext context, GroupDetailsState state) {
    if (state.showLeaveDialog) {
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          final localization = context.localization;

          return AlertDialog(
            title: Text('${localization.leave_group}?'),
            actions: [
              TextButton(
                onPressed: bloc.toggleLeaveDialog,
                child: Text(localization.cancel, textAlign: .end),
              ),
              TextButton(
                onPressed: bloc.leaveGroup,
                child: Text(localization.leave, textAlign: .end),
              ),
            ],
          );
        },
      );
    } else {
      context.pop();
    }
  }

  void _listenTaskToDelete(BuildContext context, GroupDetailsState state) {
    final task = state.taskToDelete;

    if (task != null) {
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          final localization = context.localization;

          return AlertDialog(
            title: Text('${localization.delete} ${task.title}?'),
            content: Text(localization.action_cannot_be_undone),
            actions: [
              TextButton(
                onPressed: () => bloc.setTaskToDelete(null),
                child: Text(localization.cancel, textAlign: .end),
              ),
              TextButton(
                onPressed: () => bloc.deleteTask(task),
                child: Text(localization.delete, textAlign: .end),
              ),
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
