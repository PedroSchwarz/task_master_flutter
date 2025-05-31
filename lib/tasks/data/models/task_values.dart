import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

enum TaskPriority {
  @JsonValue('low')
  low(icon: Icons.circle, color: Color.fromARGB(255, 57, 167, 23)),
  @JsonValue('medium')
  medium(icon: Icons.circle, color: Color.fromARGB(255, 227, 176, 24)),
  @JsonValue('high')
  high(icon: Icons.circle, color: Color.fromARGB(255, 195, 44, 33));

  const TaskPriority({required this.icon, required this.color});

  final IconData icon;
  final Color color;
}

enum TaskStatus {
  @JsonValue('todo')
  todo(icon: Icons.circle, color: Color.fromARGB(255, 211, 116, 44)),
  @JsonValue('in_progress')
  inProgress(icon: Icons.circle, color: Color.fromARGB(255, 60, 113, 220)),
  @JsonValue('done')
  done(icon: Icons.circle, color: Color.fromARGB(255, 57, 167, 23));

  const TaskStatus({required this.icon, required this.color});

  final IconData icon;
  final Color color;
}
