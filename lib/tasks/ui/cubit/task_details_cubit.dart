import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:logging/logging.dart';
import 'package:task_master/auth/auth.dart';
import 'package:task_master/comments/comments.dart';
import 'package:task_master/groups/groups.dart';
import 'package:task_master/tasks/data/models/update_task_request.dart';
import 'package:task_master/tasks/tasks.dart';

part 'task_details_cubit.freezed.dart';

class TaskDetailsCubit extends Cubit<TaskDetailsState> {
  TaskDetailsCubit({
    required this.authRepository,
    required this.tasksRepository,
    required this.commentsRepository,
    required this.tasksWebsocket,
    required this.groupsWebsocket,
    required this.commentsWebsocket,
  }) : super(
         const TaskDetailsState(
           isLoading: false,
           showDeleteDialog: false,
           shouldGoBack: false,
           comments: [],
           comment: '',
           isRefreshing: false,
           isLoadingComments: false,
         ),
       );

  static final _log = Logger('TaskDetailsCubit');

  @visibleForTesting
  final AuthRepository authRepository;

  @visibleForTesting
  final TasksRepository tasksRepository;

  @visibleForTesting
  final CommentsRepository commentsRepository;

  @visibleForTesting
  final TasksWebsocket tasksWebsocket;

  @visibleForTesting
  final GroupsWebsocket groupsWebsocket;

  @visibleForTesting
  final CommentsWebsocket commentsWebsocket;

  UserData get currentUser => authRepository.currentUser.value!;

  StreamSubscription<String>? _tasksSubscription;

  StreamSubscription<String>? _commentsSubscription;

  Future<void> load(String id) async {
    emit(state.copyWith(isLoading: true));

    _tasksSubscription = tasksWebsocket.tasksUpdatedStream.listen((taskId) {
      if (taskId == id) {
        refresh(id);
      }
    });

    _commentsSubscription = commentsWebsocket.commentsUpdatedStream.listen((taskId) {
      if (taskId == id) {
        loadComments(id);
      }
    });

    await Future.wait([loadTask(id), loadComments(id)]);

    emit(state.copyWith(isLoading: false));
  }

  Future<void> refresh(String id) async {
    emit(state.copyWith(isRefreshing: true));
    await loadTask(id);
    emit(state.copyWith(isRefreshing: false));
  }

  Future<void> loadTask(String id) async {
    try {
      final task = await tasksRepository.getById(id);
      emit(state.copyWith(task: task));
    } catch (e) {
      _log.severe('Error loading task: $e', e);
      emit(state.copyWith(shouldGoBack: true));
    }
  }

  Future<void> loadComments(String id) async {
    emit(state.copyWith(isLoadingComments: true));
    try {
      final comments = await commentsRepository.getAll(id);
      emit(state.copyWith(comments: comments));
    } catch (e) {
      _log.severe('Error loading comments: $e', e);
    } finally {
      emit(state.copyWith(isLoadingComments: false));
    }
  }

  Future<void> toggleComplete() async {
    final task = state.task;

    if (task == null) {
      return;
    }

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
          checklist:
              updatedTask.checklist.map((item) {
                return UpdateTaskChecklistItem(title: item.title, status: item.status, order: item.order);
              }).toList(),
          recurring: updatedTask.recurring,
          recurrencePattern: updatedTask.recurrencePattern,
          recurrenceEndDate: updatedTask.recurrenceEndDate,
        ),
      );

      updateTaskForMember();
    } catch (e) {
      _log.severe('Error completing/uncompleting task: $e', e);
    }
  }

  Future<void> duplicateTask(DateTime date, TimeOfDay time) async {
    final task = state.task;

    if (task == null) {
      return;
    }

    emit(state.copyWith(isRefreshing: true));

    try {
      await tasksRepository.create(
        CreateTaskRequest(
          title: task.title,
          description: task.description,
          dueDate: DateTime(date.year, date.month, date.day, time.hour, time.minute).toUtc(),
          priority: task.priority,
          status: task.status,
          group: task.group,
          assignedTo: task.assignedTo.map((user) => user.id).toList(),
          checklist:
              task.checklist.map((item) {
                return CreateTaskChecklistItem(title: item.title, order: item.order);
              }).toList(),
          recurring: task.recurring,
          recurrencePattern: task.recurrencePattern,
          recurrenceEndDate: task.recurrenceEndDate,
        ),
      );
      updateGroupForMember();
    } catch (e) {
      _log.severe('Error duplicating task: $e', e);
    } finally {
      emit(state.copyWith(isRefreshing: false));
    }
  }

  void toggleDeleteDialog() {
    emit(state.copyWith(showDeleteDialog: !state.showDeleteDialog));
  }

  Future<void> deleteTask() async {
    emit(state.copyWith(showDeleteDialog: false, isRefreshing: true));

    final task = state.task;

    if (task == null) {
      return;
    }
    try {
      await tasksRepository.delete(task.id);

      emit(state.copyWith(shouldGoBack: true));
    } catch (e) {
      _log.severe('Error deleting task: $e', e);
    } finally {
      emit(state.copyWith(isRefreshing: false));
    }
  }

  Future<void> updateChecklistItemStatus({required TaskChecklistItem item, required int position, required TaskChecklistItemStatus status}) async {
    final task = state.task;

    if (task == null) {
      return;
    }

    final checklist = List<TaskChecklistItem>.from(task.checklist);

    checklist[position] = item.copyWith(status: status);

    await updateChecklist(task: task, checklist: checklist);
  }

  Future<void> reorderChecklistItemOrder(int oldIndex, int newIndex) async {
    final task = state.task;

    if (task == null) {
      return;
    }

    final checklist = List<TaskChecklistItem>.from(task.checklist);

    if (newIndex > oldIndex) newIndex -= 1;

    final item = checklist.removeAt(oldIndex);
    checklist.insert(newIndex, item);

    final updatedChecklist =
        checklist.indexed.map((item) {
          final index = item.$1;
          final value = item.$2;

          return value.copyWith(order: index);
        }).toList();

    await updateChecklist(task: task, checklist: updatedChecklist);
  }

  Future<void> updateChecklist({required TaskResponse task, required List<TaskChecklistItem> checklist}) async {
    try {
      await tasksRepository.update(
        UpdateTaskRequest(
          title: task.title,
          dueDate: task.dueDate,
          priority: task.priority,
          status: task.status,
          completed: task.completed,
          assignedTo: task.assignedTo.map((assignee) => assignee.id).toList(),
          checklist:
              checklist.map((item) {
                return UpdateTaskChecklistItem(title: item.title, status: item.status, order: item.order);
              }).toList(),
          recurring: task.recurring,
          recurrencePattern: task.recurrencePattern,
          recurrenceEndDate: task.recurrenceEndDate,
        ),
        id: task.id,
      );

      updateTaskForMember();
    } catch (e) {
      _log.severe('Error while updating checklist item status: $e', e);
    }
  }

  void updateComment(String value) {
    emit(state.copyWith(comment: value));
  }

  Future<void> createComment() async {
    final task = state.task;

    if (task == null) {
      return;
    }

    try {
      await commentsRepository.create(CreateCommentRequest(message: state.comment, task: task.id));
      commentsWebsocket.updateComments(taskId: task.id);
    } catch (e) {
      _log.severe('Error creating comment: $e', e);
    } finally {
      emit(state.copyWith(comment: ''));
    }
  }

  Future<void> deleteComment(String id) async {
    final task = state.task;

    if (task == null) {
      return;
    }

    try {
      await commentsRepository.delete(id);
      commentsWebsocket.updateComments(taskId: task.id);
    } catch (e) {
      _log.severe('Error deleting comment: $e', e);
    }
  }

  void updateTaskForMember() {
    final task = state.task;

    if (task == null) {
      return;
    }

    tasksWebsocket.updateTasks(taskId: task.id);
  }

  void updateGroupForMember() {
    final task = state.task;

    if (task == null) {
      return;
    }

    groupsWebsocket.updateGroups(groupId: task.group);
  }

  Future<void> dispose() async {
    await _tasksSubscription?.cancel();
    await _commentsSubscription?.cancel();
  }
}

@freezed
sealed class TaskDetailsState with _$TaskDetailsState {
  const factory TaskDetailsState({
    required bool isLoading,
    required bool showDeleteDialog,
    required bool shouldGoBack,
    required List<CommentResponse> comments,
    required String comment,
    required bool isRefreshing,
    required bool isLoadingComments,
    TaskResponse? task,
  }) = _TaskDetailsState;

  const TaskDetailsState._();

  bool get canSubmit => comment.isNotEmpty;
}
