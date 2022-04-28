import 'package:bloc_test/bloc_test.dart';
import 'package:dio/dio.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:upwind/src/repositories/tokens_repository/tokens_repository.dart';
import 'package:upwind/src/services/authentication/bloc/authentication_bloc.dart';

import 'authentication_test.mocks.dart';

@GenerateMocks([ITokensRepository, Dio, Tokens, DioError])
void main() {
  final tokensRepository = MockITokensRepository();
  final httpClient = MockDio();
  final tokens = MockTokens();
  blocTest<AuthenticationBloc, AuthenticationState>(
    'AuthenticationService status is authenticated when tokens != null',
    setUp: () {
      when(tokensRepository.status).thenAnswer(
        (_) => Stream.fromIterable([
          AuthenticationStatus.unknown,
          AuthenticationStatus.authenticated,
        ]),
      );
      when(tokensRepository.getTokens())
          .thenAnswer((_) => Future.value(tokens));
      when(tokensRepository.performRefreshTokens(
        httpClient,
        refreshToken: anyNamed('refreshToken'),
      )).thenAnswer((_) => Future.value());
      when(tokens.refreshToken).thenAnswer((_) => '');
    },
    build: () => AuthenticationBloc(
      tokensRepository: tokensRepository,
      httpClient: httpClient,
    ),
    expect: () => const <AuthenticationState>[
      AuthenticationState.unknown(),
      AuthenticationState.authenticated(),
    ],
  );

  blocTest<AuthenticationBloc, AuthenticationState>(
    'AuthenticationService status is unauthenticated when tokens == null',
    setUp: () {
      when(tokensRepository.status).thenAnswer(
        (_) => Stream.fromIterable([
          AuthenticationStatus.unknown,
          AuthenticationStatus.authenticated,
        ]),
      );
      when(tokensRepository.getTokens()).thenAnswer((_) => Future.value(null));
    },
    build: () => AuthenticationBloc(
      tokensRepository: tokensRepository,
      httpClient: httpClient,
    ),
    expect: () => const <AuthenticationState>[
      AuthenticationState.unknown(),
      AuthenticationState.unauthenticated(),
    ],
  );
}
