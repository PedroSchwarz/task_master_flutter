import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:task_master/app/app.dart';
import 'package:task_master/dashboard/ui/cubit/dashboard_cubit.dart';
import 'package:task_master/groups/groups.dart';
import 'package:task_master/invites/invites.dart';

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
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        actions: [
          BlocSelector<DashboardCubit, DashboardState, int>(
            bloc: bloc,
            selector: (state) => state.invites.length,
            builder:
                (context, invitesCount) => Badge.count(
                  textStyle: Theme.of(context).textTheme.labelLarge,
                  offset: const Offset(-5, 0),
                  count: invitesCount,
                  child: IconButton(
                    onPressed: () async {
                      await context.pushNamed(InvitesScreen.routeName);
                      bloc.load();
                    },
                    icon: const Icon(Icons.mail_outline),
                  ),
                ),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size(0, 10),
          child: BlocSelector<DashboardCubit, DashboardState, bool>(
            bloc: bloc,
            selector: (state) => state.isLoading,
            builder: (context, isLoading) => isLoading ? const LinearProgressIndicator() : const SizedBox.shrink(),
          ),
        ),
      ),
      drawer: Drawer(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(AppSpacing.s, AppSpacing.s, AppSpacing.s, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text('${bloc.currentUser.firstName} ${bloc.currentUser.lastName}', style: theme.textTheme.headlineSmall),
                Text(bloc.currentUser.email),
                const Spacer(),
                TextButton(onPressed: bloc.signOut, child: const Text('Sign Out')),
              ],
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          BlocBuilder<DashboardCubit, DashboardState>(
            bloc: bloc,
            builder:
                (context, state) =>
                    state.groups.isEmpty
                        ? const Expanded(child: Padding(padding: EdgeInsets.all(AppSpacing.s), child: GroupContentUnavailable()))
                        : Expanded(
                          child: GroupsList(
                            groups: state.groups,
                            currentUser: bloc.currentUser,
                            onSelected:
                                (group) => context.goNamed(
                                  GroupDetailsScreen.routeName,
                                  pathParameters: {'id': group.id},
                                  queryParameters: {'name': group.name},
                                ),
                            onRefresh: bloc.load,
                          ),
                        ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        label: const Text('Create Group'),
        icon: const Icon(Icons.add),
        onPressed: () async {
          if (context.mounted) {
            await context.pushNamed(CreateGroupScreen.routeName);
            bloc.load();
          }
        },
      ),
    );
  }
}
