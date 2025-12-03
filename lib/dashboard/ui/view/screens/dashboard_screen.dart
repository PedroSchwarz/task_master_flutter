import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:task_master/app/app.dart';
import 'package:task_master/dashboard/dashboard.dart';
import 'package:task_master/groups/groups.dart';
import 'package:task_master/invites/invites.dart';
import 'package:task_master/progress/progress.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  static const String routeName = 'dashboard';

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final bloc = getIt<DashboardCubit>();
  final FocusNode _searchFocusNode = .new();

  @override
  void initState() {
    super.initState();
    bloc.load();
  }

  @override
  void dispose() {
    _searchFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final localization = context.localization;
    final theme = Theme.of(context);

    return Scaffold(
      drawer: BlocBuilder<DashboardCubit, DashboardState>(
        bloc: bloc,
        buildWhen: (previous, current) =>
            previous.showingProgression != current.showingProgression || //
            previous.showingHighlights != current.showingHighlights,
        builder: (context, state) {
          return DashboardDrawer(
            initials: bloc.currentUser.initials,
            title: bloc.currentUser.completeName,
            subtitle: bloc.currentUser.email,
            showingProgression: state.showingProgression,
            showingHighlights: state.showingHighlights,
            onProgressionPressed: (value) =>
                bloc.updateShowingProgression(value: value),
            onHighlightsPressed: (value) =>
                bloc.updateShowingHighlight(value: value),
            onSignOut: bloc.signOut,
          );
        },
      ),
      body: NestedScrollView(
        headerSliverBuilder: (_, _) => [
          SliverAppBar.medium(
            title: const Text('Dashboard'),
            actions: [
              IconButton(
                onPressed: () {
                  context.pushNamed(ProgressionScreen.routeName);
                },
                icon: const Icon(Icons.pie_chart_outline),
              ),
              BlocSelector<
                DashboardCubit,
                DashboardState,
                List<InviteResponse>
              >(
                bloc: bloc,
                selector: (state) => state.invites,
                builder: (context, invites) {
                  return DashboardInvitesButton(
                    count: invites.length,
                    onPressed: () async {
                      if (context.mounted) {
                        await context.pushNamed(InvitesScreen.routeName);
                        await Future.wait([
                          bloc.loadGroups(),
                          bloc.loadInvites(),
                        ]);
                      }
                    },
                  );
                },
              ),
            ],
            bottom: PreferredSize(
              preferredSize: const Size(0, AppSpacing.s),
              child: BlocSelector<DashboardCubit, DashboardState, bool>(
                bloc: bloc,
                selector: (state) => state.isLoading || state.isRefreshing,
                builder: (context, isLoading) => isLoading
                    ? const LinearProgressIndicator()
                    : const SizedBox.shrink(),
              ),
            ),
          ),
        ],
        body: RefreshIndicator(
          onRefresh: bloc.refresh,
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: BlocBuilder<DashboardCubit, DashboardState>(
                  bloc: bloc,
                  buildWhen: (previous, current) =>
                      previous.isLoading != current.isLoading || //
                      previous.selection != current.selection || //
                      previous.showingProgression != current.showingProgression,
                  builder: (context, state) {
                    if (state.showingProgression) {
                      return DashboardProgressionFilters(
                        isLoading: state.isLoading,
                        selection: state.selection,
                        onSelection: bloc.updateSelection,
                      );
                    }

                    return const SizedBox.shrink();
                  },
                ),
              ),
              SliverToBoxAdapter(
                child: BlocBuilder<DashboardCubit, DashboardState>(
                  bloc: bloc,
                  buildWhen: (previous, current) =>
                      previous.progression != current.progression || //
                      previous.isLoading != current.isLoading || //
                      previous.showingProgression != current.showingProgression,
                  builder: (context, state) {
                    if (state.showingProgression) {
                      return DashboardProgression(
                        isLoading: state.isLoading,
                        progression: state.progression,
                      );
                    }

                    return const SizedBox.shrink();
                  },
                ),
              ),
              SliverToBoxAdapter(
                child: BlocBuilder<DashboardCubit, DashboardState>(
                  bloc: bloc,
                  buildWhen: (previous, current) =>
                      previous.isLoading != current.isLoading || //
                      previous.showingHighlights !=
                          current.showingHighlights || //
                      previous.upcomingTasks != current.upcomingTasks || //
                      previous.overdueTasks != current.overdueTasks,
                  builder: (context, state) {
                    if (state.showingHighlights) {
                      return DashboardHighlights(
                        isLoading: state.isLoading,
                        upcomingTasks: state.upcomingTasks,
                        overdueTasks: state.overdueTasks,
                      );
                    }

                    return const SizedBox.shrink();
                  },
                ),
              ),
              BlocBuilder<DashboardCubit, DashboardState>(
                bloc: bloc,
                buildWhen: (previous, current) =>
                    previous.isLoading != current.isLoading || //
                    previous.groups != current.groups || //
                    previous.groupsListType != current.groupsListType,
                builder: (context, state) {
                  return SliverPadding(
                    padding: const .symmetric(horizontal: AppSpacing.s),
                    sliver: SliverToBoxAdapter(
                      child: Row(
                        children: [
                          Text(
                            localization.groups,
                            style: theme.textTheme.headlineSmall,
                          ),
                          const Spacer(),
                          BlocSelector<DashboardCubit, DashboardState, bool>(
                            bloc: bloc,
                            selector: (state) => state.showGroupSearch,
                            builder: (context, showGroupSearch) {
                              return IconButton(
                                onPressed: () {
                                  final value = !showGroupSearch;
                                  bloc.updateShowGroupSearch(value: value);
                                  if (value) {
                                    _searchFocusNode.requestFocus();
                                  } else {
                                    _searchFocusNode.unfocus();
                                  }
                                },
                                icon: Icon(
                                  showGroupSearch
                                      ? Icons.search_off
                                      : Icons.search,
                                  color: showGroupSearch
                                      ? theme.colorScheme.error
                                      : theme.colorScheme.onPrimaryContainer,
                                ),
                              );
                            },
                          ),
                          IconButton(
                            onPressed: state.groups.isEmpty
                                ? null
                                : bloc.updateGroupsListType,
                            icon: Icon(
                              state.groupsListType == .list
                                  ? Icons.grid_view
                                  : Icons.table_rows_outlined,
                            ),
                          ),
                        ],
                      ).animate().fade(delay: 200.ms),
                    ),
                  );
                },
              ),
              BlocSelector<DashboardCubit, DashboardState, bool>(
                bloc: bloc,
                selector: (state) => state.showGroupSearch,
                builder: (context, showGroupSearch) {
                  return SliverToBoxAdapter(
                    child: showGroupSearch
                        ? Padding(
                            padding: const .all(AppSpacing.s),
                            child: AppSearchField(
                              focusNode: _searchFocusNode,
                              onChanged: bloc.updateGroupSearchQuery,
                              hintText: localization.search,
                              prefixIcon: Icons.search,
                            ),
                          ).animate().fade(delay: 200.ms).slide(delay: 100.ms)
                        : const SizedBox.shrink(),
                  );
                },
              ),
              BlocBuilder<DashboardCubit, DashboardState>(
                bloc: bloc,
                buildWhen: (previous, current) =>
                    previous.isLoading != current.isLoading || //
                    previous.groups != current.groups || //
                    previous.groupSearchQuery != current.groupSearchQuery || //
                    previous.groupsListType != current.groupsListType,
                builder: (context, state) {
                  if (state.isLoading) {
                    return GroupListLoading(listType: state.groupsListType);
                  }

                  if (state.groups.isEmpty) {
                    return const GroupContentUnavailable();
                  }

                  if (state.filteredGroups.isEmpty) {
                    return const GroupFilteredContentUnavailable();
                  }

                  return GroupsList(
                    groups: state.filteredGroups,
                    listType: state.groupsListType,
                    currentUser: bloc.currentUser,
                    onSelected: (group) {
                      context.goNamed(
                        GroupDetailsScreen.routeName,
                        pathParameters: {'id': group.id},
                        queryParameters: {'name': group.name},
                      );
                    },
                    onEdit: (group) async {
                      if (context.mounted) {
                        final result = await context.pushNamed<bool>(
                          CreateGroupScreen.routeName,
                          queryParameters: {'id': group.id},
                        );

                        if (result ?? false) {
                          bloc.updateGroupsForUsers(groupId: group.id);
                        }
                      }
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: .centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        label: Text(localization.create_group),
        icon: const Icon(Icons.add),
        onPressed: () async {
          if (context.mounted) {
            final result = await context.pushNamed<bool>(
              CreateGroupScreen.routeName,
            );

            if (result ?? false) {
              bloc.loadGroups();
            }
          }
        },
      ),
    );
  }
}
