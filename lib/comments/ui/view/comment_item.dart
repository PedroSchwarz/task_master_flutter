import 'package:flutter/material.dart';
import 'package:task_master/app/design_system/theme/app_spacing.dart';
import 'package:task_master/comments/comments.dart';

class CommentItem extends StatefulWidget {
  const CommentItem({required this.comment, required this.canDelete, required this.onDelete, super.key});

  final CommentResponse comment;
  final bool canDelete;
  final Future<void> Function() onDelete;

  @override
  State<CommentItem> createState() => _CommentItemState();
}

class _CommentItemState extends State<CommentItem> {
  bool isExpanded = true;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(widget.comment.id),
      dismissThresholds: const {DismissDirection.startToEnd: 0.6},
      direction: widget.canDelete ? DismissDirection.startToEnd : DismissDirection.none,
      confirmDismiss: (_) async {
        await widget.onDelete();
        return false;
      },
      background: Container(
        padding: isExpanded ? const EdgeInsets.all(AppSpacing.m) : const EdgeInsets.symmetric(horizontal: AppSpacing.m),
        alignment: Alignment.centerLeft,
        decoration: const BoxDecoration(color: Colors.red),
        child: const Icon(Icons.delete_outline, color: Colors.white, size: 32),
      ),
      child: ExpansionTile(
        initiallyExpanded: isExpanded,
        dense: true,
        shape: const BeveledRectangleBorder(),
        onExpansionChanged: (value) {
          setState(() {
            isExpanded = !isExpanded;
          });
        },
        leading: CircleAvatar(child: Text(widget.comment.owner.initials)),
        title: Text(widget.comment.formattedCreatedAt),
        children: [ListTile(title: Text(widget.comment.message))],
      ),
    );
  }
}
