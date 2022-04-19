import 'package:equatable/equatable.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoginBlocException with EquatableMixin implements Exception {
  final String cause;

  const LoginBlocException(this.cause);

  @override
  String toString() => '$runtimeType: $cause';

  @override
  List<Object?> get props => [cause];
}

enum LoginBlocError {
  serverError,
  invalidLoginData,
  none,
}

extension StringValuesForErrors on LoginBlocError {
  String get text {
    switch (this) {
      case LoginBlocError.invalidLoginData:
        return 'Invalid login data';
      case LoginBlocError.serverError:
        return 'Server error';
      case LoginBlocError.none:
        return 'No error';
    }
  }

  String localizedString(AppLocalizations appLocalizations) {
    switch (this) {
      case LoginBlocError.serverError:
        return appLocalizations.serverError;
      case LoginBlocError.invalidLoginData:
        return appLocalizations.invalidLoginData;
      case LoginBlocError.none:
        return appLocalizations.noError;
    }
  }
}
