import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/retrofit.dart';
import 'package:task_master/tasks/data/models/create_task_request.dart';
import 'package:task_master/tasks/data/models/simplified_task_response.dart';
import 'package:task_master/tasks/data/models/task_response.dart';
import 'package:task_master/tasks/data/models/update_task_request.dart';

part 'tasks_remote_data_source.g.dart';

@RestApi(baseUrl: '/tasks')
abstract class TasksRemoteDataSource {
  factory TasksRemoteDataSource(Dio dio, {String? baseUrl, ParseErrorLogger? errorLogger}) = _TasksRemoteDataSource;

  @GET('/group/{groupId}')
  @Headers(<String, dynamic>{'Content-Type': 'application/json'})
  Future<List<TaskResponse>> fetchAll(@Path('groupId') String groupId);

  @GET('/user/assigned')
  @Headers(<String, dynamic>{'Content-Type': 'application/json'})
  Future<List<SimplifiedTaskResponse>> fetchAllAssigned();

  @GET('/user/owner')
  @Headers(<String, dynamic>{'Content-Type': 'application/json'})
  Future<List<SimplifiedTaskResponse>> fetchAllOwned();

  @GET('/upcoming')
  @Headers(<String, dynamic>{'Content-Type': 'application/json'})
  Future<List<TaskResponse>> fetchUpcoming();

  @GET('/overdue')
  @Headers(<String, dynamic>{'Content-Type': 'application/json'})
  Future<List<TaskResponse>> fetchOverdue();

  @GET('/{id}')
  @Headers(<String, dynamic>{'Content-Type': 'application/json'})
  Future<TaskResponse> fetchById(@Path('id') String id);

  @POST('/')
  @Headers(<String, dynamic>{'Content-Type': 'application/json'})
  Future<String> create(@Body() CreateTaskRequest request);

  @PUT('/{id}')
  @Headers(<String, dynamic>{'Content-Type': 'application/json'})
  Future<void> update(@Path('id') String id, @Body() UpdateTaskRequest request);

  @DELETE('/{id}')
  @Headers(<String, dynamic>{'Content-Type': 'application/json'})
  Future<void> delete(@Path('id') String id);
}
