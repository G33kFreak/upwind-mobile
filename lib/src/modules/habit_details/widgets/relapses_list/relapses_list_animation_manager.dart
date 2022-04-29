import 'package:flutter/material.dart';
import 'package:upwind/src/modules/habit_details/widgets/relapses_list/relapse_list_card.dart';
import 'package:upwind/src/repositories/relapses_repository/src/models/relapse.dart';
import 'package:upwind/src/widgets/list_animation_manager.dart';
import 'package:upwind/src/widgets/list_element_transition.dart';

class RelapsesListAnimationManager extends StatelessWidget {
  final Widget child;
  final List<Relapse> relapses;
  final GlobalKey<AnimatedListState> listKey;

  const RelapsesListAnimationManager({
    Key? key,
    this.relapses = const [],
    required this.listKey,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListAnimationManager<Relapse>(
      listKey: listKey,
      items: relapses,
      listItemBuilder: (context, animation, relapse) => ListElementTransition(
        animation: animation,
        child: RelapseListCard(
          relapse: relapse,
        ),
      ),
      child: child,
    );
  }
}
