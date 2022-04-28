import 'dart:async';

import 'package:dio/dio.dart';
import 'package:upwind/src/config/api/exceptions.dart';
import 'package:upwind/src/repositories/authentication_repository/authentication_repository.dart';
import 'package:upwind/src/repositories/tokens_repository/tokens_repository.dart';
import 'package:upwind/src/services/hive.dart';

class TokensRepository
    with IHiveRepository<Tokens>
    implements ITokensRepository {
  final RefreshTokens refreshTokens;

  TokensRepository({required this.refreshTokens});

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
  String get boxKey => 'tokensBox';

  @override
  String get tokensKey => 'tokensKey';

  @override
  Future<void> clearTokens() async {
    (await box).clear();
    controller?.add(AuthenticationStatus.unauthenticated);
  }

  @override
  Future<Tokens?> getTokens() async => (await box).get(tokensKey);

  @override
  Future<void> saveTokens(Tokens tokens) async {
    await (await box).put(tokensKey, tokens);
    controller?.add(AuthenticationStatus.authenticated);
  }

  @override
  Future<Tokens?> performRefreshTokens(
    Dio httpClient, {
    required String refreshToken,
  }) async {
    final response = await refreshTokens(
      httpClient,
      refreshToken: refreshToken,
    );
    try {
      final tokens = Tokens.fromJson(response.data);
      await saveTokens(tokens);
      return tokens;
    } catch (e) {
      throw ApiResponseParseException(e.toString());
    }
  }

  @override
  void dispose() => controller!.close();
}
