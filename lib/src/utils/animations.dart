import 'package:flutter/material.dart';

Animation<double> curveAnimation(
  Animation<double> parent, {
  Curve curve = Curves.decelerate,
}) =>
    Tween<double>(begin: 0, end: 1)
        .animate(CurvedAnimation(parent: parent, curve: curve));

Animation<double> curveSizeAnimation(Animation<double> parent) =>
    curveAnimation(parent, curve: Curves.easeOutSine);

Animation<double> curveFadeAnimation(Animation<double> parent) =>
    curveAnimation(parent, curve: Curves.easeIn);
