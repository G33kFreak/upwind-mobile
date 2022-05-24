import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:upwind/src/config/api/clients.dart';
import 'package:upwind/src/modules/habit_details/bloc/habit_details_bloc.dart';
import 'package:upwind/src/modules/habit_details/view/habit_details_view.dart';
import 'package:upwind/src/repositories/habits_repository/habits_repository.dart';
import 'package:upwind/src/repositories/relapses_repository/relapses_repository.dart';
import 'package:upwind/src/repositories/relapses_repository/src/api/relapses_endpoints.dart';

class HabitDetailsBlocProvider extends StatelessWidget {
  final Widget child;

  const HabitDetailsBlocProvider({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HabitDetailsBloc>(
      create: (context) {
        final bloc = HabitDetailsBloc(
          habitsRepository: HabitsRepository(
            authHttpClient: context.read<ApiProvider>().authenticatedHttpClient,
            getHabitDetails: getHabitDetails,
            getHabitsList: getHabitsList,
            deleteHabitItem: deleteHabitItem,
            postHabit: postHabit,
          ),
          relapsesRepository: RelapsesRepository(
            authHttpClient: context.read<ApiProvider>().authenticatedHttpClient,
            postAddRelapse: postAddRelapse,
          ),
        );
        final habitId = HabitDetailsView.getProvidedHabit(context).id;
        bloc.add(LoadHabitDetails(habitId: habitId));
        return bloc;
      },
      child: child,
    );
  }
}
