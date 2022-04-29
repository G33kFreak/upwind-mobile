import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:upwind/src/modules/habit_details/bloc/habit_details_bloc.dart';
import 'package:upwind/src/modules/habit_details/widgets/relapses_list/relapse_list_card.dart';
import 'package:upwind/src/modules/habit_details/widgets/relapses_list/relapses_list_animation_manager.dart';
import 'package:upwind/src/utils/form_status.dart';
import 'package:upwind/src/widgets/animated_loading_indicator.dart';
import 'package:upwind/src/widgets/list_element_transition.dart';

class HabitRelapsesList extends StatelessWidget {
  HabitRelapsesList({Key? key}) : super(key: key);

  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HabitDetailsBloc, HabitDetailsState>(
      builder: (context, state) {
        return RelapsesListAnimationManager(
          listKey: _listKey,
          relapses: state.habitDetails?.relapses ?? [],
          child: Stack(
            alignment: Alignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: AnimatedLoadingIndicator(
                  show: state.relapsesLoadingStatus is LoadingFormStatus,
                ),
              ),
              AnimatedList(
                shrinkWrap: true,
                primary: false,
                physics: const NeverScrollableScrollPhysics(),
                key: _listKey,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                initialItemCount: state.habitDetails?.relapses.length ?? 0,
                itemBuilder: ((context, index, animation) {
                  final relapse = state.habitDetails!.relapses[index];

                  return ListElementTransition(
                    animation: animation,
                    child: RelapseListCard(relapse: relapse),
                  );
                }),
              )
            ],
          ),
        );
      },
    );
  }
}
