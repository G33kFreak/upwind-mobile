import 'dart:async';

import 'package:upwind/src/repositories/tokens_repository/tokens_repository.dart';
import 'package:upwind/src/services/hive.dart';

class TokensRepository
    with IHiveRepository<Tokens>
    implements ITokensRepository {
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
  }

  @override
  Future<Tokens?> getTokens() async => (await box).get(tokensKey);

  @override
  Future<void> saveTokens(Tokens tokens) async {
    (await box).put(tokensKey, tokens);
    controller?.add(AuthenticationStatus.authenticated);
  }

  void dispose() => controller!.close();
}
