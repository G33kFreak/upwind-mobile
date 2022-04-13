import 'dart:async';

import 'package:dio/dio.dart';
import 'package:upwind/src/config/api/exceptions.dart';
import 'package:upwind/src/repositories/authentication_repository/authentication_repository.dart';
import 'package:upwind/src/repositories/tokens_repository/tokens_repository.dart';

class AuthenticationRepository implements IAuthenticationRepository {
  final ITokensRepository tokensRepository;
  final Dio httpClient;
  final LogIn logIn;
  final RefreshTokens refreshTokens;

  AuthenticationRepository(
    this.httpClient, {
    required this.tokensRepository,
    required this.logIn,
    required this.refreshTokens,
  });

  @override
  Future<void> performLogIn({
    required String email,
    required String password,
  }) async {
    final response = await logIn(httpClient, email: email, password: password);
    try {
      Tokens.fromJson(response.data);
    } catch (e) {
      throw ApiResponseParseException(e.toString());
    }
  }

  @override
  Future<void> logOut() async {
    await tokensRepository.clearTokens();
    tokensRepository.controller?.add(AuthenticationStatus.unauthenticated);
  }

  @override
  Future<void> performRefreshTokens({required String refreshToken}) async {
    final response = await refreshTokens(
      httpClient,
      refreshToken: refreshToken,
    );
    try {
      Tokens.fromJson(response.data);
    } catch (e) {
      throw ApiResponseParseException(e.toString());
    }
  }
}
