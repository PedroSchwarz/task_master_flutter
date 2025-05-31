import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:task_master/app/app.dart';
import 'package:task_master/groups/ui/cubit/group_details_cubit.dart';
import 'package:task_master/users/users.dart';

class GroupDetailsFiltersDrawer extends StatelessWidget {
  const GroupDetailsFiltersDrawer({
    required this.listView,
    required this.userFilter,
    required this.completionFilter,
    required this.statusFilter,
    required this.priorityFilter,
    required this.dateSort,
    required this.prioritySort,
    required this.assignedUsers,
    required this.userToFilterBy,
    required this.toggleListView,
    required this.updateUserFilter,
    required this.updateUserToFilterBy,
    required this.updateCompletionFilter,
    required this.updateStatusFilter,
    required this.updatePriorityFilter,
    required this.updateDateSort,
    required this.updatePrioritySort,
    required this.resetFiltersAndSort,
    super.key,
  });

  final TaskListView listView;
  final TaskUserFilter userFilter;
  final TaskCompletionFilter completionFilter;
  final TaskStatusFilter statusFilter;
  final TaskPriorityFilter priorityFilter;
  final TaskDateSort dateSort;
  final TaskPrioritySort prioritySort;
  final Set<UserResponse> assignedUsers;
  final UserResponse? userToFilterBy;
  final VoidCallback toggleListView;
  final void Function(TaskUserFilter, {required bool value}) updateUserFilter;
  final ValueChanged<UserResponse> updateUserToFilterBy;
  final void Function(TaskCompletionFilter, {required bool value}) updateCompletionFilter;
  final void Function(TaskStatusFilter, {required bool value}) updateStatusFilter;
  final void Function(TaskPriorityFilter, {required bool value}) updatePriorityFilter;
  final void Function(TaskDateSort, {required bool value}) updateDateSort;
  final void Function(TaskPrioritySort, {required bool value}) updatePrioritySort;
  final VoidCallback resetFiltersAndSort;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final localization = context.localization;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(AppSpacing.m, AppSpacing.m, AppSpacing.m, 0),
        child: Column(
          spacing: AppSpacing.s,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(localization.tasks_list_view, style: theme.textTheme.titleLarge),
                    const Divider(),
                    Wrap(
                      spacing: AppSpacing.xs,
                      children:
                          TaskListView.values
                              .map(
                                (view) => FilterChip(
                                  selected: listView == view,
                                  label: Text(switch (view) {
                                    TaskListView.list => localization.list,
                                    TaskListView.calendar => localization.calendar,
                                  }),
                                  onSelected: (value) {
                                    toggleListView();
                                  },
                                ),
                              )
                              .toList(),
                    ),
                    const Gap(AppSpacing.s),
                    Text(localization.assignee, style: theme.textTheme.titleLarge),
                    const Divider(),
                    Wrap(
                      spacing: AppSpacing.xs,
                      children:
                          TaskUserFilter.values
                              .map(
                                (filter) => FilterChip(
                                  selected: userFilter == filter,
                                  label: Text(switch (filter) {
                                    TaskUserFilter.all => localization.all,
                                    TaskUserFilter.myself => localization.myself,
                                    TaskUserFilter.others => localization.others,
                                  }),
                                  onSelected: (value) {
                                    updateUserFilter(filter, value: value);
                                  },
                                ),
                              )
                              .toList(),
                    ),
                    if (userFilter == TaskUserFilter.others)
                      Wrap(
                        spacing: AppSpacing.xs,
                        children:
                            assignedUsers
                                .map(
                                  (user) => FilterChip(
                                    selected: userToFilterBy == user,
                                    label: Text(user.lastName),
                                    onSelected: (value) {
                                      updateUserToFilterBy(user);
                                    },
                                    avatar: userToFilterBy == user ? null : CircleAvatar(child: Text(user.firstName[0])),
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
                                  ),
                                )
                                .toList(),
                      ),
                    const Gap(AppSpacing.s),
                    Text(localization.completion, style: theme.textTheme.titleLarge),
                    const Divider(),
                    Wrap(
                      spacing: AppSpacing.xs,
                      children:
                          TaskCompletionFilter.values
                              .map(
                                (filter) => FilterChip(
                                  selected: completionFilter == filter,
                                  label: Text(switch (filter) {
                                    TaskCompletionFilter.all => localization.all,
                                    TaskCompletionFilter.pending => localization.pending,
                                    TaskCompletionFilter.completed => localization.completed,
                                  }),
                                  onSelected: (value) {
                                    updateCompletionFilter(filter, value: value);
                                  },
                                ),
                              )
                              .toList(),
                    ),
                    const Gap(AppSpacing.s),
                    Text(localization.status, style: theme.textTheme.titleLarge),
                    const Divider(),
                    Wrap(
                      spacing: AppSpacing.xs,
                      children:
                          TaskStatusFilter.values
                              .map(
                                (filter) => FilterChip(
                                  selected: statusFilter == filter,
                                  label: Text(switch (filter) {
                                    TaskStatusFilter.all => localization.all,
                                    TaskStatusFilter.todo => localization.to_do,
                                    TaskStatusFilter.inProgress => localization.in_progress,
                                    TaskStatusFilter.done => localization.done,
                                  }),
                                  onSelected: (value) {
                                    updateStatusFilter(filter, value: value);
                                  },
                                ),
                              )
                              .toList(),
                    ),
                    const Gap(AppSpacing.s),
                    Text(localization.priority, style: theme.textTheme.titleLarge),
                    const Divider(),
                    Wrap(
                      spacing: AppSpacing.xs,
                      children:
                          TaskPriorityFilter.values
                              .map(
                                (filter) => FilterChip(
                                  selected: priorityFilter == filter,
                                  label: Text(switch (filter) {
                                    TaskPriorityFilter.all => localization.all,
                                    TaskPriorityFilter.high => localization.high,
                                    TaskPriorityFilter.medium => localization.medium,
                                    TaskPriorityFilter.low => localization.low,
                                  }),
                                  onSelected: (value) {
                                    updatePriorityFilter(filter, value: value);
                                  },
                                ),
                              )
                              .toList(),
                    ),
                    const Gap(AppSpacing.s),
                    Text(localization.sort_date, style: theme.textTheme.titleLarge),
                    const Divider(),
                    Wrap(
                      spacing: AppSpacing.xs,
                      children:
                          TaskDateSort.values
                              .map(
                                (sort) => FilterChip(
                                  selected: dateSort == sort,
                                  label: Text(switch (sort) {
                                    TaskDateSort.newest => localization.newest,
                                    TaskDateSort.oldest => localization.oldest,
                                  }),
                                  onSelected: (value) {
                                    updateDateSort(sort, value: value);
                                  },
                                ),
                              )
                              .toList(),
                    ),
                    const Gap(AppSpacing.s),
                    Text(localization.sort_priority, style: theme.textTheme.titleLarge),
                    const Divider(),
                    Wrap(
                      spacing: AppSpacing.xs,
                      children:
                          TaskPrioritySort.values
                              .map(
                                (sort) => FilterChip(
                                  selected: prioritySort == sort,
                                  label: Text(switch (sort) {
                                    TaskPrioritySort.none => localization.none,
                                    TaskPrioritySort.highest => localization.highest,
                                    TaskPrioritySort.lowest => localization.lowest,
                                  }),
                                  onSelected: (value) {
                                    updatePrioritySort(sort, value: value);
                                  },
                                ),
                              )
                              .toList(),
                    ),
                  ],
                ),
              ),
            ),
            FilledButton(onPressed: resetFiltersAndSort, child: Text(localization.reset)),
          ],
        ),
      ),
    );
  }
}
