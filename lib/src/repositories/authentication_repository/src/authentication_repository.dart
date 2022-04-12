import 'package:dio/src/dio.dart';
import 'package:upwind/src/repositories/authentication_repository/authentication_repository.dart';
import 'package:upwind/src/services/hive.dart';

class AuthenticationRepository
    with IHiveRepository<Tokens>
    implements IAuthenticationRepository {
  @override
  // TODO: implement boxKey
  String get boxKey => throw UnimplementedError();

  @override
  Future<void> clearTokens() {
    // TODO: implement clearTokens
    throw UnimplementedError();
  }

  @override
  Tokens? getTokens() {
    // TODO: implement getTokens
    throw UnimplementedError();
  }

  @override
  Future<void> logIn(Dio client,
      {required String email, required String password}) {
    // TODO: implement logIn
    throw UnimplementedError();
  }

  @override
  Future<void> logOut() {
    // TODO: implement logOut
    throw UnimplementedError();
  }

  @override
  Future<void> refreshTokens(Dio client) {
    // TODO: implement refreshTokens
    throw UnimplementedError();
  }

  @override
  Future<void> saveTokens(Tokens tokens) {
    // TODO: implement saveTokens
    throw UnimplementedError();
  }

  @override
  // TODO: implement status
  Stream<AuthenticationStatus> get status => throw UnimplementedError();
}
