import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;
import 'package:task_master/app/configurations/configurations.dart';

class WebsocketClient {
  const WebsocketClient({required this.configurations});

  @visibleForTesting
  final BuildConfigurations configurations;

  io.Socket buildSocket({required WebsocketTopic topic}) {
    return io.io('${configurations.baseUrl}${topic.context}', io.OptionBuilder().setTransports(['websocket']).disableAutoConnect().build());
  }
}

enum WebsocketTopic {
  tasks(context: 'tasks-events');

  const WebsocketTopic({required this.context});

  final String context;
}

enum WebsocketAction {
  tasksUpdated(event: 'tasks_updated'),
  taskUpdated(event: 'task_updated');

  const WebsocketAction({required this.event});

  final String event;
}

enum WebsocketTrigger {
  tasksUpdated(event: 'update_tasks'),
  taskUpdated(event: 'update_task');

  const WebsocketTrigger({required this.event});

  final String event;
}
