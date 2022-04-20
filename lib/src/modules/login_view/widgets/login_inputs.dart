import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:upwind/src/config/colors.dart';
import 'package:upwind/src/modules/login_view/bloc/login_view_bloc.dart';
import 'package:upwind/src/modules/login_view/utils/exceptions.dart';
import 'package:upwind/src/utils/form_status.dart';
import 'package:upwind/src/widgets/m_input.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoginInputs extends StatelessWidget {
  const LoginInputs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginViewBloc, LoginViewState>(
      builder: (context, state) {
        return Column(
          children: [
            const SizedBox(height: 40),
            MInput(
              prefixIcon: const Icon(
                Icons.email_rounded,
                color: textGrey,
              ),
              inputType: TextInputType.emailAddress,
              hintText: AppLocalizations.of(context)!.email,
              onChanged: (value) =>
                  context.read<LoginViewBloc>().add(EmailChanged(value)),
              hasError: state.error != LoginBlocError.none &&
                  state.formStatus is ErrorFormStatus,
            ),
            const SizedBox(height: 40),
            MInput(
              prefixIcon: const Icon(
                Icons.lock,
                color: textGrey,
              ),
              hideText: true,
              inputType: TextInputType.emailAddress,
              hintText: AppLocalizations.of(context)!.password,
              onChanged: (value) =>
                  context.read<LoginViewBloc>().add(PasswordChanged(value)),
              hasError: state.error != LoginBlocError.none &&
                  state.formStatus is ErrorFormStatus,
            ),
            const SizedBox(height: 40),
          ],
        );
      },
    );
  }
}
