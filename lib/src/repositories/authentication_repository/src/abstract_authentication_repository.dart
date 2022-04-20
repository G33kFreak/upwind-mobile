import 'dart:async';

import 'package:upwind/src/repositories/tokens_repository/tokens_repository.dart';

abstract class IAuthenticationRepository {
  Future<Tokens> performLogIn({
    required String email,
    required String password,
  });

  Future<void> logOut();
}
