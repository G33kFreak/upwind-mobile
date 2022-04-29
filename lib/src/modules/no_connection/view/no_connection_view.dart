import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:upwind/src/config/colors.dart';

class NoConnectionView extends StatelessWidget {
  const NoConnectionView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset('assets/icons/no_connection.svg'),
              const SizedBox(height: 30),
              Text(
                AppLocalizations.of(context)!.noConnection,
                style: Theme.of(context)
                    .textTheme
                    .headline3
                    ?.copyWith(color: textGrey),
              ),
              Text(
                AppLocalizations.of(context)!.checkYourConnection,
                style: Theme.of(context)
                    .textTheme
                    .bodyText1
                    ?.copyWith(color: textGrey.withOpacity(0.5)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
