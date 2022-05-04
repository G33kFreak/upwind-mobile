import 'package:flutter/material.dart';

class MSnackbar extends StatelessWidget {
  final String text;
  final IconData? icon;

  const MSnackbar({
    Key? key,
    required this.text,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          fit: FlexFit.tight,
          child: Icon(
            icon ?? Icons.error_outline,
            color: Theme.of(context).snackBarTheme.contentTextStyle?.color,
          ),
        ),
        Flexible(
          fit: FlexFit.tight,
          flex: 7,
          child: Text(text),
        )
      ],
    );
  }
}
