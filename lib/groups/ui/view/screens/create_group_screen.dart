import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:task_master/app/app.dart';
import 'package:task_master/groups/groups.dart';
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
    final theme = Theme.of(context);
    final localization = context.localization;

    return BlocListener<CreateGroupCubit, CreateGroupState>(
      bloc: bloc,
      listenWhen: (previous, current) =>
          previous.showInviteUsersSheet != current.showInviteUsersSheet,
      listener: _listenInviteUsersSheet,
      child: BlocListener<CreateGroupCubit, CreateGroupState>(
        bloc: bloc,
        listenWhen: (previous, current) =>
            previous.showDeleteDialog != current.showDeleteDialog,
        listener: _listenDeleteDialog,
        child: BlocListener<CreateGroupCubit, CreateGroupState>(
          bloc: bloc,
          listenWhen: (previous, current) =>
              previous.shouldGoBack != current.shouldGoBack,
          listener: _listenNavigationFlow,
          child: GestureDetector(
            onTap: () {
              final scope = FocusScope.of(context);
              if (!scope.hasPrimaryFocus) {
                scope.unfocus();
              }
            },
            child: Scaffold(
              body: SafeArea(
                top: false,
                child: CustomScrollView(
                  slivers: [
                    SliverAppBar.medium(
                      title: BlocBuilder<CreateGroupCubit, CreateGroupState>(
                        bloc: bloc,
                        buildWhen: (previous, current) =>
                            previous.isLoading != current.isLoading ||
                            previous.isUpdating != current.isUpdating,
                        builder: (context, state) {
                          return AppSkeleton(
                            isLoading: state.isLoading,
                            child: Text(
                              state.isUpdating
                                  ? localization.update_group
                                  : localization.create_group,
                            ),
                          );
                        },
                      ),
                      actionsPadding: const .only(right: AppSpacing.s),
                      actions: [
                        BlocBuilder<CreateGroupCubit, CreateGroupState>(
                          bloc: bloc,
                          buildWhen: (previous, current) =>
                              previous.isLoading != current.isLoading || //
                              previous.group != current.group || //
                              previous.groupColor != current.groupColor,
                          builder: (context, state) {
                            final color = state.groupColor != null
                                ? Color(state.groupColor!)
                                : null;

                            return IconButton.outlined(
                              style: IconButton.styleFrom(
                                side: BorderSide(
                                  color: theme.colorScheme.onSurface,
                                  width: 3,
                                ),
                                backgroundColor: color,
                              ),
                              onPressed: () {
                                showModalBottomSheet(
                                  context: context,
                                  isScrollControlled: true,
                                  useSafeArea: true,
                                  showDragHandle: true,
                                  builder: (context) {
                                    return GroupColorPickerSheet(
                                      initialColor: state.groupColor,
                                      onChanged: (color) {
                                        bloc.updateGroupColor(color);
                                        context.pop();
                                      },
                                    );
                                  },
                                );
                              },
                              icon: const Icon(Icons.color_lens),
                            );
                          },
                        ),
                      ],
                      bottom: PreferredSize(
                        preferredSize: const Size(0, AppSpacing.s),
                        child:
                            BlocSelector<
                              CreateGroupCubit,
                              CreateGroupState,
                              bool
                            >(
                              bloc: bloc,
                              selector: (state) =>
                                  state.isSubmitting || state.isLoading,
                              builder: (context, isLoading) => isLoading
                                  ? const LinearProgressIndicator()
                                  : const SizedBox.shrink(),
                            ),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const .fromLTRB(
                          AppSpacing.s,
                          AppSpacing.s,
                          AppSpacing.s,
                          0,
                        ),
                        child: Column(
                          crossAxisAlignment: .stretch,
                          spacing: AppSpacing.s,
                          children: [
                            BlocBuilder<CreateGroupCubit, CreateGroupState>(
                              bloc: bloc,
                              buildWhen: (previous, current) =>
                                  previous.isLoading != current.isLoading || //
                                  previous.name != current.name,
                              builder: (context, state) {
                                return AppSkeleton(
                                  isLoading: state.isLoading,
                                  child: AppTextField(
                                    label: localization.name,
                                    initialValue: state.name,
                                    onChanged: bloc.updateName,
                                    textCapitalization: .words,
                                  ),
                                );
                              },
                            ),
                            BlocBuilder<CreateGroupCubit, CreateGroupState>(
                              bloc: bloc,
                              buildWhen: (previous, current) =>
                                  previous.isLoading != current.isLoading || //
                                  previous.name != current.name,
                              builder: (context, state) {
                                return AppSkeleton(
                                  isLoading: state.isLoading,
                                  child: AppTextField(
                                    label: localization.description,
                                    initialValue: state.description,
                                    onChanged: bloc.updateDescription,
                                    textCapitalization: .sentences,
                                    textInputAction: .done,
                                    maxLines: 5,
                                  ),
                                );
                              },
                            ),
                            BlocBuilder<CreateGroupCubit, CreateGroupState>(
                              bloc: bloc,
                              buildWhen: (previous, current) =>
                                  previous.users != current.users || //
                                  previous.isUpdating !=
                                      current.isUpdating || //
                                  previous.selectedUsersIds !=
                                      current.selectedUsersIds,
                              builder: (context, state) {
                                if (state.users.isEmpty) {
                                  return const SizedBox.shrink();
                                }

                                return Row(
                                  mainAxisAlignment: .spaceBetween,
                                  children: [
                                    TextButton(
                                      onPressed: bloc.toggleInviteUsersSheet,
                                      child: Row(
                                        spacing: AppSpacing.xs,
                                        children: [
                                          const Icon(Icons.person_add_outlined),
                                          Text(
                                            state.isUpdating
                                                ? localization
                                                      .group_manage_members
                                                : localization
                                                      .group_invite_members,
                                          ),
                                        ],
                                      ),
                                    ),
                                    Flexible(
                                      child: Text(
                                        localization.group_members_selected(
                                          state.selectedUsersIds.length,
                                        ),
                                      ),
                                    ),
                                  ],
                                ).animate().fadeIn();
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    SliverFillRemaining(
                      hasScrollBody: false,
                      child: Padding(
                        padding: .fromLTRB(
                          AppSpacing.s,
                          AppSpacing.s,
                          AppSpacing.s,
                          Platform.isMacOS ? AppSpacing.s : 0,
                        ),
                        child: BlocBuilder<CreateGroupCubit, CreateGroupState>(
                          bloc: bloc,
                          buildWhen: (previous, current) =>
                              previous.isLoading != current.isLoading || //
                              previous.canSubmit != current.canSubmit || //
                              previous.isUpdating != current.isUpdating,
                          builder: (context, state) {
                            return Row(
                              spacing: AppSpacing.s,
                              crossAxisAlignment: .end,
                              children: [
                                Expanded(
                                  child: FilledButton(
                                    onPressed: state.canSubmit
                                        ? bloc.saveGroup
                                        : null,
                                    child: Text(
                                      state.isUpdating
                                          ? localization.update
                                          : localization.create,
                                    ),
                                  ),
                                ),
                                if (state.isUpdating)
                                  Expanded(
                                    child: FilledButton.tonal(
                                      onPressed: () {
                                        HapticFeedback.heavyImpact();
                                        bloc.toggleDeleteDialog();
                                      },
                                      child: Text(localization.delete),
                                    ),
                                  ),
                              ],
                            );
                          },
                        ),
                      ),
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

  Future<void> _listenInviteUsersSheet(
    BuildContext context,
    CreateGroupState state,
  ) async {
    if (state.showInviteUsersSheet) {
      await showModalBottomSheet(
        context: context,
        useSafeArea: true,
        isScrollControlled: true,
        builder: (context) => InviteUsersSheet(
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

  Future<void> _listenDeleteDialog(
    BuildContext context,
    CreateGroupState state,
  ) async {
    final group = state.group;

    if (group == null) {
      return;
    }

    if (state.showDeleteDialog) {
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          final localization = context.localization;

          return AlertDialog(
            title: Text('${localization.delete} ${group.name}?'),
            content: Text(localization.action_cannot_be_undone),
            actions: [
              TextButton(
                onPressed: bloc.toggleDeleteDialog,
                child: Text(localization.cancel, textAlign: .end),
              ),
              TextButton(
                onPressed: bloc.deleteGroup,
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

  Future<void> _listenNavigationFlow(
    BuildContext context,
    CreateGroupState state,
  ) async {
    if (state.shouldGoBack) {
      context.pop(true);
    }
  }
}
