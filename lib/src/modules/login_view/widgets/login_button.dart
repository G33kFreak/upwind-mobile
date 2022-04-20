import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:upwind/src/modules/login_view/bloc/login_view_bloc.dart';
import 'package:upwind/src/modules/login_view/utils/login_utils.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoginButton extends StatelessWidget {
  const LoginButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginViewBloc, LoginViewState>(
      builder: (context, state) {
        return Flexible(
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 200),
            transitionBuilder: (child, animation) => ScaleTransition(
              scale: animation,
              child: child,
            ),
            child: LoginUtils.validateInputs(
              state.email,
              state.password,
            )
                ? SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      child: Text(
                        AppLocalizations.of(context)!.signIn,
                      ),
                      onPressed: () => context
                          .read<LoginViewBloc>()
                          .add(const FormSubmitted()),
                    ),
                  )
                : Container(),
          ),
        );
      },
    );
  }
}
