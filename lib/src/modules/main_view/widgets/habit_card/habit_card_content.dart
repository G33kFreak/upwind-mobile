import 'package:flutter/material.dart';
import 'package:upwind/src/config/colors.dart';
import 'package:upwind/src/modules/main_view/widgets/habit_card/saved_value_container.dart';
import 'package:upwind/src/repositories/habits_repository/habits_repository.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HabitCardContent extends StatelessWidget {
  final HabitListItem habit;

  const HabitCardContent({
    Key? key,
    required this.habit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 4,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            habit.name,
            style: Theme.of(context)
                .textTheme
                .headline3
                ?.copyWith(color: textGrey),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Text(
                    AppLocalizations.of(context)!.timeSaved,
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                  const SizedBox(height: 8),
                  SavedValueContainer(valueText: '${habit.savedTime} hr.')
                ],
              ),
              Column(
                children: [
                  Text(
                    AppLocalizations.of(context)!.moneySaved,
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                  const SizedBox(height: 8),
                  SavedValueContainer(valueText: '${habit.savedMoney}\$')
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
