import 'dart:async';

import 'package:autoequal/autoequal.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:upwind/src/repositories/tokens_repository/tokens_repository.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';
part 'authentication_bloc.g.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final ITokensRepository tokensRepository;
  final Dio httpClient;

  late StreamSubscription<AuthenticationStatus>
      _authenticationStatusSubsctiption;

  AuthenticationBloc({
    required this.tokensRepository,
    required this.httpClient,
  }) : super(const AuthenticationState.unknown()) {
    _authenticationStatusSubsctiption = tokensRepository.status.listen(
      (status) => add(
        AuthenticationStatusChanged(status),
      ),
    );

    on<AuthenticationStatusChanged>(_onStatusChanged);
    on<Logout>(_onLogout);
  }

  Future<void> _onStatusChanged(
    AuthenticationStatusChanged event,
    Emitter<AuthenticationState> emit,
  ) async {
    switch (event.status) {
      case AuthenticationStatus.unauthenticated:
        return emit(const AuthenticationState.unauthenticated());
      case AuthenticationStatus.authenticated:
        {
          final tokens = await tokensRepository.getTokens();
          if (tokens != null) {
            return emit(const AuthenticationState.authenticated());
          } else {
            return emit(const AuthenticationState.unauthenticated());
          }
        }
      default:
        return emit(const AuthenticationState.unknown());
    }
  }

  Future<void> _onLogout(
    Logout event,
    Emitter<AuthenticationState> emit,
  ) async {
    await tokensRepository.clearTokens();
  }

  @override
  Future<void> close() {
    _authenticationStatusSubsctiption.cancel();
    tokensRepository.dispose();
    return super.close();
  }
}
