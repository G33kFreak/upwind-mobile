import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:upwind/src/config/colors.dart';
import 'package:upwind/src/modules/main_view/bloc/main_view_bloc_provider.dart';
import 'package:upwind/src/modules/main_view/widgets/main_view_calendar_container.dart';
import 'package:upwind/src/modules/main_view/widgets/main_view_fab.dart';
import 'package:upwind/src/modules/main_view/widgets/main_view_menu.dart';

class MainView extends StatelessWidget implements AutoRouteWrapper {
  const MainView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: purpleLight,
      floatingActionButton: const MainViewFab(),
      body: Stack(
        children: [
          Column(
            children: [
              const MainViewCalendarContainer(),
              Expanded(
                flex: 8,
                child: Container(
                  decoration: const BoxDecoration(
                    color: whiteGrey,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(24),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const MainViewMenu(),
        ],
      ),
    );
  }

  @override
  Widget wrappedRoute(BuildContext context) {
    return MainViewBlocProvider(child: this);
  }
}
