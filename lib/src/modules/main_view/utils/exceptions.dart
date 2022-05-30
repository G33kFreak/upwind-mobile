import 'package:equatable/equatable.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MainViewBlocException with EquatableMixin implements Exception {
  final String cause;

  const MainViewBlocException(this.cause);

  @override
  String toString() => '$runtimeType: $cause';

  @override
  List<Object?> get props => [cause];
}

enum MainViewBlocError { serverError, none, notEnoughData }

extension StringValuesForErrors on MainViewBlocError {
  String get text {
    switch (this) {
      case MainViewBlocError.serverError:
        return 'Server error';
      case MainViewBlocError.none:
        return 'No error';
      case MainViewBlocError.notEnoughData:
        return 'Not enough data';
    }
  }

  String localizedString(AppLocalizations appLocalizations) {
    switch (this) {
      case MainViewBlocError.serverError:
        return appLocalizations.serverError;
      case MainViewBlocError.none:
        return appLocalizations.noError;
      case MainViewBlocError.notEnoughData:
        return appLocalizations.notEnoughData;
    }
  }
}
