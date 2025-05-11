import 'package:flutter/material.dart';
import 'package:task_master/comments/comments.dart';

class CommentItem extends StatelessWidget {
  const CommentItem({required this.comment, super.key});

  final CommentResponse comment;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(child: Text('${comment.owner.firstName[0]}${comment.owner.lastName[0]}')),
      title: Text(comment.message),
      subtitle: Text(comment.formattedCreatedAt),
    );
  }
}
