import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:upwind/src/config/colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:upwind/src/modules/main_view/utils/main_view_utils.dart';

class HabitProgressIndicator extends StatelessWidget {
  final int days;
  final DateTime timeStart;

  const HabitProgressIndicator({
    Key? key,
    required this.days,
    required this.timeStart,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 2,
      child: CircularPercentIndicator(
        radius: 48,
        lineWidth: 8,
        percent: MainViewUtils.getProgressValueByTime(
          timeStart,
          DateTime.now(),
        ),
        backgroundColor: purpleDark.withOpacity(0.35),
        progressColor: purpleDark,
        circularStrokeCap: CircularStrokeCap.round,
        center: Text(
          '${days.toString()}\n${AppLocalizations.of(context)!.days}',
          style: Theme.of(context).textTheme.headline4,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
