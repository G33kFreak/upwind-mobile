import 'dart:async';

import 'package:dio/dio.dart';
import 'package:upwind/src/repositories/tokens_repository/tokens_repository.dart';

enum AuthenticationStatus {
  unknown,
  authenticated,
  unauthenticated,
}

abstract class ITokensRepository {
  String get tokensKey;

  Future<Tokens?> getTokens();

  Future<void> saveTokens(Tokens tokens);

  Future<void> clearTokens();

  Stream<AuthenticationStatus> get status;

  StreamController<AuthenticationStatus>? controller;

  Future<Tokens?> performRefreshTokens(
    Dio httpClient, {
    required String refreshToken,
  });

  void dispose();
}
