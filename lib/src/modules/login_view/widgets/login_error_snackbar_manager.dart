import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:upwind/src/modules/login_view/bloc/login_view_bloc.dart';
import 'package:upwind/src/modules/login_view/utils/exceptions.dart';
import 'package:upwind/src/widgets/error_snackbar_manager.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoginErrorSnackbarManager extends StatelessWidget {
  const LoginErrorSnackbarManager({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginViewBloc, LoginViewState>(
      builder: (context, state) {
        return ErrorSnackbarManager<LoginBlocError>(
          error: state.error,
          errorToSkip: const [LoginBlocError.none],
          errorMessageDelegate: (error) =>
              error.localizedString(AppLocalizations.of(context)!),
        );
      },
    );
  }
}
