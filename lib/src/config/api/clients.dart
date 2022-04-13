import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:upwind/src/config/api/m_interceptor.dart';
import 'package:upwind/src/environment/variables.dart';
import 'package:upwind/src/repositories/tokens_repository/src/abstract_tokens_repository.dart';

class ApiProvider {
  final ITokensRepository _tokensRepository;

  ApiProvider({required ITokensRepository tokensRepository})
      : _tokensRepository = tokensRepository;

  Dio _createDioClient() {
    final dio = Dio(
      BaseOptions(
        baseUrl: EnvironmentVariables.baseUrl,
        headers: {
          'content-type': 'application/json',
          'accept': 'application/json',
        },
      ),
    );

    (dio.transformer as DefaultTransformer).jsonDecodeCallback = parseJson;

    return dio;
  }

  Dio get httpClient => _createDioClient();

  Dio get authenticatedHttpClient {
    final dio = _createDioClient();
    dio.interceptors.add(MInterceptor(_tokensRepository));

    return dio;
  }
}

_parseAndDecode(String response) {
  return jsonDecode(response);
}

parseJson(String text) {
  return compute(_parseAndDecode, text);
}
