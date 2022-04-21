import 'package:flutter/material.dart';
import 'package:upwind/src/config/colors.dart';

class MainViewMenuItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final Function() onPressed;

  const MainViewMenuItem({
    Key? key,
    required this.icon,
    required this.title,
    required this.onPressed,
  }) : super(key: key);

  BorderRadius get _borderRadius => const BorderRadius.all(
        Radius.circular(8),
      );

  double get size => 128;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        onTap: onPressed,
        borderRadius: _borderRadius,
        child: Ink(
          width: size,
          height: size,
          decoration: BoxDecoration(
            color: purpleDark,
            borderRadius: _borderRadius,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(icon, size: 32, color: whiteSnow),
              Text(
                title,
                style: Theme.of(context).textTheme.headline3,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
