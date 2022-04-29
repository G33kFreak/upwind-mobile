import 'package:flutter/material.dart';
import 'package:upwind/src/config/colors.dart';
import 'package:upwind/src/modules/main_view/widgets/habit_card/habit_progress_indicator.dart';
import 'package:upwind/src/modules/main_view/widgets/habit_card/saved_value_container.dart';
import 'package:upwind/src/repositories/habits_repository/habits_repository.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HabitListItemData extends StatelessWidget {
  final HabitListItem habit;

  const HabitListItemData({
    Key? key,
    required this.habit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 15),
          child: Hero(
            tag: 'habit-card-title-${habit.id}',
            child: Text(
              habit.name,
              style: Theme.of(context)
                  .textTheme
                  .headline3
                  ?.copyWith(color: textGrey),
            ),
          ),
        ),
        Hero(
          tag: 'habit-card-progress-indicator-${habit.id}',
          child: HabitProgressIndicator(
            days: habit.days,
            timeStart: habit.startDate,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Hero(
              tag: 'habit-card-saved-time-${habit.id}',
              child: Column(
                children: [
                  Text(
                    AppLocalizations.of(context)!.timeSaved,
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                  const SizedBox(height: 8),
                  SavedValueContainer(valueText: '${habit.savedTime} hr.')
                ],
              ),
            ),
            Hero(
              tag: 'habit-card-saved-money-${habit.id}',
              child: Column(
                children: [
                  Text(
                    AppLocalizations.of(context)!.moneySaved,
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                  const SizedBox(height: 8),
                  SavedValueContainer(valueText: '${habit.savedMoney}\$')
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
