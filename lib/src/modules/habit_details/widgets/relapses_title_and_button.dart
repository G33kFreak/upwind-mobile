import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:upwind/src/config/colors.dart';

class RelapsesTitleAndButton extends StatelessWidget {
  const RelapsesTitleAndButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          AppLocalizations.of(context)!.relapses,
          style: Theme.of(context).textTheme.headline6,
        ),
        const SizedBox(width: 4),
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            shape: const CircleBorder(),
          ),
          child: const Icon(
            Icons.add,
            color: whiteSnow,
            size: 20,
          ),
        )
      ],
    );
  }
}
