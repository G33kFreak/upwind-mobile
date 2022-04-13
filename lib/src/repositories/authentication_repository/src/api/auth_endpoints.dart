import 'package:dio/dio.dart';

typedef LogIn = Future<Response> Function(
  Dio, {
  required String email,
  required String password,
});

final LogIn logIn = (
  Dio httpClient, {
  required String email,
  required String password,
}) =>
    httpClient.post(
      '/token/',
      data: {
        'email': email,
        'password': password,
      },
    );

typedef RefreshTokens = Future<Response> Function(
  Dio, {
  required String refreshToken,
});

final RefreshTokens refreshTokens = (
  Dio httpClient, {
  required String refreshToken,
}) =>
    httpClient.post('/token/refresh/', data: {
      'refresh_token': refreshToken,
    });
