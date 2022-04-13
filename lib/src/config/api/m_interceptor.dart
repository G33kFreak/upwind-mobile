import 'dart:io';

import 'package:dio/dio.dart';
import 'package:http_status_code/http_status_code.dart';
import 'package:upwind/src/repositories/tokens_repository/src/abstract_tokens_repository.dart';

class MInterceptor implements InterceptorsWrapper {
  final ITokensRepository _tokensRepository;

  MInterceptor(ITokensRepository _tokensRepository)
      : _tokensRepository = _tokensRepository;

  final unauthCodes = [StatusCode.UNAUTHORIZED, StatusCode.FORBIDDEN];

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) async {
    final statusCode = err.response?.statusCode;

    if (unauthCodes.contains(statusCode)) {
      try {
        final cloneRequest = await _refreshProcess(err);
        return handler.resolve(cloneRequest);
      } catch (_) {
        await _tokensRepository.clearTokens();
        return handler.next(err);
      }
    }

    return handler.next(err);
  }

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = await _tokensRepository.getTokens();

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

  Future<Response<dynamic>> _refreshProcess(DioError err) async {
    final refreshToken = (await _tokensRepository.getTokens())!.refreshToken;

    final newTokens = await _tokensRepository.performRefreshTokens(
      Dio(),
      refreshToken: refreshToken,
    );

    err.requestOptions.headers[HttpHeaders.authorizationHeader] =
        'Bearer ${newTokens?.accessToken}';

    final newOptions = Options(
      method: err.requestOptions.method,
      headers: err.requestOptions.headers,
    );
    final cloneRequest = await Dio().request(
      err.requestOptions.path,
      data: err.requestOptions.data,
      queryParameters: err.requestOptions.queryParameters,
      cancelToken: err.requestOptions.cancelToken,
      onSendProgress: err.requestOptions.onSendProgress,
      onReceiveProgress: err.requestOptions.onReceiveProgress,
      options: newOptions,
    );

    return cloneRequest;
  }
}
