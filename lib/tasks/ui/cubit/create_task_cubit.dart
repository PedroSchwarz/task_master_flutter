import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:intl/intl.dart';
import 'package:logging/logging.dart';
import 'package:task_master/groups/data/models/group_response.dart';
import 'package:task_master/groups/data/repository/groups_repository.dart';
import 'package:task_master/tasks/data/models/task_values.dart';
import 'package:task_master/tasks/tasks.dart';
import 'package:task_master/users/users.dart';

part 'create_task_cubit.freezed.dart';

class CreateTaskCubit extends Cubit<CreateTaskState> {
  CreateTaskCubit({required this.groupsRepository, required this.tasksRepository})
    : super(
        CreateTaskState(
          isLoading: false,
          title: '',
          priority: TaskPriority.medium,
          status: TaskStatus.todo,
          date: DateTime.now(),
          time: const TimeOfDay(hour: 8, minute: 0),
          assignedIds: {},
          shouldGoBack: false,
        ),
      );

  static final _log = Logger('CreateTaskCubit');

  @visibleForTesting
  final GroupsRepository groupsRepository;

  @visibleForTesting
  final TasksRepository tasksRepository;

  Future<void> load({required String groupId}) async {
    emit(state.copyWith(isLoading: true));

    try {
      final group = await groupsRepository.getGroupById(groupId);
      emit(state.copyWith(group: group));
    } catch (e) {
      _log.severe('Error loading group: $e', e);
    } finally {
      emit(state.copyWith(isLoading: false));
    }
  }

  void updateTitle(String title) {
    emit(state.copyWith(title: title));
  }

  void updateDescription(String description) {
    emit(state.copyWith(description: description));
  }

  void updatePriority(TaskPriority? priority) {
    if (priority == null) {
      return;
    }

    emit(state.copyWith(priority: priority));
  }

  void updateStatus(TaskStatus? status) {
    if (status == null) {
      return;
    }

    emit(state.copyWith(status: status));
  }

  void updateDate(DateTime? date) {
    if (date == null) {
      return;
    }

    emit(state.copyWith(date: date));
  }

  void updateTime(TimeOfDay? time) {
    if (time == null) {
      return;
    }

    emit(state.copyWith(time: time));
  }

  void toggleAssignment(String memberId) {
    if (state.assignedIds.contains(memberId)) {
      emit(state.copyWith(assignedIds: state.assignedIds.where((id) => id != memberId).toSet()));
      return;
    }

    emit(state.copyWith(assignedIds: {...state.assignedIds, memberId}));
  }

  Future<void> createTask() async {
    emit(state.copyWith(isLoading: true));

    final group = state.group;

    if (group == null) {
      emit(state.copyWith(isLoading: false));
      return;
    }

    try {
      await tasksRepository.create(
        CreateTaskRequest(
          title: state.title,
          description: state.description,
          priority: state.priority,
          status: state.status,
          dueDate: DateTime(state.date.year, state.date.month, state.date.day, state.time.hour, state.time.minute),
          group: group.id,
          assignedTo: state.assignedIds.toList(),
        ),
      );

      emit(state.copyWith(shouldGoBack: true));
    } catch (e) {
      _log.severe('Error creating task: $e', e);
    } finally {
      emit(state.copyWith(isLoading: false));
    }
  }
}

@freezed
sealed class CreateTaskState with _$CreateTaskState {
  const factory CreateTaskState({
    required bool isLoading,
    required String title,
    required TaskPriority priority,
    required TaskStatus status,
    required DateTime date,
    required TimeOfDay time,
    required Set<String> assignedIds,
    required bool shouldGoBack,
    String? description,
    GroupResponse? group,
  }) = _CreateTaskState;

  const CreateTaskState._();

  String get formattedDate {
    final formatter = DateFormat('dd/MM/yyyy');
    return formatter.format(date.toLocal());
  }

  String get formattedTime {
    final formatter = DateFormat('hh:mm a');
    return formatter.format(DateTime(date.year, date.month, date.day, time.hour, time.minute));
  }

  List<UserResponse> get assignableUsers => group != null ? [...group!.members, group!.owner] : [];

  bool get isFormValid => title.isNotEmpty;

  bool get isButtonEnabled => isFormValid && !isLoading;
}
