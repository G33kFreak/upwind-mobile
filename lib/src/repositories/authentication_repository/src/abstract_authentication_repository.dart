import 'dart:async';

abstract class IAuthenticationRepository {
  Future<void> performLogIn({
    required String email,
    required String password,
  });

  Future<void> logOut();
}
