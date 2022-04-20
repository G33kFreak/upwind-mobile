import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:upwind/src/config/colors.dart';
import 'package:upwind/src/modules/login_view/bloc/login_view_bloc.dart';
import 'package:upwind/src/modules/login_view/utils/login_utils.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:upwind/src/utils/form_status.dart';

class LoginButton extends StatelessWidget {
  const LoginButton({Key? key}) : super(key: key);

  Widget _getWidgetByFormStatus({
    required BuildContext context,
    required FormStatus status,
    String? email,
    String? password,
  }) {
    if (status is LoadingFormStatus) {
      return const SpinKitRing(
        color: purpleLight,
        size: 40,
        lineWidth: 4,
      );
    } else if (LoginUtils.validateInputs(email, password)) {
      return SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          child: Text(
            AppLocalizations.of(context)!.signIn,
          ),
          onPressed: () =>
              context.read<LoginViewBloc>().add(const FormSubmitted()),
        ),
      );
    } else {
      return Container();
    }
  }

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
            child: _getWidgetByFormStatus(
              context: context,
              status: state.formStatus,
              email: state.email,
              password: state.password,
            ),
          ),
        );
      },
    );
  }
}
