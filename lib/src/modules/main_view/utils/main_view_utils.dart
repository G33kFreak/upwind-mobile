import 'dart:io';

import 'package:intl/intl.dart';

class MainViewUtils {
  static List<DateTime> getDatesOfWeek() {
    final today = DateTime.now();
    final firstDayOfWeek = today.subtract(Duration(days: today.weekday - 1));
    return List.generate(
      7,
      (index) => firstDayOfWeek.add(Duration(days: index)),
    );
  }

  static String getWeekdayName(DateTime date) =>
      DateFormat.E(Platform.localeName).format(date);
}
