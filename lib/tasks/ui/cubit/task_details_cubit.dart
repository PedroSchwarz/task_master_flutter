import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:logging/logging.dart';
import 'package:task_master/auth/auth.dart';
import 'package:task_master/comments/comments.dart';
import 'package:task_master/tasks/data/models/update_task_request.dart';
import 'package:task_master/tasks/tasks.dart';

part 'task_details_cubit.freezed.dart';

class TaskDetailsCubit extends Cubit<TaskDetailsState> {
  TaskDetailsCubit({
    required this.authRepository,
    required this.tasksRepository,
    required this.commentsRepository,
    required this.tasksWebsocket,
    required this.commentsWebsocket,
  }) : super(const TaskDetailsState(isLoading: false, showDeleteDialog: false, shouldGoBack: false, comments: [], comment: ''));

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
  final CommentsWebsocket commentsWebsocket;

  UserData get currentUser => authRepository.currentUser.value!;

  StreamSubscription<List<String>>? _tasksSubscription;

  StreamSubscription<List<String>>? _taskSubscription;

  StreamSubscription<String>? _commentsSubscription;

  Future<void> load(String id) async {
    emit(state.copyWith(isLoading: true));

    _tasksSubscription = tasksWebsocket.tasksUpdatedStream.listen((members) {
      if (members.contains(currentUser.id)) {
        loadTask(id);
      }
    });

    _taskSubscription = tasksWebsocket.taskUpdatedStream.listen((members) {
      if (members.contains(currentUser.id)) {
        loadTask(id);
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
    try {
      final comments = await commentsRepository.getAll(id);
      emit(state.copyWith(comments: comments));
    } catch (e) {
      _log.severe('Error loading comments: $e', e);
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
        ),
      );

      updateTaskForMember();
    } catch (e) {
      _log.severe('Error completing/uncompleting task: $e', e);
    } finally {
      emit(state.copyWith(task: updatedTask.copyWith(updatedAt: DateTime.now())));
    }
  }

  void toggleDeleteDialog() {
    emit(state.copyWith(showDeleteDialog: !state.showDeleteDialog));
  }

  Future<void> deleteTask() async {
    emit(state.copyWith(showDeleteDialog: false, isLoading: true));
    final task = state.task;

    if (task == null) {
      return;
    }
    try {
      updateTaskForMember();

      await tasksRepository.delete(task.id);

      emit(state.copyWith(shouldGoBack: true));
    } catch (e) {
      _log.severe('Error deleting task: $e', e);
    } finally {
      emit(state.copyWith(isLoading: false));
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
    }
  }

  void updateTaskForMember() {
    final task = state.task;

    if (task == null) {
      return;
    }

    tasksWebsocket.updateTask(userId: currentUser.id, taskId: task.id);
  }

  Future<void> dispose() async {
    await _tasksSubscription?.cancel();
    await _taskSubscription?.cancel();
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
    TaskResponse? task,
  }) = _TaskDetailsState;

  const TaskDetailsState._();

  bool get isButtonEnabled => comment.isNotEmpty;
}
