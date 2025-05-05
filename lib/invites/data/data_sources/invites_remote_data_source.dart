import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/retrofit.dart';
import 'package:task_master/invites/data/models/create_invite_request.dart';
import 'package:task_master/invites/data/models/invite_response.dart';

part 'invites_remote_data_source.g.dart';

@RestApi(baseUrl: '/invites')
abstract class InvitesRemoteDataSource {
  factory InvitesRemoteDataSource(Dio dio, {String? baseUrl}) = _InvitesRemoteDataSource;

  @GET('/')
  @Headers(<String, dynamic>{'Content-Type': 'application/json'})
  Future<List<InviteResponse>> fetchAll(@Query('status') String status);

  @POST('/')
  @Headers(<String, dynamic>{'Content-Type': 'application/json'})
  Future<void> create(@Body() CreateInviteRequest request);

  @PUT('/{inviteId}/accept/{groupId}')
  @Headers(<String, dynamic>{'Content-Type': 'application/json'})
  Future<void> accept(@Path('inviteId') String inviteId, @Path('groupId') String groupId);

  @PUT('/{inviteId}/reject/{groupId}')
  @Headers(<String, dynamic>{'Content-Type': 'application/json'})
  Future<void> reject(@Path('inviteId') String inviteId, @Path('groupId') String groupId);
}
