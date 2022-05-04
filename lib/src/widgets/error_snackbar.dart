import 'package:flutter/material.dart';

class ErrorSnackbar extends StatelessWidget {
  final String errorText;

  const ErrorSnackbar({
    Key? key,
    required this.errorText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          fit: FlexFit.tight,
          child: Icon(
            Icons.error_outline,
            color: Theme.of(context).snackBarTheme.contentTextStyle?.color,
          ),
        ),
        Flexible(
          fit: FlexFit.tight,
          flex: 7,
          child: Text(errorText),
        )
      ],
    );
  }
}
