part of 'login_view_bloc.dart';

@autoequalMixin
class LoginViewState extends Equatable with _$LoginViewStateAutoequalMixin {
  final String? email;
  final String? password;
  final FormStatus formStatus;
  final LoginBlocError error;

  const LoginViewState({
    this.email,
    this.password,
    this.formStatus = const InitFormStatus(),
    this.error = LoginBlocError.none,
  });

  LoginViewState copyWith({
    String? email,
    String? password,
    FormStatus? formStatus,
    LoginBlocError? error,
  }) =>
      LoginViewState(
        email: email ?? this.email,
        password: password ?? this.password,
        formStatus: formStatus ?? this.formStatus,
        error: error ?? this.error,
      );
}
