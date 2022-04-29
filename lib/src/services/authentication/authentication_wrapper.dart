import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:upwind/src/config/routes.dart';
import 'package:upwind/src/repositories/tokens_repository/tokens_repository.dart';
import 'package:upwind/src/services/authentication/bloc/authentication_bloc.dart';

BlocListener authenticationWrapper({required AppRouter router}) {
  return BlocListener<AuthenticationBloc, AuthenticationState>(
    listener: (context, state) {
      switch (state.status) {
        case AuthenticationStatus.authenticated:
          router.replaceNamed(Routes.main.generatePath());
          break;
        case AuthenticationStatus.unauthenticated:
          router.replaceNamed(Routes.login.generatePath());
          break;
        default:
          break;
      }
    },
  );
}
