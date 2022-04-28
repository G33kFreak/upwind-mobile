import 'package:flutter/material.dart';
import 'package:upwind/src/modules/main_view/utils/main_view_utils.dart';
import 'package:upwind/src/modules/main_view/widgets/calendar/main_view_calendar_item.dart';

class MainViewCalendarList extends StatelessWidget {
  MainViewCalendarList({Key? key}) : super(key: key);

  final datesOfWeek = MainViewUtils.getDatesOfWeek(DateTime.now());

  List<Widget> _generateItems() {
    return List.generate(
      datesOfWeek.length,
      (index) => MainViewCalendarItem(date: datesOfWeek[index]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: _generateItems(),
    );
  }
}
