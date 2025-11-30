import 'package:flutter/foundation.dart';
import 'package:rxdart/rxdart.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:task_master/app/websocket/websocket_client.dart';

class GroupsWebsocket {
  GroupsWebsocket._({required Socket socket}) : _socket = socket;

  factory GroupsWebsocket({required WebsocketClient client}) {
    final connection = client.buildSocket(topic: .groups);
    return GroupsWebsocket._(socket: connection);
  }

  late final Socket _socket;
  bool _isConnected = false;

  @visibleForTesting
  final groupsUpdatedController = ReplaySubject<String>(maxSize: 1);
  Stream<String> get groupsUpdatedStream => groupsUpdatedController.stream;

  void listen() {
    _connectIfNeeded();
    _socket.on(WebsocketTrigger.groupsUpdated.event, (groupId) {
      if (groupsUpdatedController.hasListener) {
        groupsUpdatedController.add(groupId);
      }
    });
  }

  void _connectIfNeeded() {
    if (!_isConnected) {
      _socket.connect();
      _isConnected = true;
    }
  }

  void updateGroups({required String groupId}) {
    _connectIfNeeded();
    _socket.emit(WebsocketAction.groupsUpdated.event, {'groupId': groupId});
  }

  void dispose() {
    if (_isConnected) {
      _socket.dispose();
      _isConnected = false;
    }
  }
}
