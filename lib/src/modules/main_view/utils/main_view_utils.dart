import 'dart:io';

import 'package:intl/intl.dart';

class MainViewUtils {
  static List<DateTime> getDatesOfWeek(DateTime date) {
    final firstDayOfWeek = date.subtract(Duration(days: date.weekday - 1));
    return List.generate(
      7,
      (index) => firstDayOfWeek.add(Duration(days: index)),
    );
  }

  static String getWeekdayName(DateTime date) =>
      DateFormat.E(Platform.localeName).format(date);

  static double getProgressValueByTime(
    DateTime startTime,
    DateTime timeToCompare,
  ) {
    final startHour = startTime.hour;
    final toCompareHour = timeToCompare.hour;

    final difference = startHour - toCompareHour;

    if (difference > 0) {
      return (difference * 100 / 24) / 100;
    } else {
      return ((24 + difference) * 100 / 24) / 100;
    }
  }
}
