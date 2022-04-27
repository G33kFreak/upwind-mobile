import 'package:flutter/material.dart';
import 'package:upwind/src/config/colors.dart';

class SavedValueContainer extends StatelessWidget {
  final String valueText;

  const SavedValueContainer({
    Key? key,
    required this.valueText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(16)),
        color: purpleDark,
      ),
      child: Row(
        children: [
          Text(
            valueText,
            style: Theme.of(context).textTheme.subtitle1,
          )
        ],
      ),
    );
  }
}
