import 'package:upwind/src/repositories/habits_repository/src/models/habit_details.dart';
import 'package:upwind/src/repositories/habits_repository/src/models/habit_list_item.dart';

abstract class IHabitsRepository {
  Future<List<HabitListItem>> getHabits();

  Future<HabitDetails> getHabitsDetails({required int id});

  Future<void> deleteHabit({required int id});

  Future<void> createHabit({
    required String habitName,
    required double moneyPerWeek,
    required double timePerWeek,
  });
}
