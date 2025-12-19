import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:task_master/auth/auth.dart';

class AuthInterceptor extends Interceptor {
  const AuthInterceptor({
    required this.authRepository,
    required this.credentialsRepository,
    required this.dio,
  });

  @visibleForTesting
  final AuthRepository authRepository;

  @visibleForTesting
  final CredentialsRepository credentialsRepository;

  @visibleForTesting
  final Dio dio;

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final credentials = await credentialsRepository.getCredentials();

    if (credentials != null) {
      options.headers['Authorization'] = 'Bearer ${credentials.accessToken}';
    }

    return handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      try {
        // Refresh the credentials
        final refreshedCredentials = await authRepository.refreshToken();
        await credentialsRepository.updateCredentials(refreshedCredentials);

        // Retry the original request
        final clonedRequest = err.requestOptions;
        clonedRequest.headers['Authorization'] =
            'Bearer ${refreshedCredentials.accessToken}';
        final response = await dio.fetch(clonedRequest);
        return handler.resolve(response);
      } catch (e) {
        await authRepository.signOut();
      }
    }

    return handler.next(err);
  }
}
