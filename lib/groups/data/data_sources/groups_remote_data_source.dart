import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/retrofit.dart';
import 'package:task_master/groups/data/models/create_group_request.dart';
import 'package:task_master/groups/data/models/group_response.dart';
import 'package:task_master/groups/data/models/update_group_request.dart';

part 'groups_remote_data_source.g.dart';

@RestApi(baseUrl: '/groups')
abstract class GroupsRemoteDataSource {
  factory GroupsRemoteDataSource(Dio dio, {String? baseUrl, ParseErrorLogger? errorLogger}) = _GroupsRemoteDataSource;

  @GET('/')
  @Headers(<String, dynamic>{'Content-Type': 'application/json'})
  Future<List<GroupResponse>> fetchAll();

  @GET('/{id}')
  @Headers(<String, dynamic>{'Content-Type': 'application/json'})
  Future<GroupResponse> fetchById(@Path('id') String id);

  @POST('/')
  @Headers(<String, dynamic>{'Content-Type': 'application/json'})
  Future<String> create(@Body() CreateGroupRequest request);

  @PUT('/{id}')
  @Headers(<String, dynamic>{'Content-Type': 'application/json'})
  Future<void> update(@Path('id') String id, @Body() UpdateGroupRequest request);

  @DELETE('/{id}')
  @Headers(<String, dynamic>{'Content-Type': 'application/json'})
  Future<void> delete(@Path('id') String id);
}
