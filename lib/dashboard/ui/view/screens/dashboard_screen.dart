import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:task_master/app/app.dart';
import 'package:task_master/dashboard/ui/cubit/dashboard_cubit.dart';
import 'package:task_master/dashboard/ui/view/drawer/dashboard_drawer.dart';
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
    return Scaffold(
      drawer: DashboardDrawer(
        initials: bloc.currentUser.initials,
        title: bloc.currentUser.completeName,
        subtitle: bloc.currentUser.email,
        onSignOut: bloc.signOut,
      ),
      body: NestedScrollView(
        headerSliverBuilder:
            (_, __) => [
              SliverAppBar.medium(
                title: const Text('Dashboard'),
                actions: [
                  BlocSelector<DashboardCubit, DashboardState, int>(
                    bloc: bloc,
                    selector: (state) => state.invites.length,
                    builder: (context, invitesCount) {
                      return Badge.count(
                        textStyle: Theme.of(context).textTheme.labelLarge,
                        offset: const Offset(-5, 0),
                        count: invitesCount,
                        child: IconButton(
                          onPressed: () async {
                            if (context.mounted) {
                              await context.pushNamed(InvitesScreen.routeName);
                              await Future.wait([bloc.loadGroups(), bloc.loadInvites()]);
                            }
                          },
                          icon: const Icon(Icons.mail_outline),
                        ),
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
            ],
        body: BlocBuilder<DashboardCubit, DashboardState>(
          bloc: bloc,
          buildWhen:
              (previous, current) =>
                  previous.isLoading != current.isLoading || //
                  previous.groups != current.groups,
          builder: (context, state) {
            if (state.isLoading) {
              return const GroupListLoading();
            }

            if (state.groups.isEmpty) {
              return GroupContentUnavailable(onRefresh: bloc.refresh);
            }

            return Column(
              children: [
                BlocSelector<DashboardCubit, DashboardState, List<WeeklyTaskProgression?>>(
                  bloc: bloc,
                  selector: (state) => state.progression,
                  builder: (context, progression) {
                    if (progression.every((item) => item == null)) {
                      return const SizedBox.shrink();
                    }

                    return ProgressionCarousel(
                      height: 132,
                      progression: progression,
                      onCompletionPressed: () {
                        context.pushNamed(ProgressionScreen.routeName);
                      },
                      onOverduePressed: () {
                        context.pushNamed(ProgressionScreen.routeName);
                      },
                      onPriorityPressed: () {
                        context.pushNamed(ProgressionScreen.routeName);
                      },
                      onStatusPressed: () {
                        context.pushNamed(ProgressionScreen.routeName);
                      },
                    );
                  },
                ),
                Expanded(
                  child: GroupsList(
                    groups: state.groups,
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
                  ),
                ),
              ],
            );
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        label: const Text('Create Group'),
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
