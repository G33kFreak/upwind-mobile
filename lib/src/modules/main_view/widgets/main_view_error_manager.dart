import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:upwind/src/modules/main_view/bloc/main_view_bloc.dart';
import 'package:upwind/src/modules/main_view/utils/exceptions.dart';
import 'package:upwind/src/widgets/error_snackbar_manager.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MainViewErrorManager extends StatelessWidget {
  const MainViewErrorManager({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainViewBloc, MainViewState>(
      builder: (context, state) {
        return ErrorSnackbarManager<MainViewBlocError>(
          error: state.error,
          errorToSkip: const [MainViewBlocError.none],
          errorMessageDelegate: (error) =>
              error.localizedString(AppLocalizations.of(context)!),
        );
      },
    );
  }
}
