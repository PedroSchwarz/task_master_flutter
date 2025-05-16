import 'package:socket_io_client/socket_io_client.dart';
import 'package:task_master/app/websocket/websocket_client.dart';

typedef UpdateGroupsCallback = Future<void> Function(String);

class GroupsWebsocket {
  GroupsWebsocket._({required Socket socket}) : _socket = socket;

  factory GroupsWebsocket({required WebsocketClient client}) {
    final connection = client.buildSocket(topic: WebsocketTopic.groups);
    return GroupsWebsocket._(socket: connection);
  }

  late final Socket _socket;
  bool _isConnected = false;

  void listen({required UpdateGroupsCallback groupsCallback, required WebsocketTrigger trigger}) {
    _connectIfNeeded();

    switch (trigger) {
      case WebsocketTrigger.groupsUpdated:
        _socket.on(trigger.event, (groupId) {
          groupsCallback(groupId);
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

  void updateGroups({required String groupId}) {
    _connectIfNeeded();
    _socket.emit(WebsocketAction.groupsUpdated.event, {'groupId': groupId});
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
