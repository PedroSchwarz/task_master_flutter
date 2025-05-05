import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:task_master/app/app.dart';
import 'package:task_master/groups/ui/cubit/group_details_cubit.dart';
import 'package:task_master/tasks/tasks.dart';

class GroupDetailsScreen extends StatefulWidget {
  const GroupDetailsScreen({required this.id, required this.name, super.key});

  static const String routeName = 'group';

  final String id;
  final String name;

  @override
  State<GroupDetailsScreen> createState() => _GroupDetailsScreenState();
}

class _GroupDetailsScreenState extends State<GroupDetailsScreen> {
  final bloc = getIt<GroupDetailsCubit>();
  late final String title;

  @override
  void initState() {
    super.initState();
    title = widget.name;
    bloc.load(groupId: widget.id);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            BlocBuilder<GroupDetailsCubit, GroupDetailsState>(
              bloc: bloc,
              builder:
                  (context, state) => Expanded(
                    child: CustomScrollView(
                      slivers: [
                        SliverAppBar(
                          title: Text(title),
                          snap: true,
                          floating: true,
                          bottom: state.isLoading ? const PreferredSize(preferredSize: Size(0, 0), child: LinearProgressIndicator()) : null,
                        ),
                        SliverPadding(
                          padding: const EdgeInsets.all(AppSpacing.s),
                          sliver: SliverList.separated(
                            itemCount: state.tasks.length,
                            itemBuilder: (context, position) {
                              final task = state.tasks[position];

                              return Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Flexible(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.stretch,
                                      children: [
                                        Text(task.title, style: theme.textTheme.titleLarge),
                                        Text(task.description ?? 'No description', style: theme.textTheme.bodyLarge),
                                        const Gap(AppSpacing.xs),
                                        Row(
                                          spacing: AppSpacing.xxs,
                                          children: [const Icon(Icons.watch_later), Text(task.formattedDueDate, style: theme.textTheme.labelLarge)],
                                        ),
                                        const Gap(AppSpacing.xs),
                                        Row(
                                          spacing: AppSpacing.xs,
                                          children: [
                                            Chip(
                                              label: Text(
                                                task.priority.title,
                                                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                                              ),
                                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppSpacing.xs)),
                                              padding: const EdgeInsets.symmetric(vertical: AppSpacing.xxxs, horizontal: AppSpacing.s),
                                              backgroundColor: task.priority.color.withValues(alpha: 0.8),
                                              side: BorderSide(color: task.priority.color, width: 3),
                                            ),
                                            Chip(
                                              label: Text(
                                                task.status.title,
                                                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                                              ),
                                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppSpacing.xs)),
                                              padding: const EdgeInsets.symmetric(vertical: AppSpacing.xxxs, horizontal: AppSpacing.s),
                                              backgroundColor: task.status.color.withValues(alpha: 0.8),
                                              side: BorderSide(color: task.status.color, width: 3),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),

                                  Stack(
                                    children:
                                        task.assignedTo.indexed.map((item) {
                                          final index = item.$1;
                                          final assignee = item.$2;

                                          return Transform.translate(
                                            offset: Offset(index * 10, 0),
                                            child: CircleAvatar(
                                              child: Text(
                                                '${assignee.firstName.substring(0, 1)}${assignee.lastName.substring(0, 1)}',
                                                style: theme.textTheme.titleMedium,
                                              ),
                                            ),
                                          );
                                        }).toList(),
                                  ),
                                ],
                              );
                            },
                            separatorBuilder: (context, position) => const Divider(),
                          ),
                        ),
                      ],
                    ),
                  ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          if (context.mounted) {
            await context.pushNamed(CreateTaskScreen.routeName, pathParameters: {'id': widget.id});
            bloc.loadTasks(groupId: widget.id);
          }
        },
        label: const Text('Create task'),
        icon: const Icon(Icons.add),
      ),
    );
  }
}

extension NullCheck<T> on T? {
  bool get isNull => this == null;
}
