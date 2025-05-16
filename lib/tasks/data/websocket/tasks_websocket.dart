import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:task_master/app/websocket/websocket_client.dart';

typedef UpdateTasksCallback = Future<void> Function(List<String>);

class TasksWebsocket {
  TasksWebsocket._({required Socket socket}) : _socket = socket;

  factory TasksWebsocket({required WebsocketClient client}) {
    final connection = client.buildSocket(topic: WebsocketTopic.tasks);
    return TasksWebsocket._(socket: connection);
  }

  late final Socket _socket;
  bool _isConnected = false;

  @visibleForTesting
  final tasksUpdatedController = ReplaySubject<List<String>>(maxSize: 1);
  Stream<List<String>> get tasksUpdatedStream => tasksUpdatedController.stream;

  @visibleForTesting
  final taskUpdatedController = ReplaySubject<List<String>>(maxSize: 1);
  Stream<List<String>> get taskUpdatedStream => taskUpdatedController.stream;

  void listen() {
    _connectIfNeeded();
    _socket.on(WebsocketTrigger.tasksUpdated.event, (members) {
      if (tasksUpdatedController.hasListener) {
        if (members is List) {
          final casted = members.cast<String>();
          tasksUpdatedController.add(casted);
        }
      }
    });

    _socket.on(WebsocketTrigger.taskUpdated.event, (members) {
      if (taskUpdatedController.hasListener) {
        if (members is List) {
          final casted = members.cast<String>();
          taskUpdatedController.add(casted);
        }
      }
    });
  }

  void _connectIfNeeded() {
    if (!_isConnected) {
      _socket.connect();
      _isConnected = true;
    }
  }

  void updateTasks({required List<String> members}) {
    _connectIfNeeded();
    _socket.emit(WebsocketAction.tasksUpdated.event, {'members': members});
  }

  void updateTask({required String userId, required String taskId}) {
    _connectIfNeeded();
    _socket.emit(WebsocketAction.taskUpdated.event, {'userId': userId, 'taskId': taskId});
  }

  void dispose() {
    if (_isConnected) {
      _socket.dispose();
      _isConnected = false;
    }
  }
}
