import 'package:dio/dio.dart';
import 'package:upwind/src/config/api/exceptions.dart';
import 'package:upwind/src/repositories/habits_repository/habits_repository.dart';

class HabitsRepository implements IHabitsRepository {
  final Dio authHttpClient;
  final GetHabitsList getHabitsList;
  final DeleteHabitItem deleteHabitItem;
  final GetHabitDetails getHabitDetails;

  const HabitsRepository({
    required this.authHttpClient,
    required this.getHabitsList,
    required this.deleteHabitItem,
    required this.getHabitDetails,
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
  Future<HabitDetails> getHabitsDetails({required int id}) async {
    final response = await getHabitDetails(authHttpClient, id);
    try {
      return HabitDetails.fromJson(response.data);
    } catch (e) {
      throw ApiResponseParseException(e.toString());
    }
  }

  @override
  Future<void> deleteHabit({required int id}) async => await deleteHabitItem(
        authHttpClient,
        id,
      );
}
