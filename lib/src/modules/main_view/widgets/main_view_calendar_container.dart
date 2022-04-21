import 'package:flutter/material.dart';
import 'package:upwind/src/modules/main_view/widgets/main_view_calendar_list.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MainViewCalendarContainer extends StatelessWidget {
  const MainViewCalendarContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 3,
      child: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Text(
                AppLocalizations.of(context)!.todayIs,
                style: Theme.of(context).textTheme.headline2,
              ),
            ),
            Expanded(
              flex: 2,
              child: MainViewCalendarList(),
            )
          ],
        ),
      ),
    );
  }
}
