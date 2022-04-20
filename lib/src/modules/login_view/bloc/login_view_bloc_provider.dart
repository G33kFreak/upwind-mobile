import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:upwind/src/modules/login_view/bloc/login_view_bloc.dart';
import 'package:upwind/src/repositories/authentication_repository/authentication_repository.dart';
import 'package:upwind/src/repositories/tokens_repository/tokens_repository.dart';

class LogiViewBlocProvider extends StatelessWidget {
  final Widget? child;

  const LogiViewBlocProvider({Key? key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return KeyboardVisibilityProvider(
      child: BlocProvider<LoginViewBloc>(
        create: (context) => LoginViewBloc(
          authenticationRepository: context.read<IAuthenticationRepository>(),
          tokensRepository: context.read<ITokensRepository>(),
        ),
        child: child,
      ),
    );
  }
}
