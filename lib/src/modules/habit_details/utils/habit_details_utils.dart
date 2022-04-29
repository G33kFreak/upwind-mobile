import 'package:intl/intl.dart';

class HabitDetailsUtils {
  static getRelapseFormattedDate(DateTime dateTime) {
    final DateFormat dateFormat = DateFormat('yyyy.MM.dd');

    return dateFormat.format(dateTime);
  }
}
