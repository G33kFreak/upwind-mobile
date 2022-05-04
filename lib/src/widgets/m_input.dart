import 'package:flutter/material.dart';
import 'package:upwind/src/config/colors.dart';

class MInput extends StatefulWidget {
  final bool hasError;
  final String? hintText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool hideText;
  final void Function(String)? onChanged;
  final void Function()? onEditingComplete;
  final TextInputType? inputType;

  const MInput({
    Key? key,
    this.hasError = false,
    this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.hideText = false,
    this.onChanged,
    this.onEditingComplete,
    this.inputType,
  }) : super(key: key);

  @override
  State<MInput> createState() => _MInputState();
}

class _MInputState extends State<MInput> {
  static const _widgetHeight = 50.0;
  static const _inputHeight = 45.0;

  final FocusNode _focusNode = FocusNode();
  bool isFocused = false;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(_focusNodeController);
  }

  void _focusNodeController() {
    setState(() {
      isFocused = _focusNode.hasFocus;
    });
    if (!isFocused && widget.onEditingComplete != null) {
      widget.onEditingComplete!();
    }
  }

  Color _getUnderlineColor() {
    if (widget.hasError) {
      return error;
    } else if (isFocused) {
      return purpleDark;
    } else {
      return Colors.transparent;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: _widgetHeight,
      child: Stack(
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            margin: const EdgeInsets.only(top: 5),
            height: _widgetHeight,
            decoration: BoxDecoration(
              color: _getUnderlineColor(),
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(30),
                bottom: Radius.circular(13),
              ),
            ),
          ),
          Container(
            height: _inputHeight,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(
                Radius.circular(13),
              ),
              boxShadow: [
                BoxShadow(
                  color: textGrey.withOpacity(0.25),
                  offset: const Offset(0, 4),
                  spreadRadius: 0,
                  blurRadius: 4,
                ),
              ],
            ),
            child: TextFormField(
              focusNode: _focusNode,
              obscureText: widget.hideText,
              keyboardType: widget.inputType,
              style: Theme.of(context).textTheme.bodyText2,
              decoration: InputDecoration(
                hintStyle: const TextStyle(color: textGrey),
                contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                prefixIcon: widget.prefixIcon,
                suffixIcon: widget.suffixIcon,
                hintText: widget.hintText,
                fillColor: Colors.white,
                filled: true,
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(13),
                  ),
                  borderSide: BorderSide.none,
                ),
              ),
              cursorColor: purpleDark,
              onChanged: widget.onChanged,
            ),
          ),
        ],
      ),
    );
  }
}
