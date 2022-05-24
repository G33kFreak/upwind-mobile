import 'dart:async';

import 'package:autoequal/autoequal.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:http_status_code/http_status_code.dart';
import 'package:upwind/src/modules/login_view/utils/exceptions.dart';
import 'package:upwind/src/repositories/authentication_repository/authentication_repository.dart';
import 'package:upwind/src/repositories/tokens_repository/tokens_repository.dart';
import 'package:upwind/src/utils/dio_error_log_extract.dart';
import 'package:upwind/src/utils/form_status.dart';

part 'login_view_event.dart';
part 'login_view_state.dart';
part 'login_view_bloc.g.dart';

class LoginViewBloc extends Bloc<LoginViewEvent, LoginViewState> {
  final IAuthenticationRepository authenticationRepository;
  final ITokensRepository tokensRepository;

  LoginViewBloc({
    required this.authenticationRepository,
    required this.tokensRepository,
  }) : super(const LoginViewState()) {
    on<EmailChanged>(_onEmailChanged);
    on<PasswordChanged>(_onPasswordChanged);
    on<FormSubmitted>(_onSubmitted);
  }

  void _onEmailChanged(EmailChanged event, Emitter<LoginViewState> emit) {
    emit(state.copyWith(
      email: event.email,
      formStatus: const InitFormStatus(),
      error: LoginBlocError.none,
    ));
  }

  void _onPasswordChanged(
    PasswordChanged event,
    Emitter<LoginViewState> emit,
  ) {
    emit(state.copyWith(
      password: event.password,
      formStatus: const InitFormStatus(),
      error: LoginBlocError.none,
    ));
  }

  FutureOr<void> _onSubmitted(
    FormSubmitted event,
    Emitter<LoginViewState> emit,
  ) async {
    if (state.email != null && state.password != null) {
      emit(state.copyWith(formStatus: const LoadingFormStatus()));

      try {
        final tokens = await authenticationRepository.performLogIn(
          email: state.email!,
          password: state.password!,
        );

        await tokensRepository.saveTokens(tokens);
      } on DioError catch (e) {
        final error = e.response?.statusCode == StatusCode.UNAUTHORIZED
            ? LoginBlocError.invalidLoginData
            : LoginBlocError.serverError;

        throw _emitErrorState(error, emit, convertDioErrorToLogMessage(e));
      } catch (e) {
        throw _emitErrorState(LoginBlocError.serverError, emit, e);
      }
    }
  }

  LoginBlocException _emitErrorState(
    LoginBlocError error,
    Emitter<LoginViewState> emit, [
    dynamic extra,
  ]) {
    emit(state.copyWith(
      formStatus: const ErrorFormStatus(),
      error: error,
    ));

    final errorText = extra == null ? error.text : '${error.text} $extra';

    return LoginBlocException(errorText);
  }
}
