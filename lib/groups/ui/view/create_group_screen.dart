import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:task_master/app/app.dart';
import 'package:task_master/groups/ui/cubit/create_group_cubit.dart';
import 'package:task_master/invites/invites.dart';

class CreateGroupScreen extends StatefulWidget {
  const CreateGroupScreen({super.key});

  static const String routeName = 'groups/create';

  @override
  State<CreateGroupScreen> createState() => _CreateGroupScreenState();
}

class _CreateGroupScreenState extends State<CreateGroupScreen> {
  final bloc = getIt<CreateGroupCubit>();

  @override
  void initState() {
    super.initState();
    bloc.load();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CreateGroupCubit, CreateGroupState>(
      bloc: bloc,
      listenWhen: (previous, current) => previous.showInviteUsersSheet != current.showInviteUsersSheet,
      listener: _listenInviteUsersSheet,
      child: BlocListener<CreateGroupCubit, CreateGroupState>(
        bloc: bloc,
        listenWhen: (previous, current) => previous.shouldGoBack != current.shouldGoBack,
        listener: _listenNavigationFlow,
        child: GestureDetector(
          onTap: () {
            final scope = FocusScope.of(context);
            if (!scope.hasPrimaryFocus) {
              scope.unfocus();
            }
          },
          child: Scaffold(
            appBar: AppBar(title: const Text('Create Group')),
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(AppSpacing.s, AppSpacing.s, AppSpacing.s, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  spacing: AppSpacing.s,
                  children: [
                    BlocSelector<CreateGroupCubit, CreateGroupState, bool>(
                      bloc: bloc,
                      selector: (state) => state.isLoading,
                      builder: (context, isLoading) => isLoading ? const LinearProgressIndicator() : const SizedBox.shrink(),
                    ),
                    AppTextField(label: 'Name', onChanged: bloc.updateName, textCapitalization: TextCapitalization.words),
                    AppTextField(
                      label: 'Description',
                      onChanged: bloc.updateDescription,
                      textCapitalization: TextCapitalization.sentences,
                      maxLines: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          onPressed: bloc.toggleInviteUsersSheet,
                          child: const Row(spacing: AppSpacing.s, children: [Icon(Icons.person_add_outlined), Text('Invite people')]),
                        ),
                        BlocSelector<CreateGroupCubit, CreateGroupState, int>(
                          bloc: bloc,
                          selector: (state) => state.selectedUsersIds.length,
                          builder: (context, idsCount) => Text('$idsCount selected'),
                        ),
                      ],
                    ),
                    const Spacer(),
                    BlocSelector<CreateGroupCubit, CreateGroupState, bool>(
                      bloc: bloc,
                      selector: (state) => state.isButtonEnabled,
                      builder: (context, isEnabled) => FilledButton(onPressed: isEnabled ? bloc.createGroup : null, child: const Text('Create')),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _listenInviteUsersSheet(BuildContext context, CreateGroupState state) async {
    if (state.showInviteUsersSheet) {
      await showModalBottomSheet(
        context: context,
        useSafeArea: true,
        isScrollControlled: true,
        builder:
            (context) => InviteUsersSheet(
              users: state.users,
              selectedUsersIds: state.selectedUsersIds,
              onPressed: (selectedUsersIds) {
                bloc.updateSelectedUsersIds(selectedUsersIds);
                context.pop();
              },
            ),
      );

      bloc.toggleInviteUsersSheet();
    }
  }

  Future<void> _listenNavigationFlow(BuildContext context, CreateGroupState state) async {
    if (state.shouldGoBack) {
      context.pop();
    }
  }
}
