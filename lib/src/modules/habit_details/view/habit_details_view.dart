import 'dart:convert';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:upwind/src/config/colors.dart';
import 'package:upwind/src/modules/habit_details/widgets/habit_list_item_data.dart';
import 'package:upwind/src/repositories/habits_repository/habits_repository.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HabitDetailsView extends StatelessWidget {
  const HabitDetailsView({Key? key}) : super(key: key);

  HabitListItem _getProvidedHabit(BuildContext context) {
    final providedData = context.routeData.queryParams.optString('habit');
    return HabitListItem.fromJson(jsonDecode(providedData!));
  }

  @override
  Widget build(BuildContext context) {
    final habitListItem = _getProvidedHabit(context);

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
                  Text(
                    AppLocalizations.of(context)!.relapses,
                    style: Theme.of(context).textTheme.headline6,
                  )
                ],
              ),
            ),
            const BackButton(),
          ],
        ),
      ),
    );
  }
}
