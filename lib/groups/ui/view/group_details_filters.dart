import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:task_master/app/design_system/theme/app_spacing.dart';
import 'package:task_master/groups/ui/cubit/group_details_cubit.dart';
import 'package:task_master/users/users.dart';

class GroupDetailsFilters extends StatelessWidget {
  const GroupDetailsFilters({
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
                    Text('Tasks List View', style: theme.textTheme.titleLarge),
                    const Divider(),
                    Wrap(
                      spacing: AppSpacing.xs,
                      children:
                          TaskListView.values
                              .map(
                                (view) => FilterChip(
                                  selected: listView == view,
                                  label: Text(view.title),
                                  onSelected: (value) {
                                    toggleListView();
                                  },
                                ),
                              )
                              .toList(),
                    ),
                    const Gap(AppSpacing.s),
                    Text('Assignee', style: theme.textTheme.titleLarge),
                    const Divider(),
                    Wrap(
                      spacing: AppSpacing.xs,
                      children:
                          TaskUserFilter.values
                              .map(
                                (filter) => FilterChip(
                                  selected: userFilter == filter,
                                  label: Text(filter.title),
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
                    Text('Completion', style: theme.textTheme.titleLarge),
                    const Divider(),
                    Wrap(
                      spacing: AppSpacing.xs,
                      children:
                          TaskCompletionFilter.values
                              .map(
                                (filter) => FilterChip(
                                  selected: completionFilter == filter,
                                  label: Text(filter.title),
                                  onSelected: (value) {
                                    updateCompletionFilter(filter, value: value);
                                  },
                                ),
                              )
                              .toList(),
                    ),
                    const Gap(AppSpacing.s),
                    Text('Status', style: theme.textTheme.titleLarge),
                    const Divider(),
                    Wrap(
                      spacing: AppSpacing.xs,
                      children:
                          TaskStatusFilter.values
                              .map(
                                (filter) => FilterChip(
                                  selected: statusFilter == filter,
                                  label: Text(filter.title),
                                  onSelected: (value) {
                                    updateStatusFilter(filter, value: value);
                                  },
                                ),
                              )
                              .toList(),
                    ),
                    const Gap(AppSpacing.s),
                    Text('Priority', style: theme.textTheme.titleLarge),
                    const Divider(),
                    Wrap(
                      spacing: AppSpacing.xs,
                      children:
                          TaskPriorityFilter.values
                              .map(
                                (filter) => FilterChip(
                                  selected: priorityFilter == filter,
                                  label: Text(filter.title),
                                  onSelected: (value) {
                                    updatePriorityFilter(filter, value: value);
                                  },
                                ),
                              )
                              .toList(),
                    ),
                    const Gap(AppSpacing.s),
                    Text('Sort Date', style: theme.textTheme.titleLarge),
                    const Divider(),
                    Wrap(
                      spacing: AppSpacing.xs,
                      children:
                          TaskDateSort.values
                              .map(
                                (sort) => FilterChip(
                                  selected: dateSort == sort,
                                  label: Text(sort.title),
                                  onSelected: (value) {
                                    updateDateSort(sort, value: value);
                                  },
                                ),
                              )
                              .toList(),
                    ),
                    const Gap(AppSpacing.s),
                    Text('Sort Priority', style: theme.textTheme.titleLarge),
                    const Divider(),
                    Wrap(
                      spacing: AppSpacing.xs,
                      children:
                          TaskPrioritySort.values
                              .map(
                                (sort) => FilterChip(
                                  selected: prioritySort == sort,
                                  label: Text(sort.title),
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
            FilledButton(onPressed: resetFiltersAndSort, child: const Text('Reset')),
          ],
        ),
      ),
    );
  }
}
