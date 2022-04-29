import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:upwind/src/config/routes/habit_details.dart';
import 'package:upwind/src/config/routes/login.dart';
import 'package:upwind/src/config/routes/main.dart';
import 'package:upwind/src/config/routes/no_connection.dart';
import 'package:upwind/src/config/routes/welcome.dart';

part 'routes.gr.dart';

class Routes {
  static const welcome = WelcomeRouteHelper();
  static const login = LoginRouteHelper();
  static const main = MainRouteHelper();
  static const noConnection = NoConnectionRouteHelper();
  static const habitDetails = HabitDetailsRouteHelper();
}

@AdaptiveAutoRouter(routes: [
  AutoRoute(
    page: WelcomeRouteHelper.widget,
    path: WelcomeRouteHelper.path,
    initial: true,
  ),
  AutoRoute(
    page: LoginRouteHelper.widget,
    path: LoginRouteHelper.path,
  ),
  AutoRoute(
    page: MainRouteHelper.widget,
    path: MainRouteHelper.path,
  ),
  AutoRoute(
    page: NoConnectionRouteHelper.widget,
    path: NoConnectionRouteHelper.path,
  ),
  CustomRoute(
    page: HabitDetailsRouteHelper.widget,
    path: HabitDetailsRouteHelper.path,
    transitionsBuilder: TransitionsBuilders.fadeIn,
  )
])
class AppRouter extends _$AppRouter {}
