import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:upwind/src/config/api/m_interceptor.dart';
import 'package:upwind/src/environment/variables.dart';
import 'package:upwind/src/repositories/authentication_repository/authentication_repository.dart';

class ApiProvider {
  final IAuthenticationRepository _authenticationRepository;

  ApiProvider(IAuthenticationRepository authenticationRepository)
      : _authenticationRepository = authenticationRepository;

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
    dio.interceptors.add(MInterceptor(_authenticationRepository));

    return dio;
  }
}

_parseAndDecode(String response) {
  return jsonDecode(response);
}

parseJson(String text) {
  return compute(_parseAndDecode, text);
}
