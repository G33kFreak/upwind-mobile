abstract class IRelapsesRepository {
  Future<void> createRelapse({required int habitId, required String reason});
}
