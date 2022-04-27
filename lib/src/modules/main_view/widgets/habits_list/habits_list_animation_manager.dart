import 'package:flutter/material.dart';
import 'package:upwind/src/modules/main_view/widgets/habit_card/habit_list_item_card.dart';
import 'package:upwind/src/modules/main_view/widgets/habits_list/list_element_transition.dart';
import 'package:upwind/src/repositories/habits_repository/habits_repository.dart';

class HabitsListAnimationManager extends StatefulWidget {
  final Widget child;
  final List<HabitListItem> habits;
  final GlobalKey<AnimatedListState> listKey;

  const HabitsListAnimationManager({
    Key? key,
    this.habits = const [],
    required this.listKey,
    required this.child,
  }) : super(key: key);

  @override
  State<HabitsListAnimationManager> createState() =>
      _HabitsListAnimationManagerState();
}

class _HabitsListAnimationManagerState
    extends State<HabitsListAnimationManager> {
  @override
  void initState() {
    super.initState();

    _findAndAnimateDifferences(widget.habits);
  }

  @override
  void didUpdateWidget(covariant HabitsListAnimationManager oldWidget) {
    super.didUpdateWidget(oldWidget);

    _findAndAnimateDifferences(widget.habits, oldHabits: oldWidget.habits);
  }

  void _findAndAnimateDifferences(
    List<HabitListItem> newHabits, {
    List<HabitListItem> oldHabits = const [],
  }) {
    _findIndexDifferences(newHabits, oldHabits).forEach((index) {
      widget.listKey.currentState?.insertItem(index);
    });

    _findIndexDifferences(oldHabits, newHabits).forEach((index) {
      final habit = oldHabits[index];

      widget.listKey.currentState?.removeItem(
        index,
        (context, animation) => ListElementTransition(
          animation: animation,
          child: HabitListItemCard(habit: habit),
        ),
      );
    });
  }

  List<int> _findIndexDifferences(
    List<HabitListItem> a, [
    List<HabitListItem> b = const [],
  ]) {
    final difference = a.toSet().difference(b.toSet());

    return difference.map<int>((habit) => a.indexOf(habit)).toList();
  }

  @override
  Widget build(BuildContext context) => widget.child;
}
