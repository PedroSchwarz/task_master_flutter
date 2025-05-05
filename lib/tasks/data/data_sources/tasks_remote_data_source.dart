import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/retrofit.dart';
import 'package:task_master/tasks/data/models/create_task_request.dart';
import 'package:task_master/tasks/data/models/task_response.dart';

part 'tasks_remote_data_source.g.dart';

@RestApi(baseUrl: '/tasks')
abstract class TasksRemoteDataSource {
  factory TasksRemoteDataSource(Dio dio, {String? baseUrl}) = _TasksRemoteDataSource;

  @GET('/group/{groupId}')
  @Headers(<String, dynamic>{'Content-Type': 'application/json'})
  Future<List<TaskResponse>> fetchAll(@Path('groupId') String groupId);

  @POST('/')
  @Headers(<String, dynamic>{'Content-Type': 'application/json'})
  Future<String> create(@Body() CreateTaskRequest request);
}
