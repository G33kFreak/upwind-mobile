part of 'login_view_bloc.dart';

abstract class LoginViewEvent extends Equatable {
  const LoginViewEvent();

  @override
  List<Object?> get props => [];
}

@autoequalMixin
class EmailChanged extends LoginViewEvent with _$EmailChangedAutoequalMixin {
  final String email;

  const EmailChanged(this.email);
}

@autoequalMixin
class PasswordChanged extends LoginViewEvent
    with _$PasswordChangedAutoequalMixin {
  final String password;

  const PasswordChanged(this.password);
}

@autoequalMixin
class FormSubmitted extends LoginViewEvent with _$FormSubmittedAutoequalMixin {
  const FormSubmitted();
}
