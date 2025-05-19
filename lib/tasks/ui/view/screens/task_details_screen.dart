import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:task_master/app/app.dart';
import 'package:task_master/comments/comments.dart';
import 'package:task_master/tasks/tasks.dart';

class TaskDetailsScreen extends StatefulWidget {
  const TaskDetailsScreen({required this.id, super.key});

  final String id;

  static const String routeName = 'task';

  @override
  State<TaskDetailsScreen> createState() => _TaskDetailsScreenState();
}

class _TaskDetailsScreenState extends State<TaskDetailsScreen> {
  final bloc = getIt<TaskDetailsCubit>();

  @override
  void initState() {
    super.initState();
    bloc.load(widget.id);
  }

  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocListener<TaskDetailsCubit, TaskDetailsState>(
      bloc: bloc,
      listenWhen: (previous, current) => previous.shouldGoBack != current.shouldGoBack,
      listener: _listenNavigationFlow,
      child: BlocListener<TaskDetailsCubit, TaskDetailsState>(
        bloc: bloc,
        listenWhen: (previous, current) => previous.showDeleteDialog != current.showDeleteDialog,
        listener: _listenDeleteDialog,
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
                    title: BlocBuilder<TaskDetailsCubit, TaskDetailsState>(
                      bloc: bloc,
                      buildWhen:
                          (previous, current) =>
                              previous.isLoading != current.isLoading || //
                              previous.task != current.task,
                      builder: (context, state) {
                        final task = state.task;
                        if (state.isLoading || task == null) {
                          return const Text('Loading Task...');
                        }

                        return Row(
                          spacing: AppSpacing.xs,
                          children: [
                            if (task.completed)
                              Container(
                                padding: const EdgeInsets.all(AppSpacing.xxs),
                                decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: Colors.green, width: 3)),
                                child: const Icon(Icons.check_rounded, color: Colors.green),
                              ),
                            Flexible(
                              child: Text(
                                task.title,
                                style: theme.textTheme.headlineLarge?.copyWith(color: task.isOverdue ? Colors.red : theme.colorScheme.primary),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                    actions: [
                      BlocSelector<TaskDetailsCubit, TaskDetailsState, TaskResponse?>(
                        bloc: bloc,
                        selector: (state) => state.task,
                        builder: (context, task) {
                          if (task == null) return const SizedBox.shrink();

                          final currentUserId = bloc.currentUser.id;
                          final isOwner = task.owner.id == currentUserId;
                          final isAssignee = task.assignedTo.any((assignee) => assignee.id == currentUserId);

                          return PopupMenuButton(
                            itemBuilder: (context) {
                              return [
                                PopupMenuItem(
                                  onTap: bloc.toggleComplete,
                                  child: Row(
                                    spacing: AppSpacing.xxs,
                                    children: [Icon(task.completed ? Icons.close : Icons.check), Text(task.completed ? 'Not Complete' : 'Complete')],
                                  ),
                                ),
                                PopupMenuItem(
                                  onTap: () async {
                                    if (context.mounted) {
                                      final result = await context.pushNamed<bool>(
                                        CreateTaskScreen.routeName,
                                        pathParameters: {'id': task.group},
                                        queryParameters: {'taskId': task.id},
                                      );

                                      if (result ?? false) {
                                        bloc.updateTaskForMember();
                                      }
                                    }
                                  },
                                  enabled: isOwner || isAssignee,
                                  child: const Row(spacing: AppSpacing.xs, children: [Icon(Icons.edit_outlined, size: 20), Text('Edit')]),
                                ),
                                PopupMenuItem(
                                  onTap: bloc.toggleDeleteDialog,
                                  enabled: isOwner || isAssignee,
                                  child: const Row(spacing: AppSpacing.xs, children: [Icon(Icons.delete_outline, size: 20), Text('Delete')]),
                                ),
                              ];
                            },
                          );
                        },
                      ),
                    ],
                    bottom: PreferredSize(
                      preferredSize: const Size(0, AppSpacing.s),
                      child: BlocSelector<TaskDetailsCubit, TaskDetailsState, bool>(
                        bloc: bloc,
                        selector: (state) => state.isLoading || state.isRefreshing,
                        builder: (context, isLoading) => isLoading ? const LinearProgressIndicator() : const SizedBox.shrink(),
                      ),
                    ),
                  ),
                  SliverPadding(
                    padding: const EdgeInsets.all(AppSpacing.s),
                    sliver: SliverToBoxAdapter(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          BlocBuilder<TaskDetailsCubit, TaskDetailsState>(
                            bloc: bloc,
                            buildWhen:
                                (previous, current) =>
                                    previous.isLoading != current.isLoading || //
                                    previous.task != current.task,
                            builder: (context, state) {
                              final task = state.task;

                              if (state.isLoading || task == null) {
                                return const AppSkeleton(isLoading: true, child: SizedBox(height: 50, width: double.infinity));
                              }

                              return Row(
                                spacing: AppSpacing.xs,
                                children: [
                                  if (task.isOverdue)
                                    Flexible(
                                      child: Chip(
                                        label: Text(
                                          'Overdue',
                                          style: theme.textTheme.bodyLarge?.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
                                        ),
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppSpacing.xs)),
                                        padding: const EdgeInsets.all(AppSpacing.xxs),
                                        backgroundColor: Colors.red,
                                        side: const BorderSide(color: Colors.red, width: 3),
                                      ),
                                    ),
                                  Flexible(
                                    child: Chip(
                                      label: Text(
                                        task.priority.title,
                                        style: theme.textTheme.titleMedium?.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
                                      ),
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
                                      padding: const EdgeInsets.all(AppSpacing.xxs),
                                      backgroundColor: task.priority.color.withValues(alpha: 0.8),
                                      side: BorderSide(color: task.priority.color, width: 3),
                                    ),
                                  ),
                                  Flexible(
                                    child: Chip(
                                      label: Text(
                                        task.status.title,
                                        style: theme.textTheme.titleMedium?.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
                                      ),
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
                                      padding: const EdgeInsets.all(AppSpacing.xxs),
                                      backgroundColor: task.status.color.withValues(alpha: 0.8),
                                      side: BorderSide(color: task.status.color, width: 3),
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                          const Gap(AppSpacing.xxs),
                          const Divider(),
                          const Gap(AppSpacing.xs),
                          BlocBuilder<TaskDetailsCubit, TaskDetailsState>(
                            bloc: bloc,
                            buildWhen:
                                (previous, current) =>
                                    previous.isLoading != current.isLoading || //
                                    previous.task != current.task,
                            builder: (context, state) {
                              final task = state.task;

                              if (state.isLoading || task == null) {
                                return const AppSkeleton(isLoading: true, child: SizedBox(height: 40, width: double.infinity));
                              }

                              return Wrap(
                                spacing: AppSpacing.xs,
                                children: task.assignedTo.map((assignee) => CircleAvatar(child: Text(assignee.initials))).toList(),
                              );
                            },
                          ),
                          const Gap(AppSpacing.xs),
                          BlocBuilder<TaskDetailsCubit, TaskDetailsState>(
                            bloc: bloc,
                            buildWhen:
                                (previous, current) =>
                                    previous.isLoading != current.isLoading || //
                                    previous.task != current.task,
                            builder: (context, state) {
                              final task = state.task;

                              if (state.isLoading || task == null) {
                                return const AppSkeleton(isLoading: true, child: SizedBox(height: 20, width: double.infinity));
                              }

                              return Text(
                                'Due by: ${task.formattedDueDate}',
                                style: theme.textTheme.bodyLarge?.copyWith(
                                  color: task.isOverdue ? Colors.red : null,
                                  fontWeight: task.isOverdue ? FontWeight.bold : null,
                                ),
                              );
                            },
                          ),
                          const Gap(AppSpacing.s),
                          BlocBuilder<TaskDetailsCubit, TaskDetailsState>(
                            bloc: bloc,
                            buildWhen:
                                (previous, current) =>
                                    previous.isLoading != current.isLoading || //
                                    previous.task != current.task,
                            builder: (context, state) {
                              final task = state.task;

                              if (state.isLoading || task == null) {
                                return const AppSkeleton(isLoading: true, child: SizedBox(height: 150, width: double.infinity));
                              }

                              return Text(task.description ?? 'No Description', style: theme.textTheme.titleLarge);
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  AppSliverHeaderWrapper.pinned(
                    maxSize: 124,
                    padding: 0,
                    child: Container(
                      padding: const EdgeInsets.all(AppSpacing.s),
                      decoration: BoxDecoration(color: theme.scaffoldBackgroundColor),
                      child: Column(
                        spacing: AppSpacing.xs,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const Text('Comments'),
                          Row(
                            spacing: AppSpacing.s,
                            children: [
                              Flexible(child: AppTextField(label: 'Comment', onChanged: bloc.updateComment)),
                              BlocSelector<TaskDetailsCubit, TaskDetailsState, bool>(
                                bloc: bloc,
                                selector: (state) => state.canSubmit,
                                builder: (context, canSubmit) {
                                  return IconButton.filled(
                                    onPressed: canSubmit ? bloc.createComment : null,
                                    icon: const Icon(Icons.send),
                                    padding: const EdgeInsets.all(AppSpacing.s),
                                  );
                                },
                              ),
                            ],
                          ),
                          BlocSelector<TaskDetailsCubit, TaskDetailsState, bool>(
                            bloc: bloc,
                            selector: (state) => state.isLoadingComments,
                            builder: (context, isLoadingComments) {
                              return SizedBox(child: isLoadingComments ? const LinearProgressIndicator() : null);
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  BlocBuilder<TaskDetailsCubit, TaskDetailsState>(
                    bloc: bloc,
                    builder: (context, state) {
                      return SliverList.separated(
                        itemCount: state.comments.length,
                        itemBuilder: (context, position) => CommentItem(comment: state.comments[position]),
                        separatorBuilder: (context, index) => const Divider(),
                      );
                    },
                  ),
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(AppSpacing.s, AppSpacing.l, AppSpacing.s, 0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Row(
                            spacing: AppSpacing.s,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text('Created at:'),
                                    BlocBuilder<TaskDetailsCubit, TaskDetailsState>(
                                      bloc: bloc,
                                      buildWhen:
                                          (previous, current) =>
                                              previous.isLoading != current.isLoading || //
                                              previous.task != current.task,
                                      builder: (context, state) {
                                        final task = state.task;

                                        if (state.isLoading || task == null) {
                                          return const AppSkeleton(isLoading: true, child: Text('EE, MMMM d hh:mm a'));
                                        }

                                        return Text(task.formattedCreatedAt);
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    const Text('Last updated at:'),
                                    BlocBuilder<TaskDetailsCubit, TaskDetailsState>(
                                      bloc: bloc,
                                      buildWhen:
                                          (previous, current) =>
                                              previous.isLoading != current.isLoading || //
                                              previous.task != current.task,
                                      builder: (context, state) {
                                        final task = state.task;

                                        if (state.isLoading || task == null) {
                                          return const AppSkeleton(isLoading: true, child: Text('EE, MMMM d hh:mm a'));
                                        }

                                        return Text(task.formattedUpdatedAt);
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _listenNavigationFlow(BuildContext context, TaskDetailsState state) {
    if (state.shouldGoBack) {
      context.pop(true);
    }
  }

  void _listenDeleteDialog(BuildContext context, TaskDetailsState state) {
    final task = state.task;

    if (task == null) {
      return;
    }

    if (state.showDeleteDialog) {
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Delete ${task.title}?'),
            content: const Text('This action cannot be undone.'),
            actions: [
              TextButton(onPressed: bloc.toggleDeleteDialog, child: const Text('Cancel', textAlign: TextAlign.end)),
              TextButton(onPressed: bloc.deleteTask, child: const Text('Delete', textAlign: TextAlign.end)),
            ],
          );
        },
      );
    } else {
      context.pop();
    }
  }
}
