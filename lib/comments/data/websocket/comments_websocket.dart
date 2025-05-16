import 'package:flutter/foundation.dart';
import 'package:rxdart/rxdart.dart';
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

  @visibleForTesting
  final commentsUpdatedController = ReplaySubject<String>(maxSize: 1);
  Stream<String> get commentsUpdatedStream => commentsUpdatedController.stream;

  void listen() {
    _connectIfNeeded();
    _socket.on(WebsocketTrigger.commentsUpdated.event, (taskId) {
      if (commentsUpdatedController.hasListener) {
        commentsUpdatedController.add(taskId);
      }
    });
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

  void dispose() {
    if (_isConnected) {
      _socket.dispose();
      _isConnected = false;
    }
  }
}
