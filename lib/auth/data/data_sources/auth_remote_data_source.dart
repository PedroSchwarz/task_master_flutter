import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/retrofit.dart';
import 'package:task_master/auth/data/models/auth_response.dart';
import 'package:task_master/auth/data/models/login_request.dart';
import 'package:task_master/auth/data/models/refresh_token_request.dart';
import 'package:task_master/auth/data/models/register_request.dart';

part 'auth_remote_data_source.g.dart';

@RestApi(baseUrl: '/auth')
abstract class AuthRemoteDataSource {
  factory AuthRemoteDataSource(
    Dio dio, {
    String? baseUrl,
    ParseErrorLogger? errorLogger,
  }) = _AuthRemoteDataSource;

  @POST('/login')
  @Headers(<String, dynamic>{'Content-Type': 'application/json'})
  Future<AuthResponse> login(@Body() LoginRequest request);

  @POST('/register')
  @Headers(<String, dynamic>{'Content-Type': 'application/json'})
  Future<AuthResponse> register(@Body() RegisterRequest request);

  @POST('/refresh-token')
  @Headers(<String, dynamic>{'Content-Type': 'application/json'})
  Future<AuthResponse> refreshToken(@Body() RefreshTokenRequest request);

  @POST('/sign-out')
  @Headers(<String, dynamic>{'Content-Type': 'application/json'})
  Future<void> signOut(@Body() RefreshTokenRequest request);
}
