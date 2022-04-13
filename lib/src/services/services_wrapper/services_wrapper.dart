import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:upwind/src/config/routes.dart';
import 'package:upwind/src/repositories/tokens_repository/tokens_repository.dart';
import 'package:upwind/src/services/authentication/bloc/authentication_bloc.dart';

class ServicesWrapper extends StatelessWidget {
  final AppRouter router;
  final Widget? child;
  const ServicesWrapper({
    Key? key,
    required this.router,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        switch (state.status) {
          case AuthenticationStatus.authenticated:
            router.replaceNamed(Routes.main.generatePath());
            break;
          case AuthenticationStatus.unauthenticated:
            router.replaceNamed(Routes.welcome.generatePath());
            break;
          default:
            break;
        }
      },
      child: child,
    );
  }
}
