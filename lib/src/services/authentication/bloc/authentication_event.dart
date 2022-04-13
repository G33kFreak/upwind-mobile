part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object?> get props => [];
}

@autoequalMixin
class InitializedWithStatus extends AuthenticationEvent
    with _$InitializedWithStatusAutoequalMixin {
  final AuthenticationStatus status;

  const InitializedWithStatus(this.status);
}

@autoequalMixin
class AuthenticationStatusChanged extends AuthenticationEvent
    with _$InitializedWithStatusAutoequalMixin {
  final AuthenticationStatus status;

  const AuthenticationStatusChanged(this.status);
}

@autoequalMixin
class Logout extends AuthenticationEvent
    with _$InitializedWithStatusAutoequalMixin {}
