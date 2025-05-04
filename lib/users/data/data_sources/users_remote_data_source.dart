import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/retrofit.dart';
import 'package:task_master/users/data/models/user_response.dart';

part 'users_remote_data_source.g.dart';

@RestApi(baseUrl: '/users')
abstract class UsersRemoteDataSource {
  factory UsersRemoteDataSource(Dio dio, {String? baseUrl}) =
      _UsersRemoteDataSource;

  @GET('/')
  @Headers(<String, dynamic>{'Content-Type': 'application/json'})
  Future<List<UserResponse>> fetchAll();
}
