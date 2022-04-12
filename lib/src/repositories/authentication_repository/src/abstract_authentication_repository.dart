import 'package:dio/dio.dart';
import 'package:upwind/src/repositories/authentication_repository/src/models/tokens.dart';

enum AuthenticationStatus {
  unknown,
  authenticated,
  unauthenticated,
}

abstract class IAuthenticationRepository {
  Stream<AuthenticationStatus> get status;

  Tokens? getTokens();

  Future<void> saveTokens(Tokens tokens);

  Future<void> clearTokens();

  Future<void> logIn(
    Dio client, {
    required String email,
    required String password,
  });

  Future<void> refreshTokens(Dio client);

  Future<void> logOut();
}
