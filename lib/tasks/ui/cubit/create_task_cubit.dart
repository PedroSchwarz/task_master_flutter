import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:intl/intl.dart';
import 'package:logging/logging.dart';
import 'package:task_master/groups/data/models/group_response.dart';
import 'package:task_master/groups/data/repository/groups_repository.dart';
import 'package:task_master/tasks/data/models/task_values.dart';
import 'package:task_master/tasks/data/models/update_task_request.dart';
import 'package:task_master/tasks/tasks.dart';
import 'package:task_master/users/users.dart';
import 'package:uuid/uuid.dart';

part 'create_task_cubit.freezed.dart';

class CreateTaskCubit extends Cubit<CreateTaskState> {
  CreateTaskCubit({required this.groupsRepository, required this.tasksRepository, required this.uuid})
    : super(
        CreateTaskState(
          isLoading: false,
          title: '',
          checklist: [],
          priority: TaskPriority.medium,
          status: TaskStatus.todo,
          date: DateTime.now().add(const Duration(days: 1)),
          time: const TimeOfDay(hour: 8, minute: 0),
          assignedIds: {},
          isSubmitting: false,
          shouldGoBack: false,
        ),
      );

  static final _log = Logger('CreateTaskCubit');

  @visibleForTesting
  final GroupsRepository groupsRepository;

  @visibleForTesting
  final TasksRepository tasksRepository;

  @visibleForTesting
  final Uuid uuid;

  Future<void> load({required String groupId, String? taskId}) async {
    await Future.wait([loadGroup(groupId), if (taskId != null) loadTask(taskId)]);
  }

  Future<void> loadGroup(String id) async {
    try {
      final group = await groupsRepository.getGroupById(id);
      emit(state.copyWith(group: group));
    } catch (e) {
      _log.severe('Error loading group: $e', e);
    }
  }

  Future<void> loadTask(String id) async {
    emit(state.copyWith(isLoading: true));

    try {
      final task = await tasksRepository.getById(id);
      emit(
        state.copyWith(
          task: task,
          title: task.title,
          description: task.description,
          date: task.dueDate.toLocal(),
          time: TimeOfDay.fromDateTime(task.dueDate.toLocal()),
          priority: task.priority,
          status: task.status,
          assignedIds: task.assignedTo.map((assignee) => assignee.id).toSet(),
          checklist: task.checklist,
        ),
      );
    } catch (e) {
      _log.severe('Error loading task: $e', e);
    } finally {
      emit(state.copyWith(isLoading: false));
    }
  }

  void updateTitle(String title) {
    emit(state.copyWith(title: title));
  }

  void addChecklistItem() {
    final checklist = List<TaskChecklistItem>.from(state.checklist);

    emit(
      state.copyWith(checklist: [...checklist, TaskChecklistItem(id: uuid.v4(), status: TaskChecklistItemStatus.incomplete, title: '', order: 0)]),
    );

    updateChecklistItemsOrder();
  }

  void updateChecklistItem({required int index, required String value}) {
    final checklist = List<TaskChecklistItem>.from(state.checklist);

    if (index >= 0 && index < checklist.length) {
      checklist[index] = checklist[index].copyWith(title: value);

      emit(state.copyWith(checklist: checklist));
    }
  }

  void reorderChecklistItem(int oldIndex, int newIndex) {
    final checklist = List<TaskChecklistItem>.from(state.checklist);

    if (newIndex > oldIndex) newIndex -= 1;

    final item = checklist.removeAt(oldIndex);
    checklist.insert(newIndex, item);

    emit(state.copyWith(checklist: checklist));

    updateChecklistItemsOrder();
  }

  void removeChecklistItem({required int index}) {
    final checklist = List<TaskChecklistItem>.from(state.checklist);

    if (index >= 0 && index < checklist.length) {
      checklist.removeAt(index);
      emit(state.copyWith(checklist: checklist));
      updateChecklistItemsOrder();
    }
  }

  void updateChecklistItemsOrder() {
    final checklist = List<TaskChecklistItem>.from(state.checklist);

    final updatedChecklist =
        checklist.indexed.map((item) {
          final index = item.$1;
          final value = item.$2;

          return value.copyWith(order: index);
        }).toList();

    emit(state.copyWith(checklist: updatedChecklist));
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

  Future<void> saveTask() async {
    emit(state.copyWith(isSubmitting: true));

    if (state.isUpdating) {
      await updateTask();
    } else {
      await createTask();
    }

    emit(state.copyWith(isSubmitting: false));
  }

  Future<void> createTask() async {
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
          dueDate: DateTime(state.date.year, state.date.month, state.date.day, state.time.hour, state.time.minute).toUtc(),
          group: group.id,
          assignedTo: state.assignedIds.toList(),
          checklist:
              state.checklist.map((item) {
                return CreateTaskChecklistItem(title: item.title, order: item.order);
              }).toList(),
        ),
      );

      emit(state.copyWith(shouldGoBack: true));
    } catch (e) {
      _log.severe('Error creating task: $e', e);
    }
  }

  Future<void> updateTask() async {
    final task = state.task;

    if (task == null) {
      emit(state.copyWith(isLoading: false));
      return;
    }

    try {
      await tasksRepository.update(
        id: task.id,
        UpdateTaskRequest(
          title: state.title,
          description: state.description,
          priority: state.priority,
          status: state.status,
          dueDate: DateTime(state.date.year, state.date.month, state.date.day, state.time.hour, state.time.minute).toUtc(),
          assignedTo: state.assignedIds.toList(),
          completed: task.completed,
          checklist:
              state.checklist.map((item) {
                return UpdateTaskChecklistItem(title: item.title, status: item.status, order: item.order);
              }).toList(),
        ),
      );

      emit(state.copyWith(shouldGoBack: true));
    } catch (e) {
      _log.severe('Error updating task: $e', e);
    }
  }
}

@freezed
sealed class CreateTaskState with _$CreateTaskState {
  const factory CreateTaskState({
    required bool isLoading,
    required String title,
    required List<TaskChecklistItem> checklist,
    required TaskPriority priority,
    required TaskStatus status,
    required DateTime date,
    required TimeOfDay time,
    required Set<String> assignedIds,
    required bool isSubmitting,
    required bool shouldGoBack,
    String? description,
    GroupResponse? group,
    TaskResponse? task,
  }) = _CreateTaskState;

  const CreateTaskState._();

  String get formattedDate {
    final formatter = DateFormat('dd/MM/yyyy');
    return formatter.format(date);
  }

  String get formattedTime {
    final formatter = DateFormat('hh:mm a');
    return formatter.format(DateTime(date.year, date.month, date.day, time.hour, time.minute));
  }

  List<UserResponse> get assignableUsers => group != null ? {...group!.members, group!.owner}.toList() : [];

  bool get isUpdating => task != null;

  bool get isFormValid => title.isNotEmpty;

  bool get canSubmit => isFormValid && !isLoading && !isSubmitting;
}
