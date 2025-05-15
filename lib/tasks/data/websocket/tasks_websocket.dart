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

  void listen({required UpdateTasksCallback taskscallback, required WebsocketTrigger trigger}) {
    _connectIfNeeded();

    switch (trigger) {
      case WebsocketTrigger.tasksUpdated:
        _socket.on(trigger.event, (members) {
          if (members is List) {
            final casted = members.cast<String>();
            taskscallback(casted);
          }
        });
      case WebsocketTrigger.taskUpdated:
        _socket.on(trigger.event, (members) {
          if (members is List) {
            final casted = members.cast<String>();
            taskscallback(casted);
          }
        });
      default:
        break;
    }
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

  Future<void> close(WebsocketTrigger trigger) async {
    _socket.off(trigger.event);
  }

  void dispose() {
    if (_isConnected) {
      _socket.dispose();
      _isConnected = false;
    }
  }
}
