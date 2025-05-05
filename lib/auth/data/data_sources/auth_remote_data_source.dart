import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/retrofit.dart';
import 'package:task_master/auth/data/models/login_request.dart';
import 'package:task_master/auth/data/models/login_response.dart';
import 'package:task_master/auth/data/models/register_request.dart';
import 'package:task_master/auth/data/models/register_response.dart';

part 'auth_remote_data_source.g.dart';

@RestApi(baseUrl: '/auth')
abstract class AuthRemoteDataSource {
  factory AuthRemoteDataSource(Dio dio, {String? baseUrl}) = _AuthRemoteDataSource;

  @POST('/login')
  @Headers(<String, dynamic>{'Content-Type': 'application/json'})
  Future<LoginResponse> login(@Body() LoginRequest request);

  @POST('/register')
  @Headers(<String, dynamic>{'Content-Type': 'application/json'})
  Future<RegisterResponse> register(@Body() RegisterRequest request);
}
