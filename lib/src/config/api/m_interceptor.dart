import 'dart:io';

import 'package:dio/dio.dart';
import 'package:http_status_code/http_status_code.dart';
import 'package:upwind/src/repositories/authentication_repository/authentication_repository.dart';

class MInterceptor implements InterceptorsWrapper {
  final IAuthenticationRepository _authenticationRepository;

  MInterceptor(IAuthenticationRepository authenticationRepository)
      : _authenticationRepository = authenticationRepository;

  final unauthCodes = [StatusCode.UNAUTHORIZED, StatusCode.FORBIDDEN];

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) async {
    final statusCode = err.response?.statusCode;

    if (unauthCodes.contains(statusCode)) {
      await _authenticationRepository.clearTokens();
      return handler.reject(err);
    }

    return handler.next(err);
  }

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = await _authenticationRepository.getTokens();

    if (token != null) {
      options.headers[HttpHeaders.authorizationHeader] =
          'Bearer ${token.accessToken}';
    }

    return handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    handler.next(response);
  }
}
