import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:task_master/app/websocket/websocket_client.dart';

class TasksWebsocket {
  TasksWebsocket._({required Socket socket}) : _socket = socket;

  factory TasksWebsocket({required WebsocketClient client}) {
    final connection = client.buildSocket(topic: .tasks);
    return TasksWebsocket._(socket: connection);
  }

  late final Socket _socket;
  bool _isConnected = false;

  @visibleForTesting
  final tasksUpdatedController = ReplaySubject<String>(maxSize: 1);
  Stream<String> get tasksUpdatedStream => tasksUpdatedController.stream;

  void listen() {
    _connectIfNeeded();
    _socket.on(WebsocketTrigger.tasksUpdated.event, (taskId) {
      if (tasksUpdatedController.hasListener) {
        tasksUpdatedController.add(taskId);
      }
    });
  }

  void _connectIfNeeded() {
    if (!_isConnected) {
      _socket.connect();
      _isConnected = true;
    }
  }

  void updateTasks({required String taskId}) {
    _connectIfNeeded();
    _socket.emit(WebsocketAction.tasksUpdated.event, {'taskId': taskId});
  }

  void dispose() {
    if (_isConnected) {
      _socket.dispose();
      _isConnected = false;
    }
  }
}
