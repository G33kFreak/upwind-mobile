import 'package:flutter/material.dart';
import 'package:upwind/src/config/colors.dart';
import 'package:upwind/src/modules/habit_details/utils/habit_details_utils.dart';
import 'package:upwind/src/repositories/relapses_repository/src/models/relapse.dart';

class RelapseListCard extends StatelessWidget {
  final Relapse relapse;
  const RelapseListCard({
    Key? key,
    required this.relapse,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.calendar_month_rounded,
                    color: purpleDark,
                    size: 24,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    HabitDetailsUtils.getRelapseFormattedDate(relapse.dateTime),
                    textAlign: TextAlign.center,
                  )
                ],
              ),
              const SizedBox(height: 8),
              Text(
                relapse.reason,
                style: Theme.of(context).textTheme.headline6,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
