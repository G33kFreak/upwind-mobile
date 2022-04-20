part of 'authentication_bloc.dart';

@autoequalMixin
class AuthenticationState extends Equatable
    with _$AuthenticationStateAutoequalMixin {
  final AuthenticationStatus status;
  const AuthenticationState._({this.status = AuthenticationStatus.unknown});

  const AuthenticationState.unknown() : this._();

  const AuthenticationState.unauthenticated()
      : this._(status: AuthenticationStatus.unauthenticated);

  const AuthenticationState.authenticated()
      : this._(status: AuthenticationStatus.authenticated);
}
