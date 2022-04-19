import 'dart:async';

import 'package:autoequal/autoequal.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:upwind/src/modules/login_view/utils/exceptions.dart';
import 'package:upwind/src/repositories/authentication_repository/authentication_repository.dart';
import 'package:upwind/src/utils/form_status.dart';

part 'login_view_event.dart';
part 'login_view_state.dart';
part 'login_view_bloc.g.dart';

class LoginViewBloc extends Bloc<LoginViewEvent, LoginViewState> {
  final IAuthenticationRepository authenticationRepository;

  LoginViewBloc({
    required this.authenticationRepository,
  }) : super(const LoginViewState()) {
    on<EmailChanged>(_onEmailChanged);
    on<PasswordChanged>(_onPasswordChanged);
    on<FormSubmitted>(_onSabmitted);
  }

  void _onEmailChanged(EmailChanged event, Emitter<LoginViewState> emit) {
    emit(state.copyWith(email: event.email));
  }

  void _onPasswordChanged(
    PasswordChanged event,
    Emitter<LoginViewState> emit,
  ) {
    emit(state.copyWith(password: event.password));
  }

  FutureOr<void> _onSabmitted(
    FormSubmitted event,
    Emitter<LoginViewState> emit,
  ) async {
    if (state.email != null && state.password != null) {
      emit(state.copyWith(formStatus: const LoadingFormStatus()));

      try {
        authenticationRepository.performLogIn(
          email: state.email!,
          password: state.password!,
        );
      } catch (e) {}
    }
  }

  LoginBlocException _emitErrorState(
    LoginBlocError error,
    Emitter<LoginViewState> emit, [
    dynamic extra,
  ]) {
    emit(state.copyWith(
      formStatus: ErrorFormStatus(),
      error: error,
    ));

    final errorText = extra == null ? error.text : '${error.text} $extra';

    return LoginBlocException(errorText);
  }
}
