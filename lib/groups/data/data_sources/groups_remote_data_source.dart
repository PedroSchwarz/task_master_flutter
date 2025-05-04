import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/retrofit.dart';
import 'package:task_master/groups/data/models/create_group_request.dart';
import 'package:task_master/groups/data/models/group_response.dart';

part 'groups_remote_data_source.g.dart';

@RestApi(baseUrl: '/groups')
abstract class GroupsRemoteDataSource {
  factory GroupsRemoteDataSource(Dio dio, {String? baseUrl}) =
      _GroupsRemoteDataSource;

  @GET('/')
  @Headers(<String, dynamic>{'Content-Type': 'application/json'})
  Future<List<GroupResponse>> fetchAll();

  @POST('/')
  @Headers(<String, dynamic>{'Content-Type': 'application/json'})
  Future<GroupResponse> create(@Body() CreateGroupRequest request);
}
