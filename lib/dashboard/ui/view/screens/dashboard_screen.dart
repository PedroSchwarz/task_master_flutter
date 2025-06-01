import 'package:flutter/material.dart';
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

  @override
  void initState() {
    super.initState();
    bloc.load();
  }

  @override
  Widget build(BuildContext context) {
    final localization = context.localization;

    return Scaffold(
      drawer: BlocBuilder<DashboardCubit, DashboardState>(
        bloc: bloc,
        buildWhen:
            (previous, current) =>
                previous.showingProgression != current.showingProgression || //
                previous.showingHighlights != current.showingHighlights,
        builder: (context, state) {
          return DashboardDrawer(
            initials: bloc.currentUser.initials,
            title: bloc.currentUser.completeName,
            subtitle: bloc.currentUser.email,
            showingProgression: state.showingProgression,
            showingHighlights: state.showingHighlights,
            onProgressionPressed: (value) => bloc.updateShowingProgression(value: value),
            onHighlightsPressed: (value) => bloc.updateShowingHighlight(value: value),
            onSignOut: bloc.signOut,
          );
        },
      ),
      body: NestedScrollView(
        headerSliverBuilder:
            (_, __) => [
              SliverAppBar.medium(
                title: const Text('Dashboard'),
                actions: [
                  IconButton(
                    onPressed: () {
                      context.pushNamed(ProgressionScreen.routeName);
                    },
                    icon: const Icon(Icons.pie_chart_outline),
                  ),
                  BlocSelector<DashboardCubit, DashboardState, List<InviteResponse>>(
                    bloc: bloc,
                    selector: (state) => state.invites,
                    builder: (context, invites) {
                      return DashboardInvitesButton(
                        count: invites.length,
                        onPressed: () async {
                          if (context.mounted) {
                            await context.pushNamed(InvitesScreen.routeName);
                            await Future.wait([bloc.loadGroups(), bloc.loadInvites()]);
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
                    builder: (context, isLoading) => isLoading ? const LinearProgressIndicator() : const SizedBox.shrink(),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: BlocBuilder<DashboardCubit, DashboardState>(
                  bloc: bloc,
                  buildWhen:
                      (previous, current) =>
                          previous.isLoading != current.isLoading || //
                          previous.selection != current.selection || //
                          previous.showingProgression != current.showingProgression,
                  builder: (context, state) {
                    if (state.showingProgression) {
                      return DashboardProgressionFilters(isLoading: state.isLoading, selection: state.selection, onSelection: bloc.updateSelection);
                    }

                    return const SizedBox.shrink();
                  },
                ),
              ),
              SliverToBoxAdapter(
                child: BlocBuilder<DashboardCubit, DashboardState>(
                  bloc: bloc,
                  buildWhen:
                      (previous, current) =>
                          previous.progression != current.progression || //
                          previous.isLoading != current.isLoading || //
                          previous.showingProgression != current.showingProgression,
                  builder: (context, state) {
                    if (state.showingProgression) {
                      return DashboardProgression(isLoading: state.isLoading, progression: state.progression);
                    }

                    return const SizedBox.shrink();
                  },
                ),
              ),
              SliverToBoxAdapter(
                child: BlocBuilder<DashboardCubit, DashboardState>(
                  bloc: bloc,
                  buildWhen:
                      (previous, current) =>
                          previous.isLoading != current.isLoading || //
                          previous.showingHighlights != current.showingHighlights || //
                          previous.upcomingTasks != current.upcomingTasks || //
                          previous.overdueTasks != current.overdueTasks,
                  builder: (context, state) {
                    if (state.showingHighlights) {
                      return DashboardHighlights(isLoading: state.isLoading, upcomingTasks: state.upcomingTasks, overdueTasks: state.overdueTasks);
                    }

                    return const SizedBox.shrink();
                  },
                ),
              ),
            ],
        body: BlocBuilder<DashboardCubit, DashboardState>(
          bloc: bloc,
          buildWhen:
              (previous, current) =>
                  previous.isLoading != current.isLoading || //
                  previous.groups != current.groups || //
                  previous.groupsListType != current.groupsListType,
          builder: (context, state) {
            if (state.isLoading) {
              return GroupListLoading(listType: state.groupsListType);
            }

            if (state.groups.isEmpty) {
              return GroupContentUnavailable(onRefresh: bloc.refresh);
            }

            return GroupsList(
              groups: state.groups,
              listType: state.groupsListType,
              onToggleListType: bloc.updateGroupsListType,
              currentUser: bloc.currentUser,
              onSelected: (group) {
                context.goNamed(GroupDetailsScreen.routeName, pathParameters: {'id': group.id}, queryParameters: {'name': group.name});
              },
              onEdit: (group) async {
                if (context.mounted) {
                  final result = await context.pushNamed<bool>(CreateGroupScreen.routeName, queryParameters: {'id': group.id});

                  if (result ?? false) {
                    bloc.updateGroupsForUsers(groupId: group.id);
                  }
                }
              },
              onRefresh: bloc.refresh,
            );
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        label: Text(localization.create_group),
        icon: const Icon(Icons.add),
        onPressed: () async {
          if (context.mounted) {
            final result = await context.pushNamed<bool>(CreateGroupScreen.routeName);

            if (result ?? false) {
              bloc.loadGroups();
            }
          }
        },
      ),
    );
  }
}
