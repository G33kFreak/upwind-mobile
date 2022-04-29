import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:upwind/src/config/api/clients.dart';
import 'package:upwind/src/repositories/authentication_repository/authentication_repository.dart';
import 'package:upwind/src/repositories/connection_repository/connection_repository.dart';
import 'package:upwind/src/repositories/tokens_repository/src/abstract_tokens_repository.dart';
import 'package:upwind/src/repositories/tokens_repository/src/tokens_repository.dart';
import 'package:upwind/src/services/authentication/bloc/authentication_bloc.dart';
import 'package:upwind/src/services/connection/bloc/connection_bloc.dart';

class ServicesProvider extends StatelessWidget {
  final Widget child;

  const ServicesProvider({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<ITokensRepository>(
          create: (context) => TokensRepository(refreshTokens: refreshTokens),
        ),
        RepositoryProvider<ApiProvider>(
          create: (context) => ApiProvider(
            tokensRepository: context.read<ITokensRepository>(),
          ),
        ),
        RepositoryProvider<IAuthenticationRepository>(
          create: (context) => AuthenticationRepository(
            context.read<ApiProvider>().httpClient,
            tokensRepository: context.read<ITokensRepository>(),
            logIn: logIn,
            refreshTokens: refreshTokens,
          ),
        ),
        RepositoryProvider<ConnectionRepository>(
          create: (context) => ConnectionRepository(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AuthenticationBloc>(
            create: (context) => AuthenticationBloc(
              tokensRepository: context.read<ITokensRepository>(),
              httpClient: context.read<ApiProvider>().httpClient,
            ),
          ),
          BlocProvider<ConnectionBloc>(
            create: (context) => ConnectionBloc(
                connectionRepository: context.read<ConnectionRepository>()),
          ),
        ],
        child: child,
      ),
    );
  }
}
