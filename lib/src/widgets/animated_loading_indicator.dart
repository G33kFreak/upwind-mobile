import 'package:flutter/material.dart';

class AnimatedLoadingIndicator extends StatelessWidget {
  final bool show;
  final double elevation;
  final Duration duration;

  const AnimatedLoadingIndicator({
    Key? key,
    this.show = true,
    this.elevation = 4,
    this.duration = const Duration(milliseconds: 300),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: duration,
      switchInCurve: Curves.easeOutQuint,
      child: show ? const CircularProgressIndicator() : Container(),
    );
  }
}
