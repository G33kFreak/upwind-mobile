import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:upwind/src/config/api/clients.dart';
import 'package:upwind/src/modules/main_view/bloc/main_view_bloc.dart';
import 'package:upwind/src/repositories/habits_repository/habits_repository.dart';
import 'package:upwind/src/repositories/relapses_repository/relapses_repository.dart';
import 'package:upwind/src/repositories/relapses_repository/src/api/relapses_endpoints.dart';

class MainViewBlocProvider extends StatelessWidget {
  final Widget? child;

  const MainViewBlocProvider({Key? key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<MainViewBloc>(
      create: (context) {
        final bloc = MainViewBloc(
          habitsRepository: HabitsRepository(
            authHttpClient: context.read<ApiProvider>().authenticatedHttpClient,
            getHabitsList: getHabitsList,
            deleteHabitItem: deleteHabitItem,
            getHabitDetails: getHabitDetails,
            postHabit: postHabit,
          ),
          relapsesRepository: RelapsesRepository(
            authHttpClient: context.read<ApiProvider>().authenticatedHttpClient,
            postAddRelapse: postAddRelapse,
          ),
        );

        bloc.add(const LoadHabits());
        return bloc;
      },
      child: child,
    );
  }
}
