import 'package:flutter/material.dart';
import 'package:upwind/src/modules/main_view/widgets/habit_card/habit_list_item_card.dart';
import 'package:upwind/src/repositories/habits_repository/habits_repository.dart';
import 'package:upwind/src/widgets/list_animation_manager.dart';
import 'package:upwind/src/widgets/list_element_transition.dart';

class HabitsListAnimationManager extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return ListAnimationManager<HabitListItem>(
      listKey: listKey,
      items: habits,
      listItemBuilder: (context, animation, habit) => ListElementTransition(
        animation: animation,
        child: HabitListItemCard(habit: habit),
      ),
      child: child,
    );
  }
}
