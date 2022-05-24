import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:upwind/src/modules/habit_details/widgets/habit_details_error_manager.dart';
import 'package:upwind/src/modules/login_view/bloc/login_view_bloc_provider.dart';
import 'package:upwind/src/modules/login_view/widgets/animated_login_icon.dart';
import 'package:upwind/src/modules/login_view/widgets/login_button.dart';
import 'package:upwind/src/modules/login_view/widgets/login_error_snackbar_manager.dart';
import 'package:upwind/src/modules/login_view/widgets/login_inputs.dart';

class LoginView extends StatelessWidget implements AutoRouteWrapper {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return KeyboardDismissOnTap(
      dismissOnCapturedTaps: true,
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.11,
            ),
            child: KeyboardVisibilityProvider(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  LoginErrorSnackbarManager(),
                  Spacer(),
                  AnimatedLoginIcon(),
                  Spacer(),
                  LoginInputs(),
                  LoginButton(),
                  Spacer()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget wrappedRoute(BuildContext context) {
    return LogiViewBlocProvider(child: this);
  }
}
