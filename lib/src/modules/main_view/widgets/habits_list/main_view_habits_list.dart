import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:upwind/src/config/colors.dart';
import 'package:upwind/src/modules/main_view/bloc/main_view_bloc.dart';
import 'package:upwind/src/modules/main_view/widgets/habit_card/habit_list_item_card.dart';
import 'package:upwind/src/modules/main_view/widgets/habits_list/habits_list_animation_manager.dart';
import 'package:upwind/src/utils/form_status.dart';
import 'package:upwind/src/widgets/animated_loading_indicator.dart';
import 'package:upwind/src/widgets/list_element_transition.dart';

class MainViewHabitsList extends StatelessWidget {
  MainViewHabitsList({Key? key}) : super(key: key);

  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainViewBloc, MainViewState>(
      builder: (context, state) {
        return HabitsListAnimationManager(
          listKey: _listKey,
          habits: state.habits,
          child: Expanded(
            flex: 8,
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: whiteGrey,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(24),
                ),
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  AnimatedLoadingIndicator(
                    show: state.listLoadingStatus is LoadingFormStatus,
                  ),
                  AnimatedList(
                    key: _listKey,
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    initialItemCount: state.habits.length,
                    itemBuilder: (context, index, animation) {
                      return ListElementTransition(
                        animation: animation,
                        child: HabitListItemCard(habit: state.habits[index]),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
