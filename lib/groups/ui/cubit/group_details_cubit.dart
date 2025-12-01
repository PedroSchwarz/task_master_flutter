import 'dart:async';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:logging/logging.dart';
import 'package:task_master/auth/auth.dart';
import 'package:task_master/groups/groups.dart';
import 'package:task_master/invites/invites.dart';
import 'package:task_master/tasks/data/models/update_task_request.dart';
import 'package:task_master/tasks/tasks.dart';
import 'package:task_master/users/users.dart';

part 'group_details_cubit.freezed.dart';

class GroupDetailsCubit extends Cubit<GroupDetailsState> {
  GroupDetailsCubit({
    required this.authRepository,
    required this.groupsRepository,
    required this.tasksRepository,
    required this.invitesRepository,
    required this.groupsWebsocket,
    required this.tasksWebsocket,
  }) : super(
         GroupDetailsState(
           isLoading: false,
           tasks: [],
           invites: [],
           selectedDate: DateTime.now(),
           listView: .calendar,
           userFilter: .all,
           completionFilter: .all,
           statusFilter: .all,
           priorityFilter: .all,
           dateSort: .newest,
           prioritySort: .none,
           showLeaveDialog: false,
           isRefreshing: false,
           shouldGoBack: false,
           showScrollToTopButton: false,
           showSelectCurrentDate: false,
         ),
       );

  static final _log = Logger('GroupDetailsCubit');

  @visibleForTesting
  final AuthRepository authRepository;

  @visibleForTesting
  final GroupsRepository groupsRepository;

  @visibleForTesting
  final TasksRepository tasksRepository;

  @visibleForTesting
  final InvitesRepository invitesRepository;

  @visibleForTesting
  final GroupsWebsocket groupsWebsocket;

  @visibleForTesting
  final TasksWebsocket tasksWebsocket;

  UserData get currentUser => authRepository.currentUser.value!;

  StreamSubscription<String>? _groupsSubscription;

  StreamSubscription<String>? _tasksSubscription;

  Future<void> load({required String groupId}) async {
    emit(
      state.copyWith(
        isLoading: true,
        currentUser: authRepository.currentUser.value,
      ),
    );

    _groupsSubscription = groupsWebsocket.groupsUpdatedStream.listen((id) {
      if (groupId == id) {
        refresh(groupId: groupId);
      }
    });

    _tasksSubscription = tasksWebsocket.tasksUpdatedStream.listen((taskId) {
      if (state.tasks.any((task) => task.id == taskId)) {
        refresh(groupId: groupId);
      }
    });

    await Future.wait([
      loadGroup(groupId: groupId),
      loadTasks(groupId: groupId),
      loadTasksListView(),
    ]);
    emit(state.copyWith(isLoading: false));
  }

  Future<void> refresh({required String groupId}) async {
    emit(state.copyWith(isRefreshing: true));
    await Future.wait([
      loadGroup(groupId: groupId),
      loadTasks(groupId: groupId),
    ]);
    emit(state.copyWith(isRefreshing: false));
  }

  Future<void> loadGroup({required String groupId}) async {
    try {
      final group = await groupsRepository.getGroupById(groupId);
      emit(state.copyWith(group: group));
    } catch (e) {
      _log.severe('Error loading group: $e', e);
      emit(state.copyWith(shouldGoBack: true));
    }
  }

  Future<void> loadTasks({required String groupId}) async {
    try {
      final tasks = await tasksRepository.getAll(groupId);
      emit(state.copyWith(tasks: tasks));
    } catch (e) {
      _log.severe('Error loading tasks: $e', e);
    }
  }

  Future<void> loadTasksListView() async {
    try {
      final listView = await groupsRepository.loadTasksListView();
      emit(state.copyWith(listView: listView));
    } catch (e) {
      _log.severe('Error loading tasks list view: $e', e);
    }
  }

  void updateSelectedDate(DateTime value) {
    final isToday = DateUtils.isSameDay(value, DateTime.now());
    emit(state.copyWith(selectedDate: value, showSelectCurrentDate: !isToday));
  }

  void setShowSelectCurrentDate({required bool value}) {
    emit(state.copyWith(showSelectCurrentDate: value));
  }

  Future<void> toggleListView() async {
    final TaskListView listView = state.isCalendarView ? .list : .calendar;

    try {
      await groupsRepository.saveTasksListView(listView);
    } catch (e) {
      _log.severe('Error saving tasks list view: $e', e);
    } finally {
      emit(state.copyWith(listView: listView));
    }
  }

  void updateUserFilter(TaskUserFilter filter, {required bool value}) {
    if (value) {
      emit(state.copyWith(userFilter: filter));
    } else {
      emit(state.copyWith(userFilter: .all));
    }

    if (state.userFilter != .others) {
      emit(state.copyWith(userToFilterBy: null));
    }
  }

  void updateCompletionFilter(
    TaskCompletionFilter filter, {
    required bool value,
  }) {
    if (value) {
      emit(state.copyWith(completionFilter: filter));
    } else {
      emit(state.copyWith(completionFilter: .all));
    }
  }

  void updateStatusFilter(TaskStatusFilter filter, {required bool value}) {
    if (value) {
      emit(state.copyWith(statusFilter: filter));
    } else {
      emit(state.copyWith(statusFilter: .all));
    }
  }

  void updatePriorityFilter(TaskPriorityFilter filter, {required bool value}) {
    if (value) {
      emit(state.copyWith(priorityFilter: filter));
    } else {
      emit(state.copyWith(priorityFilter: .all));
    }
  }

  void updateUserToFilterBy(UserResponse user) {
    if (state.userToFilterBy == user) {
      emit(state.copyWith(userToFilterBy: null));
      return;
    }
    emit(state.copyWith(userToFilterBy: user));
  }

  void updateDateSort(TaskDateSort sort, {required bool value}) {
    if (value) {
      emit(state.copyWith(dateSort: sort));
    } else {
      emit(state.copyWith(dateSort: .newest));
    }
  }

  void updatePrioritySort(TaskPrioritySort sort, {required bool value}) {
    if (value) {
      emit(state.copyWith(prioritySort: sort));
    } else {
      emit(state.copyWith(prioritySort: .none));
    }
  }

  void resetFiltersAndSort() {
    emit(
      state.copyWith(
        statusFilter: .all,
        userFilter: .all,
        userToFilterBy: null,
        priorityFilter: .all,
        completionFilter: .all,
        dateSort: .newest,
        prioritySort: .none,
      ),
    );
  }

  void setShowScrollToTopButton({required bool value}) {
    emit(state.copyWith(showScrollToTopButton: value));
  }

  Future<void> setTaskToDelete(TaskResponse? task) async {
    emit(state.copyWith(taskToDelete: task));
  }

  Future<void> deleteTask(TaskResponse task) async {
    emit(state.copyWith(taskToDelete: null));

    try {
      await tasksRepository.delete(task.id);

      updateTasksForMember(taskId: task.id);
    } catch (e) {
      _log.severe('Error deleting task: $e', e);
    }
  }

  Future<void> toggleTaskStatus(TaskResponse task) async {
    final updatedTask = task.copyWith(completed: !task.completed);

    try {
      await tasksRepository.update(
        id: task.id,
        UpdateTaskRequest(
          title: updatedTask.title,
          description: updatedTask.description,
          dueDate: updatedTask.dueDate,
          priority: updatedTask.priority,
          status: updatedTask.status,
          completed: updatedTask.completed,
          assignedTo: updatedTask.assignedTo.map((user) => user.id).toList(),
          checklist: updatedTask.checklist.map((item) {
            return UpdateTaskChecklistItem(
              title: item.title,
              status: item.status,
              order: item.order,
            );
          }).toList(),
          recurring: updatedTask.recurring,
          recurrencePattern: task.recurrencePattern,
          recurrenceEndDate: task.recurrenceEndDate,
        ),
      );

      updateTasksForMember(taskId: task.id);
    } catch (e) {
      _log.severe('Error updating task: $e', e);
    }
  }

  void toggleLeaveDialog() {
    emit(state.copyWith(showLeaveDialog: !state.showLeaveDialog));
  }

  Future<void> leaveGroup() async {
    final group = state.group;

    if (group == null) {
      return;
    }

    emit(state.copyWith(showLeaveDialog: false, isRefreshing: true));

    try {
      await groupsRepository.leaveGroup(group.id);
      updateGroupForMember(groupId: group.id);
    } catch (e) {
      _log.severe('Error leaving group: $e', e);
    } finally {
      emit(state.copyWith(isRefreshing: false));
    }
  }

  void updateTasksForMember({required String taskId}) {
    tasksWebsocket.updateTasks(taskId: taskId);
  }

  void updateGroupForMember({required String groupId}) {
    groupsWebsocket.updateGroups(groupId: groupId);
  }

  Future<void> dispose() async {
    await _groupsSubscription?.cancel();
    await _tasksSubscription?.cancel();
  }
}

@freezed
sealed class GroupDetailsState with _$GroupDetailsState {
  const factory GroupDetailsState({
    required bool isLoading,
    required List<TaskResponse> tasks,
    required List<InviteResponse> invites,
    required DateTime selectedDate,
    required TaskListView listView,
    required TaskUserFilter userFilter,
    required TaskCompletionFilter completionFilter,
    required TaskStatusFilter statusFilter,
    required TaskPriorityFilter priorityFilter,
    required TaskDateSort dateSort,
    required TaskPrioritySort prioritySort,
    required bool showLeaveDialog,
    required bool isRefreshing,
    required bool shouldGoBack,
    required bool showScrollToTopButton,
    required bool showSelectCurrentDate,
    GroupResponse? group,
    UserData? currentUser,
    UserResponse? userToFilterBy,
    TaskResponse? taskToDelete,
  }) = _GroupDetailsState;

  const GroupDetailsState._();

  Set<UserResponse> get assignedUsers =>
      group?.members.where((member) => member.id != currentUser?.id).toSet() ??
      {};

  List<String> get assignedUsersIds =>
      assignedUsers.map((user) => user.id).toList();

  bool get isCalendarView => listView == .calendar;

  List<TaskResponse> get filteredTasks => tasks
      .where((task) {
        switch (listView) {
          case .calendar:
            return DateUtils.isSameDay(task.dueDate.toLocal(), selectedDate);
          case .list:
            return true;
        }
      })
      .where((task) {
        switch (userFilter) {
          case .all:
            return true;
          case .myself:
            return task.assignedTo.any((user) => user.id == currentUser!.id);
          case .others:
            return task.assignedTo.any((user) {
              if (userToFilterBy != null) {
                return user.id == userToFilterBy!.id;
              } else {
                return true;
              }
            });
        }
      })
      .where((task) {
        switch (completionFilter) {
          case .all:
            return true;
          case .pending:
            return !task.completed;
          case .completed:
            return task.completed;
        }
      })
      .where((task) {
        switch (statusFilter) {
          case .all:
            return true;
          case .todo:
            return task.status == .todo;
          case .inProgress:
            return task.status == .inProgress;
          case .done:
            return task.status == .done;
        }
      })
      .where((task) {
        switch (priorityFilter) {
          case .all:
            return true;
          case .low:
            return task.priority == .low;
          case .medium:
            return task.priority == .medium;
          case .high:
            return task.priority == .high;
        }
      })
      .sorted((a, b) {
        final completedCompare = a.completed.toString().compareTo(
          b.completed.toString(),
        );
        if (completedCompare != 0) return completedCompare;

        int priorityCompare = 0;

        switch (prioritySort) {
          case .lowest:
            priorityCompare = a.priority.index.compareTo(b.priority.index);
            break;
          case .highest:
            priorityCompare = b.priority.index.compareTo(a.priority.index);
            break;
          case .none:
            break;
        }

        if (priorityCompare != 0) return priorityCompare;

        switch (dateSort) {
          case .newest:
            return b.createdAt.compareTo(a.createdAt);
          case .oldest:
            return a.createdAt.compareTo(b.createdAt);
        }
      })
      .toList();
}

enum TaskListView { calendar, list }

enum TaskUserFilter { all, myself, others }

enum TaskCompletionFilter { all, pending, completed }

enum TaskStatusFilter { all, todo, inProgress, done }

enum TaskPriorityFilter { all, low, medium, high }

enum TaskDateSort { newest, oldest }

enum TaskPrioritySort { none, highest, lowest }
