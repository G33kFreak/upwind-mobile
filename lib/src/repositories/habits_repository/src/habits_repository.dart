import 'package:dio/dio.dart';
import 'package:upwind/src/config/api/exceptions.dart';
import 'package:upwind/src/repositories/habits_repository/habits_repository.dart';

class HabitsRepository implements IHabitsRepository {
  final Dio authHttpClient;
  final GetHabitsList getHabitsList;
  final DeleteHabitItem deleteHabitItem;

  const HabitsRepository({
    required this.authHttpClient,
    required this.getHabitsList,
    required this.deleteHabitItem,
  });

  @override
  Future<List<HabitListItem>> getHabits() async {
    final response = await getHabitsList(authHttpClient);
    try {
      return (response.data as List)
          .map((e) => HabitListItem.fromJson(e))
          .toList();
    } catch (e) {
      throw ApiResponseParseException(e.toString());
    }
  }

  @override
  Future<HabitDetails> getHabitsDetails() {
    // TODO: implement getHabitsDetails
    throw UnimplementedError();
  }

  @override
  Future<void> deleteHabit(int id) async => await deleteHabitItem(
        authHttpClient,
        habitId: id,
      );
}
