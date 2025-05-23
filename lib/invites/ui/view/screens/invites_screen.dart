import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_master/app/app.dart';
import 'package:task_master/invites/invites.dart';
import 'package:task_master/invites/ui/view/components/invite_item.dart';

class InvitesScreen extends StatefulWidget {
  const InvitesScreen({super.key});

  static const String routeName = 'invites';

  @override
  State<InvitesScreen> createState() => _InvitesScreenState();
}

class _InvitesScreenState extends State<InvitesScreen> {
  final bloc = getIt<InvitesCubit>();

  @override
  void initState() {
    super.initState();
    bloc.load();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder:
            (_, __) => [
              SliverAppBar.medium(
                title: const Text('Invites'),
                bottom: PreferredSize(
                  preferredSize: const Size(0, AppSpacing.s),
                  child: BlocSelector<InvitesCubit, InvitesState, bool>(
                    bloc: bloc,
                    selector: (state) => state.isLoading || state.isRefreshing,
                    builder: (context, isLoading) => isLoading ? const LinearProgressIndicator() : const SizedBox.shrink(),
                  ),
                ),
              ),
            ],
        body: BlocSelector<InvitesCubit, InvitesState, List<InviteResponse>>(
          bloc: bloc,
          selector: (state) => state.invites,
          builder:
              (context, invites) =>
                  invites.isEmpty
                      ? const Center(child: Text('No invitations for now.'))
                      : ListView.separated(
                        padding: const EdgeInsets.only(top: AppSpacing.s, bottom: AppSpacing.max),
                        itemCount: invites.length,
                        itemBuilder: (context, position) {
                          return InviteItem(invite: invites[position], onAccepted: bloc.acceptInvite, onRejected: bloc.rejectInvite);
                        },
                        separatorBuilder: (_, __) => const Divider(),
                      ),
        ),
      ),
    );
  }
}
