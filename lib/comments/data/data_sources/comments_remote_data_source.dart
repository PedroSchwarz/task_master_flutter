import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/retrofit.dart';
import 'package:task_master/comments/data/models/comment_response.dart';
import 'package:task_master/comments/data/models/create_comment_request.dart';

part 'comments_remote_data_source.g.dart';

@RestApi(baseUrl: '/comments')
abstract class CommentsRemoteDataSource {
  factory CommentsRemoteDataSource(Dio dio, {String? baseUrl, ParseErrorLogger? errorLogger}) = _CommentsRemoteDataSource;

  @GET('/task/{taskId}')
  @Headers(<String, dynamic>{'Content-Type': 'application/json'})
  Future<List<CommentResponse>> fetchAll(@Path('taskId') String taskId);

  @POST('/')
  @Headers(<String, dynamic>{'Content-Type': 'application/json'})
  Future<void> create(@Body() CreateCommentRequest request);

  @DELETE('/{id}')
  @Headers(<String, dynamic>{'Content-Type': 'application/json'})
  Future<void> delete(@Path('id') String id);
}
