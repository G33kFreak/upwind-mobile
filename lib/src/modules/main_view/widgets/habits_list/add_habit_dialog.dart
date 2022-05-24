import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:upwind/src/config/colors.dart';
import 'package:upwind/src/widgets/m_input.dart';
import 'package:upwind/src/widgets/m_snackbar.dart';

class AddHabitDialogResponse {
  final String name;
  final double timeSpendWeekly;
  final double moneySpendWeekly;

  const AddHabitDialogResponse({
    required this.name,
    required this.timeSpendWeekly,
    required this.moneySpendWeekly,
  });
}

Future<AddHabitDialogResponse?> showAddHabitDialog(
  BuildContext context,
) async {
  final newHabit = await showAnimatedDialog<AddHabitDialogResponse?>(
    context: context,
    barrierDismissible: true,
    animationType: DialogTransitionType.slideFromBottomFade,
    curve: Curves.easeInOutCubicEmphasized,
    builder: (context) => const Dialog(
      child: AddHabitDialog(),
    ),
  );

  return newHabit;
}

class AddHabitDialog extends StatefulWidget {
  const AddHabitDialog({Key? key}) : super(key: key);

  @override
  State<AddHabitDialog> createState() => _AddHabitDialogState();
}

class _AddHabitDialogState extends State<AddHabitDialog> {
  String habitTitle = '';
  double moneyPerWeek = 0.0;
  double timePerWeek = 0.0;

  void _onTitleChanged(String newValue) {
    habitTitle = newValue;
  }

  void _onMoneyChanged(String value) {
    double? newMoneyPerWeek = double.tryParse(value);
    if (newMoneyPerWeek != null) {
      moneyPerWeek = newMoneyPerWeek;
    }
  }

  void _onTimeChanged(String value) {
    double? newTimePerWeek = double.tryParse(value);
    if (newTimePerWeek != null) {
      timePerWeek = newTimePerWeek;
    }
  }

  void _onSavePressed() {
    if (habitTitle.isEmpty) {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: MSnackbar(
            text: AppLocalizations.of(context)!.habitTitleEmptyError,
          ),
        ),
      );
    }
    if (habitTitle.isNotEmpty) {
      context.router.pop<AddHabitDialogResponse>(AddHabitDialogResponse(
        name: habitTitle,
        timeSpendWeekly: timePerWeek,
        moneySpendWeekly: moneyPerWeek,
      ));
    } else {
      context.router.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            AppLocalizations.of(context)!.newHabit,
            style: Theme.of(context).textTheme.headline6,
          ),
          const SizedBox(height: 20),
          MInput(
            hintText: AppLocalizations.of(context)!.habitTitle,
            onChanged: _onTitleChanged,
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                flex: 3,
                child: Column(
                  children: [
                    Text(AppLocalizations.of(context)!.moneySpendWeekly),
                    const SizedBox(height: 5),
                    MInput(
                      hintText: '0',
                      textAlign: TextAlign.center,
                      inputType: TextInputType.number,
                      onChanged: _onMoneyChanged,
                    ),
                  ],
                ),
              ),
              const Spacer(),
              Expanded(
                flex: 3,
                child: Column(
                  children: [
                    Text(AppLocalizations.of(context)!.timeSpendWeekly),
                    const SizedBox(height: 5),
                    MInput(
                      hintText: '0',
                      textAlign: TextAlign.center,
                      inputType: TextInputType.number,
                      onChanged: _onTimeChanged,
                    ),
                  ],
                ),
              )
            ],
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: _onSavePressed,
            child: Text(
              AppLocalizations.of(context)!.save,
              style: Theme.of(context)
                  .textTheme
                  .bodyText2
                  ?.copyWith(color: whiteSnow),
            ),
          )
        ],
      ),
    );
  }
}
