import 'dart:convert';

import 'package:upwind/src/config/routes/routes.dart';
import 'package:upwind/src/modules/habit_details/view/habit_details_view.dart';
import 'package:upwind/src/repositories/habits_repository/habits_repository.dart';
export 'package:upwind/src/modules/habit_details/view/habit_details_view.dart';

class HabitDetailsRouteHelper extends RouteHelper<HabitDetailsRouteParams> {
  static const path = '/habit-details';
  static const widget = HabitDetailsView;

  const HabitDetailsRouteHelper() : super(path: path);

  @override
  String generatePath(HabitDetailsRouteParams params) {
    final queryParams = <String, String>{};

    queryParams['habit'] = jsonEncode(params.habitListItem.toJson());

    return Uri(
      path: absolutePath,
      queryParameters: queryParams,
    ).toString();
  }
}

class HabitDetailsRouteParams {
  final HabitListItem habitListItem;

  const HabitDetailsRouteParams({required this.habitListItem});
}
