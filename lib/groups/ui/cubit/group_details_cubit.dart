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
  GroupDetailsCubit({required this.authRepository, required this.groupsRepository, required this.tasksRepository, required this.invitesRepository})
    : super(
        const GroupDetailsState(
          isLoading: false,
          tasks: [],
          invites: [],
          showFilters: false,
          userFilter: TaskUserFilter.all,
          statusFilter: TaskStatusFilter.all,
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

  UserData get currentUser => authRepository.currentUser.value!;

  Future<void> load({required String groupId}) async {
    emit(state.copyWith(isLoading: true));

    try {
      await Future.wait([loadGroup(groupId: groupId), loadTasks(groupId: groupId)]);
      emit(state.copyWith(invites: [], currentUser: authRepository.currentUser.value));
    } catch (e) {
      _log.severe('Error loading cubit: $e', e);
    } finally {
      emit(state.copyWith(isLoading: false));
    }
  }

  Future<void> loadGroup({required String groupId}) async {
    try {
      final group = await groupsRepository.getGroupById(groupId);
      emit(state.copyWith(group: group));
    } catch (e) {
      _log.severe('Error loading group: $e', e);
    }
  }

  Future<void> loadTasks({required String groupId}) async {
    try {
      final tasks = await tasksRepository.fetchAll(groupId);
      emit(state.copyWith(tasks: tasks));
    } catch (e) {
      _log.severe('Error loading tasks: $e', e);
    }
  }

  void updateUserFilter(TaskUserFilter filter, {required bool value}) {
    if (value) {
      emit(state.copyWith(userFilter: filter));
    } else {
      emit(state.copyWith(userFilter: TaskUserFilter.all));
    }

    if (state.userFilter != TaskUserFilter.others) {
      emit(state.copyWith(userToFilterBy: null));
    }
  }

  void updateStatusFilter(TaskStatusFilter filter, {required bool value}) {
    if (value) {
      emit(state.copyWith(statusFilter: filter));
    } else {
      emit(state.copyWith(statusFilter: TaskStatusFilter.all));
    }
  }

  void updateUserToFilterBy(UserResponse user) {
    if (state.userToFilterBy == user) {
      emit(state.copyWith(userToFilterBy: null));
      return;
    }
    emit(state.copyWith(userToFilterBy: user));
  }

  void toggleFiltersVisibility() {
    emit(state.copyWith(showFilters: !state.showFilters));
  }

  void setTaskToDelete(TaskResponse? task) {
    emit(state.copyWith(taskToDelete: task));
  }

  Future<void> deleteTask(TaskResponse task) async {
    try {
      await tasksRepository.delete(task.id);
    } catch (e) {
      _log.severe('Error deleting task: $e', e);
    } finally {
      final tasks = state.tasks;
      final updatedTasks = List<TaskResponse>.from(tasks);
      final index = tasks.indexWhere((item) => item.id == task.id);
      updatedTasks.removeAt(index);
      emit(state.copyWith(tasks: updatedTasks, taskToDelete: null));
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
        ),
      );
    } catch (e) {
      _log.severe('Error updating task: $e', e);
    } finally {
      final tasks = state.tasks;
      final index = tasks.indexWhere((item) => item.id == task.id);
      final updatedTasks = List<TaskResponse>.from(tasks);
      updatedTasks[index] = updatedTask;
      emit(state.copyWith(tasks: updatedTasks));
    }
  }

  void signOut() async {
    await authRepository.signOut();
  }
}

@freezed
sealed class GroupDetailsState with _$GroupDetailsState {
  const factory GroupDetailsState({
    required bool isLoading,
    required List<TaskResponse> tasks,
    required List<InviteResponse> invites,
    required bool showFilters,
    required TaskUserFilter userFilter,
    required TaskStatusFilter statusFilter,
    GroupResponse? group,
    UserData? currentUser,
    UserResponse? userToFilterBy,
    TaskResponse? taskToDelete,
  }) = _GroupDetailsState;

  const GroupDetailsState._();

  Set<UserResponse> get assignedUsers => tasks.expand((task) => task.assignedTo).where((user) => user.id != currentUser?.id).toSet();

  List<TaskResponse> get filteredTasks =>
      tasks
          .where((task) {
            switch (userFilter) {
              case TaskUserFilter.all:
                return true;
              case TaskUserFilter.owner:
                return task.assignedTo.any((user) => user.id == currentUser!.id);
              case TaskUserFilter.others:
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
            switch (statusFilter) {
              case TaskStatusFilter.all:
                return true;
              case TaskStatusFilter.pending:
                return !task.completed;
              case TaskStatusFilter.completed:
                return task.completed;
            }
          })
          .toList();
}

enum TaskUserFilter {
  all(title: 'All'),
  owner(title: 'Myself'),
  others(title: 'Others');

  const TaskUserFilter({required this.title});
  final String title;
}

enum TaskStatusFilter {
  all(title: 'All'),
  pending(title: 'Pending'),
  completed(title: 'Completed');

  const TaskStatusFilter({required this.title});
  final String title;
}
