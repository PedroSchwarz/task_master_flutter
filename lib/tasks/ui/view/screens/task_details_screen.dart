import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:task_master/app/app.dart';
import 'package:task_master/comments/comments.dart';
import 'package:task_master/tasks/data/models/task_values.dart';
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
    final localization = context.localization;

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

                        return AppSkeleton(
                          isLoading: state.isLoading,
                          child: Row(
                            spacing: AppSpacing.xs,
                            children: [
                              if (task?.completed ?? false)
                                Container(
                                  padding: const EdgeInsets.all(AppSpacing.xxs),
                                  decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: Colors.green, width: 3)),
                                  child: const Icon(Icons.check_rounded, color: Colors.green),
                                ).animate().fade(),
                              Flexible(
                                child: Text(
                                  task?.title ?? '',
                                  style: theme.textTheme.headlineLarge?.copyWith(
                                    color: (task?.isOverdue ?? false) ? Colors.red : theme.colorScheme.primary,
                                  ),
                                ),
                              ).animate().fade(),
                            ],
                          ),
                        );
                      },
                    ),
                    actionsPadding: const EdgeInsets.only(right: AppSpacing.s),
                    actions: [
                      BlocSelector<TaskDetailsCubit, TaskDetailsState, TaskResponse?>(
                        bloc: bloc,
                        selector: (state) => state.task,
                        builder: (context, task) {
                          if (task == null) return const SizedBox.shrink();

                          return IconButton.filledTonal(
                            tooltip: task.completed ? localization.pending : localization.completed,
                            iconSize: 25,
                            onPressed: () {
                              HapticFeedback.heavyImpact();
                              bloc.toggleComplete();
                            },
                            style: ButtonStyle(
                              backgroundColor: WidgetStatePropertyAll(
                                task.completed ? Colors.orange.withValues(alpha: 0.7) : Colors.green.withValues(alpha: 0.7),
                              ),
                              side: WidgetStatePropertyAll(
                                BorderSide(color: task.completed ? Colors.orange.withValues(alpha: 1) : Colors.green.withValues(alpha: 1), width: 2),
                              ),
                            ),
                            icon: Icon(task.completed ? Icons.close : Icons.check, color: Colors.white),
                          ).animate().fade(delay: 100.ms);
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
                          BlocSelector<TaskDetailsCubit, TaskDetailsState, TaskResponse?>(
                            bloc: bloc,
                            selector: (state) => state.task,
                            builder: (context, task) {
                              if (task == null) return const SizedBox.shrink();

                              final currentUserId = bloc.currentUser.id;
                              final isOwner = task.owner.id == currentUserId;
                              final isAssignee = task.assignedTo.any((assignee) => assignee.id == currentUserId);

                              return Column(
                                spacing: AppSpacing.xxs,
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Text(localization.actions, style: theme.textTheme.bodyLarge),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          IconButton.filled(
                                            tooltip: localization.duplicate_task,
                                            iconSize: 25,
                                            onPressed:
                                                isOwner || isAssignee
                                                    ? () async {
                                                      await _duplicateTask(context, task);
                                                    }
                                                    : null,
                                            icon: Icon(Icons.copy_all_rounded, color: theme.colorScheme.onPrimary),
                                          ),
                                          SizedBox(
                                            height: AppSpacing.s,
                                            child: VerticalDivider(width: AppSpacing.s, color: theme.colorScheme.onPrimaryContainer),
                                          ),
                                          IconButton.filledTonal(
                                            tooltip: localization.edit_task,
                                            iconSize: 25,
                                            onPressed:
                                                isOwner || isAssignee
                                                    ? () async {
                                                      await _editTask(context, task);
                                                    }
                                                    : null,
                                            icon: Icon(Icons.edit_outlined, color: theme.colorScheme.onPrimaryContainer),
                                          ),
                                        ],
                                      ),
                                      IconButton.outlined(
                                        tooltip: localization.delete_task,
                                        iconSize: 25,
                                        onPressed:
                                            isOwner || isAssignee
                                                ? () {
                                                  HapticFeedback.heavyImpact();
                                                  bloc.toggleDeleteDialog();
                                                }
                                                : null,
                                        icon: const Icon(Icons.delete_outline, color: Colors.red),
                                      ),
                                    ],
                                  ),
                                ],
                              ).animate().fade(delay: 150.ms);
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
                                return const AppSkeleton(isLoading: true, child: SizedBox(height: 50, width: double.infinity));
                              }

                              return Row(
                                spacing: AppSpacing.xs,
                                children: [
                                  if (task.isOverdue)
                                    Flexible(
                                      child: Chip(
                                        label: Text(
                                          localization.overdue,
                                          style: theme.textTheme.bodyLarge?.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
                                        ),
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppSpacing.xs)),
                                        padding: const EdgeInsets.all(AppSpacing.xs),
                                        backgroundColor: Colors.red,
                                        side: BorderSide.none,
                                      ),
                                    ),
                                  Flexible(
                                    child: Chip(
                                      label: Text(switch (task.priority) {
                                        TaskPriority.low => localization.low,
                                        TaskPriority.medium => localization.medium,
                                        TaskPriority.high => localization.high,
                                      }, style: theme.textTheme.titleMedium?.copyWith(color: Colors.white, fontWeight: FontWeight.bold)),
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
                                      padding: const EdgeInsets.all(AppSpacing.xs),
                                      backgroundColor: task.priority.color,
                                      side: BorderSide.none,
                                    ),
                                  ),
                                  Flexible(
                                    child: Chip(
                                      label: Text(switch (task.status) {
                                        TaskStatus.todo => localization.to_do,
                                        TaskStatus.inProgress => localization.in_progress,
                                        TaskStatus.done => localization.done,
                                      }, style: theme.textTheme.titleMedium?.copyWith(color: Colors.white, fontWeight: FontWeight.bold)),
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
                                      padding: const EdgeInsets.all(AppSpacing.xs),
                                      backgroundColor: task.status.color,
                                      side: BorderSide.none,
                                    ),
                                  ),
                                ],
                              ).animate().fade(delay: 150.ms);
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
                                return const AppSkeleton(isLoading: true, child: SizedBox(height: 20, width: double.infinity));
                              }

                              return Text(
                                '${localization.due_by}: ${task.formattedDueDate}',
                                style: theme.textTheme.bodyLarge?.copyWith(
                                  color: task.isOverdue ? Colors.red : null,
                                  fontWeight: task.isOverdue ? FontWeight.bold : null,
                                ),
                              ).animate().fade(delay: 200.ms);
                            },
                          ),
                          const Gap(AppSpacing.s),
                          const Divider(),
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
                                return const AppSkeleton(isLoading: true, child: SizedBox(height: 40, width: double.infinity));
                              }

                              return Wrap(
                                spacing: AppSpacing.xs,
                                children: task.assignedTo.map((assignee) => CircleAvatar(child: Text(assignee.initials))).toList(),
                              ).animate().fade(delay: 200.ms);
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

                              return Text(
                                task.description ?? localization.no_description,
                                style: theme.textTheme.bodyLarge,
                              ).animate().fade(delay: 250.ms);
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SliverToBoxAdapter(child: Divider(indent: AppSpacing.s, endIndent: AppSpacing.s)),
                  AppSliverHeaderWrapper.pinned(
                    maxSize: 128,
                    padding: 0,
                    child: Container(
                      decoration: BoxDecoration(color: theme.scaffoldBackgroundColor),
                      child: Column(
                        spacing: AppSpacing.xs,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(AppSpacing.s, AppSpacing.s, AppSpacing.s, 0),
                            child: Text(localization.comments),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s),
                            child: Row(
                              spacing: AppSpacing.s,
                              children: [
                                Flexible(
                                  child: BlocSelector<TaskDetailsCubit, TaskDetailsState, String>(
                                    bloc: bloc,
                                    selector: (state) => state.comment,
                                    builder: (context, comment) {
                                      return AppTextField(label: localization.comment, initialValue: comment, onChanged: bloc.updateComment);
                                    },
                                  ),
                                ),
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
                          ),
                          BlocSelector<TaskDetailsCubit, TaskDetailsState, bool>(
                            bloc: bloc,
                            selector: (state) => state.isLoadingComments,
                            builder: (context, isLoadingComments) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(vertical: AppSpacing.xxs),
                                child: SizedBox(child: isLoadingComments ? const LinearProgressIndicator() : null),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  BlocBuilder<TaskDetailsCubit, TaskDetailsState>(
                    bloc: bloc,
                    builder: (context, state) {
                      if (state.comments.isEmpty) {
                        return SliverToBoxAdapter(child: Center(child: Text(localization.no_comments)));
                      }

                      return SliverList.separated(
                        itemCount: state.comments.length,
                        itemBuilder: (context, position) {
                          final comment = state.comments[position];
                          return CommentItem(
                            comment: comment,
                            canDelete: comment.owner.id == bloc.currentUser.id,
                            onDelete: () async {
                              await bloc.deleteComment(comment.id);
                            },
                          );
                        },
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
                                    Text('${localization.created_at}:'),
                                    BlocBuilder<TaskDetailsCubit, TaskDetailsState>(
                                      bloc: bloc,
                                      buildWhen:
                                          (previous, current) =>
                                              previous.isLoading != current.isLoading || //
                                              previous.task != current.task,
                                      builder: (context, state) {
                                        final task = state.task;

                                        if (state.isLoading || task == null) {
                                          return const AppSkeleton(isLoading: true, child: Text('EEEE, d MMMM - hh:mm a'));
                                        }

                                        return Text(task.formattedCreatedAt, style: theme.textTheme.bodySmall);
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text('${localization.updated_at}:'),
                                    BlocBuilder<TaskDetailsCubit, TaskDetailsState>(
                                      bloc: bloc,
                                      buildWhen:
                                          (previous, current) =>
                                              previous.isLoading != current.isLoading || //
                                              previous.task != current.task,
                                      builder: (context, state) {
                                        final task = state.task;

                                        if (state.isLoading || task == null) {
                                          return const AppSkeleton(isLoading: true, child: Text('EEEE, d MMMM - hh:mm a'));
                                        }

                                        return Text(task.formattedUpdatedAt, style: theme.textTheme.bodySmall);
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

  Future<void> _editTask(BuildContext context, TaskResponse task) async {
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
  }

  Future<void> _duplicateTask(BuildContext context, TaskResponse task) async {
    if (context.mounted) {
      final dueDate = task.dueDate.toLocal();

      HapticFeedback.heavyImpact();

      final date = await showDatePicker(
        context: context,
        initialDate: dueDate,
        firstDate: dueDate,
        lastDate: DateTime.now().add(const Duration(days: 365)),
      );

      if (date != null && context.mounted) {
        final time = await showTimePicker(context: context, initialTime: TimeOfDay.fromDateTime(dueDate));

        if (time != null) {
          await bloc.duplicateTask(date, time);
        }
      }
    }
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
          final localization = context.localization;

          return AlertDialog(
            title: Text('${localization.delete} ${task.title}?'),
            content: Text(localization.action_cannot_be_undone),
            actions: [
              TextButton(onPressed: bloc.toggleDeleteDialog, child: Text(localization.cancel, textAlign: TextAlign.end)),
              TextButton(onPressed: bloc.deleteTask, child: Text(localization.delete, textAlign: TextAlign.end)),
            ],
          );
        },
      );
    } else {
      context.pop();
    }
  }
}
