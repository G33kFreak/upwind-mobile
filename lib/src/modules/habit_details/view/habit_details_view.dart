import 'dart:convert';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:upwind/src/config/colors.dart';
import 'package:upwind/src/modules/habit_details/bloc/habit_details_bloc_provider.dart';
import 'package:upwind/src/modules/habit_details/widgets/habit_list_item_data.dart';
import 'package:upwind/src/modules/habit_details/widgets/relapses_list/habit_relapses_list.dart';
import 'package:upwind/src/modules/habit_details/widgets/relapses_title_and_button.dart';
import 'package:upwind/src/repositories/habits_repository/habits_repository.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HabitDetailsView extends StatelessWidget implements AutoRouteWrapper {
  const HabitDetailsView({Key? key}) : super(key: key);

  static HabitListItem getProvidedHabit(BuildContext context) {
    final providedData = context.routeData.queryParams.optString('habit');
    return HabitListItem.fromJson(jsonDecode(providedData!));
  }

  @override
  Widget build(BuildContext context) {
    final habitListItem = getProvidedHabit(context);

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  HabitListItemData(habit: habitListItem),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {},
                    child: Text(
                      AppLocalizations.of(context)!.generateHabitsReport,
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1
                          ?.copyWith(color: whiteSnow),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const RelapsesTitleAndButton(),
                  HabitRelapsesList(),
                ],
              ),
            ),
            const BackButton(),
          ],
        ),
      ),
    );
  }

  @override
  Widget wrappedRoute(BuildContext context) {
    return HabitDetailsBlocProvider(child: this);
  }
}
