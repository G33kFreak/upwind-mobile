import 'package:bloc_test/bloc_test.dart';
import 'package:dio/dio.dart';
import 'package:http_status_code/http_status_code.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:upwind/src/modules/login_view/bloc/login_view_bloc.dart';
import 'package:upwind/src/modules/login_view/utils/exceptions.dart';
import 'package:upwind/src/repositories/authentication_repository/authentication_repository.dart';
import 'package:upwind/src/repositories/tokens_repository/tokens_repository.dart';
import 'package:upwind/src/utils/dio_error_log_extract.dart';
import 'package:upwind/src/utils/form_status.dart';

import 'bloc_test.mocks.dart';

@GenerateMocks([
  IAuthenticationRepository,
  ITokensRepository,
  Tokens,
])
void main() {
  final authenticationRepository = MockIAuthenticationRepository();
  final tokensReposiotry = MockITokensRepository();

  blocTest<LoginViewBloc, LoginViewState>(
    'LoginView password and email changing ok',
    build: () => LoginViewBloc(
      authenticationRepository: authenticationRepository,
      tokensRepository: tokensReposiotry,
    ),
    act: (bloc) => bloc
      ..add(const EmailChanged('E'))
      ..add(const EmailChanged('Em'))
      ..add(const PasswordChanged('P'))
      ..add(const PasswordChanged('Pa')),
    expect: () => const <LoginViewState>[
      LoginViewState(email: 'E'),
      LoginViewState(email: 'Em'),
      LoginViewState(email: 'Em', password: 'P'),
      LoginViewState(email: 'Em', password: 'Pa'),
    ],
  );

  blocTest<LoginViewBloc, LoginViewState>(
    'LoginView logging in ok',
    setUp: () {
      when(authenticationRepository.performLogIn(
        email: anyNamed('email'),
        password: anyNamed('password'),
      )).thenAnswer((_) => Future.value(MockTokens()));
      when(tokensReposiotry.saveTokens(any)).thenAnswer((_) => Future.value());
    },
    build: () => LoginViewBloc(
      authenticationRepository: authenticationRepository,
      tokensRepository: tokensReposiotry,
    ),
    act: (bloc) => bloc
      ..add(const EmailChanged('Email'))
      ..add(const PasswordChanged('Password'))
      ..add(const FormSubmitted()),
    expect: () => const <LoginViewState>[
      LoginViewState(email: 'Email'),
      LoginViewState(email: 'Email', password: 'Password'),
      LoginViewState(
        email: 'Email',
        password: 'Password',
        formStatus: LoadingFormStatus(),
      ),
    ],
  );

  final dioErrorMethodFailure = DioError(
      requestOptions: RequestOptions(path: 'Test'),
      response: Response(
        requestOptions: RequestOptions(path: 'Test'),
        statusCode: StatusCode.METHOD_FAILURE,
      ));
  blocTest<LoginViewBloc, LoginViewState>(
    'LoginView serverError when DioError is not with 401 status code',
    setUp: () {
      when(authenticationRepository.performLogIn(
        email: anyNamed('email'),
        password: anyNamed('password'),
      )).thenThrow(dioErrorMethodFailure);
    },
    build: () => LoginViewBloc(
      authenticationRepository: authenticationRepository,
      tokensRepository: tokensReposiotry,
    ),
    act: (bloc) => bloc
      ..add(const EmailChanged('Email'))
      ..add(const PasswordChanged('Password'))
      ..add(const FormSubmitted()),
    errors: () => [
      LoginBlocException(
        '${LoginBlocError.serverError.text} ${convertDioErrorToLogMessage(dioErrorMethodFailure)}',
      ),
    ],
    expect: () => const <LoginViewState>[
      LoginViewState(email: 'Email'),
      LoginViewState(email: 'Email', password: 'Password'),
      LoginViewState(
        email: 'Email',
        password: 'Password',
        formStatus: LoadingFormStatus(),
      ),
      LoginViewState(
        email: 'Email',
        password: 'Password',
        formStatus: ErrorFormStatus(),
        error: LoginBlocError.serverError,
      )
    ],
  );

  final dioErrorUnauthorized = DioError(
      requestOptions: RequestOptions(path: 'Test'),
      response: Response(
        requestOptions: RequestOptions(path: 'Test'),
        statusCode: StatusCode.UNAUTHORIZED,
      ));
  blocTest<LoginViewBloc, LoginViewState>(
    'LoginView invalidLoginData error when Dio error with 401 status code',
    setUp: () {
      when(authenticationRepository.performLogIn(
        email: anyNamed('email'),
        password: anyNamed('password'),
      )).thenThrow(dioErrorUnauthorized);
    },
    build: () => LoginViewBloc(
      authenticationRepository: authenticationRepository,
      tokensRepository: tokensReposiotry,
    ),
    act: (bloc) => bloc
      ..add(const EmailChanged('Email'))
      ..add(const PasswordChanged('Password'))
      ..add(const FormSubmitted()),
    errors: () => [
      LoginBlocException(
        '${LoginBlocError.invalidLoginData.text} ${convertDioErrorToLogMessage(dioErrorUnauthorized)}',
      ),
    ],
    expect: () => const <LoginViewState>[
      LoginViewState(email: 'Email'),
      LoginViewState(email: 'Email', password: 'Password'),
      LoginViewState(
        email: 'Email',
        password: 'Password',
        formStatus: LoadingFormStatus(),
      ),
      LoginViewState(
        email: 'Email',
        password: 'Password',
        formStatus: ErrorFormStatus(),
        error: LoginBlocError.invalidLoginData,
      )
    ],
  );

  blocTest<LoginViewBloc, LoginViewState>(
    'LoginView form status resets after getting error and changing input data',
    setUp: () {
      when(authenticationRepository.performLogIn(
        email: anyNamed('email'),
        password: anyNamed('password'),
      )).thenThrow(dioErrorUnauthorized);
    },
    build: () => LoginViewBloc(
      authenticationRepository: authenticationRepository,
      tokensRepository: tokensReposiotry,
    ),
    act: (bloc) => bloc
      ..add(const EmailChanged('Email'))
      ..add(const PasswordChanged('Password'))
      ..add(const FormSubmitted())
      ..add(const EmailChanged('Email2')),
    errors: () => [
      LoginBlocException(
        '${LoginBlocError.invalidLoginData.text} ${convertDioErrorToLogMessage(dioErrorUnauthorized)}',
      ),
    ],
    expect: () => const <LoginViewState>[
      LoginViewState(email: 'Email'),
      LoginViewState(email: 'Email', password: 'Password'),
      LoginViewState(
        email: 'Email',
        password: 'Password',
        formStatus: LoadingFormStatus(),
      ),
      LoginViewState(
        email: 'Email',
        password: 'Password',
        formStatus: ErrorFormStatus(),
        error: LoginBlocError.invalidLoginData,
      ),
      LoginViewState(
        email: 'Email2',
        password: 'Password',
        formStatus: InitFormStatus(),
        error: LoginBlocError.invalidLoginData,
      )
    ],
  );
}
