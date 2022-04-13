import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:upwind/src/config/routes/main.dart';
import 'package:upwind/src/config/routes/welcome.dart';

part 'routes.gr.dart';

class Routes {
  static const welcome = WelcomeRouteHelper();
  static const main = MainRouteHelper();
}

@AdaptiveAutoRouter(routes: [
  AutoRoute(
    page: WelcomeRouteHelper.widget,
    path: WelcomeRouteHelper.path,
    initial: true,
  ),
  AutoRoute(
    page: MainRouteHelper.widget,
    path: MainRouteHelper.path,
  ),
])
class AppRouter extends _$AppRouter {}
