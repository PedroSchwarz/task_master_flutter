import 'package:socket_io_client/socket_io_client.dart';
import 'package:task_master/app/websocket/websocket_client.dart';

typedef UpdateCommentsCallback = Future<void> Function(String);

class CommentsWebsocket {
  CommentsWebsocket._({required Socket socket}) : _socket = socket;

  factory CommentsWebsocket({required WebsocketClient client}) {
    final connection = client.buildSocket(topic: WebsocketTopic.comments);
    return CommentsWebsocket._(socket: connection);
  }

  late final Socket _socket;
  bool _isConnected = false;

  void listen({required UpdateCommentsCallback commentscallback, required WebsocketTrigger trigger}) {
    _connectIfNeeded();

    switch (trigger) {
      case WebsocketTrigger.commentsUpdated:
        _socket.on(trigger.event, (taskId) {
          commentscallback(taskId);
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

  void updateComments({required String taskId}) {
    _connectIfNeeded();
    _socket.emit(WebsocketAction.commentsUpdated.event, {'taskId': taskId});
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
