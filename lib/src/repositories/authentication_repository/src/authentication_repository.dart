import 'dart:async';

import 'package:dio/dio.dart';
import 'package:upwind/src/config/api/exceptions.dart';
import 'package:upwind/src/repositories/authentication_repository/authentication_repository.dart';
import 'package:upwind/src/services/hive.dart';

class AuthenticationRepository
    with IHiveRepository<Tokens>
    implements IAuthenticationRepository {
  final Dio httpClient;
  final LogIn logIn;
  final RefreshTokens refreshTokens;

  AuthenticationRepository(
    this.httpClient, {
    required this.logIn,
    required this.refreshTokens,
  });

  @override
  String get boxKey => 'tokensBox';

  @override
  String get tokensKey => 'tokensKey';

  @override
  StreamController<AuthenticationStatus>? controller =
      StreamController<AuthenticationStatus>.broadcast();

  @override
  Stream<AuthenticationStatus> get status async* {
    final tokens = await getTokens();

    if (tokens != null) {
      yield AuthenticationStatus.authenticated;
    } else {
      yield AuthenticationStatus.unauthenticated;
    }

    yield* controller!.stream;
  }

  @override
  Future<void> clearTokens() async {
    (await box).clear();
  }

  @override
  Future<Tokens?> getTokens() async => (await box).get(tokensKey);

  @override
  Future<void> saveTokens(Tokens tokens) async {
    (await box).put(tokensKey, tokens);
    controller?.add(AuthenticationStatus.authenticated);
  }

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
    await clearTokens();
    controller?.add(AuthenticationStatus.unauthenticated);
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

  void dispose() => controller!.close();
}
