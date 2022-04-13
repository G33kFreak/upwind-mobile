import 'dart:async';

import 'package:upwind/src/repositories/authentication_repository/src/models/tokens.dart';

enum AuthenticationStatus {
  unknown,
  authenticated,
  unauthenticated,
}

abstract class IAuthenticationRepository {
  String get tokensKey;

  StreamController<AuthenticationStatus>? controller;

  Stream<AuthenticationStatus> get status;

  Future<Tokens?> getTokens();

  Future<void> saveTokens(Tokens tokens);

  Future<void> clearTokens();

  Future<void> performLogIn({
    required String email,
    required String password,
  });

  Future<void> performRefreshTokens({required String refreshToken});

  Future<void> logOut();
}
