import 'package:flutter/material.dart';
import 'package:upwind/src/config/colors.dart';
import 'package:upwind/src/repositories/habits_repository/habits_repository.dart';

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
              Text('Time saved', style: Theme.of(context).textTheme.bodyText2),
              Text('Money saved', style: Theme.of(context).textTheme.bodyText2),
            ],
          )
        ],
      ),
    );
  }
}
