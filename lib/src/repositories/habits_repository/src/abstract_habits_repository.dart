import 'package:upwind/src/repositories/habits_repository/src/models/habit_details.dart';
import 'package:upwind/src/repositories/habits_repository/src/models/habit_list_item.dart';

abstract class IHabitsRepository {
  Future<List<HabitListItem>> getHabits();

  Future<HabitDetails> getHabitsDetails();

  Future<void> deleteHabit(int id);
}
