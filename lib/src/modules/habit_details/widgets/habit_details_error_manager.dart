import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:upwind/src/modules/habit_details/bloc/habit_details_bloc.dart';
import 'package:upwind/src/modules/habit_details/utils/exceptions.dart';
import 'package:upwind/src/widgets/error_snackbar_manager.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HabitDetailsErrorManager extends StatelessWidget {
  const HabitDetailsErrorManager({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HabitDetailsBloc, HabitDetailsState>(
      builder: (context, state) {
        return ErrorSnackbarManager<HabitDetailsBlocError>(
          error: state.error,
          errorToSkip: const [HabitDetailsBlocError.none],
          errorMessageDelegate: (error) =>
              error.localizedString(AppLocalizations.of(context)!),
        );
      },
    );
  }
}
