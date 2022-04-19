import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AnimatedLoginIcon extends StatelessWidget {
  const AnimatedLoginIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: 2,
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 200),
        transitionBuilder: (child, animation) => ScaleTransition(
          scale: animation,
          child: child,
        ),
        child: KeyboardVisibilityProvider.isKeyboardVisible(context)
            ? Container()
            : SvgPicture.asset('assets/icons/login.svg'),
      ),
    );
  }
}
