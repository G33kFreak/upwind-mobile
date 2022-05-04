import 'package:equatable/equatable.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:upwind/src/modules/main_view/utils/exceptions.dart';

class HabitDetailsBlocException with EquatableMixin implements Exception {
  final String cause;

  const HabitDetailsBlocException(this.cause);

  @override
  String toString() => '$runtimeType: $cause';

  @override
  List<Object?> get props => [cause];
}

enum HabitDetailsBlocError { serverError, none }

extension StringValuesForErrors on HabitDetailsBlocError {
  String get text {
    switch (this) {
      case HabitDetailsBlocError.serverError:
        return 'Server error';
      case HabitDetailsBlocError.none:
        return 'No error';
    }
  }

  String localizedString(AppLocalizations appLocalizations) {
    switch (this) {
      case HabitDetailsBlocError.serverError:
        return appLocalizations.serverError;
      case HabitDetailsBlocError.none:
        return appLocalizations.noError;
    }
  }
}
