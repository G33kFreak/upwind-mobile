import 'package:flutter/material.dart';

Future<DateTimeRange?> openDateRangePicker(BuildContext context) async {
  return await showDateRangePicker(
    context: context,
    firstDate: DateTime(2020, 1, 1),
    lastDate: DateTime.now(),
    currentDate: DateTime.now(),
  );
}
