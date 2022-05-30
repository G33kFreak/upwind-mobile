import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:upwind/src/config/api/clients.dart';
import 'package:upwind/src/config/routes.dart';
import 'package:upwind/src/config/routes/report.dart';
import 'package:upwind/src/modules/main_view/bloc/main_view_bloc.dart';
import 'package:upwind/src/repositories/habits_repository/habits_repository.dart';
import 'package:upwind/src/repositories/relapses_repository/relapses_repository.dart';
import 'package:upwind/src/repositories/relapses_repository/src/api/relapses_endpoints.dart';
import 'package:upwind/src/widgets/global_loader.dart';

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
            postReport: postReport,
          ),
        );

        bloc.add(const LoadHabits());
        return bloc;
      },
      child: BlocListener<MainViewBloc, MainViewState>(
        listenWhen: (previous, current) {
          if (previous is GeneratingRaportState &&
              current is! GeneratingRaportState) {
            // if loading of raport is ended, turning off global loader
            context.router.pop();

            // if we've got raport from BE, push user to report screen
            if (current.generatedReport != null) {
              context.router.pushNamed(
                Routes.report.generatePath(
                  ReportRouteParams(report: current.generatedReport!),
                ),
              );
            }
          }
          return true;
        },
        listener: (context, state) {
          if (state is GeneratingRaportState) {
            showGlobalLoader(context);
          }
        },
        child: child,
      ),
    );
  }
}
