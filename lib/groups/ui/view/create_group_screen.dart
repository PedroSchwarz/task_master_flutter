import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:task_master/app/app.dart';
import 'package:task_master/groups/ui/cubit/create_group_cubit.dart';
import 'package:task_master/invites/invites.dart';

class CreateGroupScreen extends StatefulWidget {
  const CreateGroupScreen({this.id, super.key});

  static const String routeName = 'groups/create';

  final String? id;

  @override
  State<CreateGroupScreen> createState() => _CreateGroupScreenState();
}

class _CreateGroupScreenState extends State<CreateGroupScreen> {
  final bloc = getIt<CreateGroupCubit>();

  @override
  void initState() {
    super.initState();
    bloc.load(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CreateGroupCubit, CreateGroupState>(
      bloc: bloc,
      listenWhen: (previous, current) => previous.showInviteUsersSheet != current.showInviteUsersSheet,
      listener: _listenInviteUsersSheet,
      child: BlocListener<CreateGroupCubit, CreateGroupState>(
        bloc: bloc,
        listenWhen: (previous, current) => previous.showDeleteDialog != current.showDeleteDialog,
        listener: _listenDeleteDialog,
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
              appBar: AppBar(
                title: BlocSelector<CreateGroupCubit, CreateGroupState, bool>(
                  bloc: bloc,
                  selector: (state) => state.isUpdating,
                  builder: (context, isUpdating) => Text('${isUpdating ? 'Update' : 'Create'} Group'),
                ),
                bottom: PreferredSize(
                  preferredSize: const Size(0, 10),
                  child: BlocSelector<CreateGroupCubit, CreateGroupState, bool>(
                    bloc: bloc,
                    selector: (state) => state.isLoading,
                    builder: (context, isLoading) => isLoading ? const LinearProgressIndicator() : const SizedBox.shrink(),
                  ),
                ),
              ),
              body: BlocBuilder<CreateGroupCubit, CreateGroupState>(
                bloc: bloc,
                builder: (context, state) {
                  if (state.isLoading) {
                    return const SizedBox.shrink();
                  }

                  return SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(AppSpacing.s, AppSpacing.s, AppSpacing.s, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        spacing: AppSpacing.s,
                        children: [
                          AppTextField(
                            label: 'Name',
                            initialValue: state.name,
                            onChanged: bloc.updateName,
                            textCapitalization: TextCapitalization.words,
                          ),
                          AppTextField(
                            label: 'Description',
                            initialValue: state.description,
                            onChanged: bloc.updateDescription,
                            textCapitalization: TextCapitalization.sentences,
                            maxLines: 5,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextButton(
                                onPressed: bloc.toggleInviteUsersSheet,
                                child: Row(
                                  spacing: AppSpacing.s,
                                  children: [
                                    const Icon(Icons.person_add_outlined),
                                    BlocSelector<CreateGroupCubit, CreateGroupState, bool>(
                                      bloc: bloc,
                                      selector: (state) => state.isUpdating,
                                      builder: (context, isUpdating) => Text(isUpdating ? 'Manage member' : 'Invite people'),
                                    ),
                                  ],
                                ),
                              ),
                              Text('${state.selectedUsersIds.length} selected'),
                            ],
                          ),
                          const Spacer(),
                          BlocSelector<CreateGroupCubit, CreateGroupState, bool>(
                            bloc: bloc,
                            selector: (state) => state.isUpdating,
                            builder:
                                (context, isUpdating) => Row(
                                  spacing: AppSpacing.s,
                                  children: [
                                    Expanded(
                                      child: FilledButton(
                                        onPressed: state.isButtonEnabled ? bloc.saveGroup : null,
                                        child: Text(state.isUpdating ? 'Update' : 'Create'),
                                      ),
                                    ),
                                    if (isUpdating)
                                      Expanded(child: FilledButton.tonal(onPressed: bloc.toggleDeleteDialog, child: const Text('Delete'))),
                                  ],
                                ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
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
              isUpdating: state.isUpdating,
              onPressed: (selectedUsersIds) {
                bloc.updateSelectedUsersIds(selectedUsersIds);
                context.pop();
              },
            ),
      );

      bloc.toggleInviteUsersSheet();
    }
  }

  Future<void> _listenDeleteDialog(BuildContext context, CreateGroupState state) async {
    final group = state.group;

    if (group == null) {
      return;
    }

    if (state.showDeleteDialog) {
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Delete ${group.name}?'),
            content: const Text('This action cannot be undone.'),
            actions: [
              TextButton(onPressed: bloc.toggleDeleteDialog, child: const Text('Cancel', textAlign: TextAlign.end)),
              TextButton(onPressed: bloc.deleteGroup, child: const Text('Delete', textAlign: TextAlign.end)),
            ],
          );
        },
      );
    } else {
      context.pop();
    }
  }

  Future<void> _listenNavigationFlow(BuildContext context, CreateGroupState state) async {
    if (state.shouldGoBack) {
      context.pop();
    }
  }
}
