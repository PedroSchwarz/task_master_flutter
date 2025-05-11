import 'package:flutter/foundation.dart';
import 'package:task_master/comments/comments.dart';

class CommentsRepository {
  const CommentsRepository({required this.commentsRemoteDataSource});

  @visibleForTesting
  final CommentsRemoteDataSource commentsRemoteDataSource;

  Future<List<CommentResponse>> getAll(String id) async {
    return commentsRemoteDataSource.fetchAll(id);
  }

  Future<void> create(CreateCommentRequest request) async {
    return commentsRemoteDataSource.create(request);
  }

  Future<void> delete(String id) async {
    return commentsRemoteDataSource.delete(id);
  }
}
