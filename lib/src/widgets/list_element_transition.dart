import 'package:flutter/material.dart';
import 'package:upwind/src/utils/animations.dart';

class ListElementTransition extends StatelessWidget {
  final Widget? child;
  final Animation<double> animation;

  const ListElementTransition({
    Key? key,
    this.child,
    required this.animation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: curveFadeAnimation(animation),
      child: SizeTransition(
        sizeFactor: curveSizeAnimation(animation),
        axisAlignment: -1,
        child: child,
      ),
    );
  }
}
