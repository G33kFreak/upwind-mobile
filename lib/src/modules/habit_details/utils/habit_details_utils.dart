import 'package:intl/intl.dart';

class HabitDetailsUtils {
  static getRelapseFormattedDate(DateTime dateTime) {
    final DateFormat dateFormat = DateFormat('dd.MM.yyyy');

    return dateFormat.format(dateTime);
  }
}
