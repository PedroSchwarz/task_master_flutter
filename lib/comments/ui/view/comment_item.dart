import 'package:flutter/material.dart';
import 'package:task_master/comments/comments.dart';

class CommentItem extends StatefulWidget {
  const CommentItem({required this.comment, super.key});

  final CommentResponse comment;

  @override
  State<CommentItem> createState() => _CommentItemState();
}

class _CommentItemState extends State<CommentItem> {
  bool show = true;

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      initiallyExpanded: show,
      dense: true,
      shape: const BeveledRectangleBorder(),
      onExpansionChanged: (value) {
        setState(() {
          show = !show;
        });
      },
      leading: CircleAvatar(child: Text('${widget.comment.owner.firstName[0]}${widget.comment.owner.lastName[0]}')),
      title: Text(widget.comment.formattedCreatedAt),
      children: [ListTile(title: Text(widget.comment.message))],
    );
  }
}
