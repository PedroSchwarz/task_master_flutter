import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

enum TaskPriority {
  @JsonValue('low')
  low(title: 'Low', icon: Icons.trending_down, color: Colors.green),
  @JsonValue('medium')
  medium(title: 'Medium', icon: Icons.trending_flat, color: Colors.amber),
  @JsonValue('high')
  high(title: 'High', icon: Icons.trending_up, color: Colors.red);

  const TaskPriority({required this.title, required this.icon, required this.color});

  final String title;
  final IconData icon;
  final Color color;
}

enum TaskStatus {
  @JsonValue('todo')
  todo(title: 'To Do', icon: Icons.circle, color: Colors.purple),
  @JsonValue('in_progress')
  inProgress(title: 'In Progress', icon: Icons.circle, color: Colors.blue),
  @JsonValue('done')
  done(title: 'Done', icon: Icons.circle, color: Colors.green);

  const TaskStatus({required this.title, required this.icon, required this.color});

  final String title;
  final IconData icon;
  final Color color;
}
