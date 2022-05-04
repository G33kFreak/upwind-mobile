import 'package:flutter/material.dart';

typedef ErrorMessageDelegate<ErrorType> = String Function(ErrorType error);

class ErrorSnackbarManager<ErrorType> extends StatefulWidget {
  final Widget? child;
  final ErrorType error;
  final List<ErrorType> errorToSkip;
  final ErrorMessageDelegate<ErrorType> errorMessageDelegate;

  const ErrorSnackbarManager({
    Key? key,
    required this.error,
    required this.errorToSkip,
    required this.errorMessageDelegate,
    this.child,
  }) : super(key: key);

  @override
  State<ErrorSnackbarManager> createState() =>
      _ErrorSnackbarManagerState<ErrorType>();
}

class _ErrorSnackbarManagerState<ErrorType>
    extends State<ErrorSnackbarManager<ErrorType>> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback(
      (timeStamp) => _handleNewState(),
    );
  }

  @override
  void didUpdateWidget(
    covariant ErrorSnackbarManager<ErrorType> oldWidget,
  ) {
    super.didUpdateWidget(oldWidget);
    _handleNewStateAfterBuild();
  }

  void _handleNewStateAfterBuild() => Future.delayed(Duration.zero).then(
        (_) => _handleNewState(),
      );

  void _handleNewState() {
    if (!mounted) {
      return;
    }

    ScaffoldMessenger.of(context).hideCurrentSnackBar();

    if (!widget.errorToSkip.contains(widget.error)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: _buildSnackbarContent()),
      );
    }
  }

  Widget _buildSnackbarContent() {
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
          child: Text(widget.errorMessageDelegate(widget.error)),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) => widget.child ?? Container();
}
