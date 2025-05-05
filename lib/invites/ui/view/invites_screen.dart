import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_master/app/app.dart';
import 'package:task_master/invites/invites.dart';
import 'package:task_master/invites/ui/view/invite_item.dart';

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
      appBar: AppBar(title: const Text('Invites')),
      body: SafeArea(
        child: Column(
          children: [
            BlocSelector<InvitesCubit, InvitesState, bool>(
              bloc: bloc,
              selector: (state) => state.isLoading,
              builder: (context, isLoading) => isLoading ? const LinearProgressIndicator() : const SizedBox.shrink(),
            ),
            BlocSelector<InvitesCubit, InvitesState, List<InviteResponse>>(
              bloc: bloc,
              selector: (state) => state.invites,
              builder:
                  (context, invites) =>
                      invites.isEmpty
                          ? const Expanded(
                            child: Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [Text('No invitations for now.')])),
                          )
                          : Expanded(
                            child: ListView.separated(
                              itemCount: invites.length,
                              itemBuilder:
                                  (context, index) =>
                                      InviteItem(invite: invites[index], onAccepted: bloc.acceptInvite, onRejected: bloc.rejectInvite),
                              separatorBuilder: (context, index) => const Divider(),
                            ),
                          ),
            ),
          ],
        ),
      ),
    );
  }
}
