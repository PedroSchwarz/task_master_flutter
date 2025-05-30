import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

enum TaskPriority {
  @JsonValue('low')
  low(title: 'Low', icon: Icons.circle, color: Color.fromARGB(255, 57, 167, 23)),
  @JsonValue('medium')
  medium(title: 'Medium', icon: Icons.circle, color: Color.fromARGB(255, 227, 176, 24)),
  @JsonValue('high')
  high(title: 'High', icon: Icons.circle, color: Color.fromARGB(255, 195, 44, 33));

  const TaskPriority({required this.title, required this.icon, required this.color});

  final String title;
  final IconData icon;
  final Color color;
}

enum TaskStatus {
  @JsonValue('todo')
  todo(title: 'To do', icon: Icons.circle, color: Color.fromARGB(255, 211, 116, 44)),
  @JsonValue('in_progress')
  inProgress(title: 'In Progress', icon: Icons.circle, color: Color.fromARGB(255, 60, 113, 220)),
  @JsonValue('done')
  done(title: 'Done', icon: Icons.circle, color: Color.fromARGB(255, 57, 167, 23));

  const TaskStatus({required this.title, required this.icon, required this.color});

  final String title;
  final IconData icon;
  final Color color;
}
