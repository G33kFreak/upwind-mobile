import 'package:flutter/material.dart';
import 'package:upwind/src/config/colors.dart';
import 'package:upwind/src/modules/main_view/widgets/habit_card/habit_progress_indicator.dart';
import 'package:upwind/src/repositories/habits_repository/habits_repository.dart';

class HabitListItemCard extends StatelessWidget {
  final HabitListItem habit;

  const HabitListItemCard({
    Key? key,
    required this.habit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      color: whiteSnow,
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () {},
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          width: double.infinity,
          height: 136,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              HabitProgressIndicator(
                days: habit.days,
                timeStart: habit.startDate,
              ),
              const Spacer(),
              Expanded(
                flex: 4,
                child: Container(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
