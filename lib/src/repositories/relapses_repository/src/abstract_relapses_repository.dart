import 'package:upwind/src/repositories/relapses_repository/src/models/report.dart';

abstract class IRelapsesRepository {
  Future<void> createRelapse({required int habitId, required String reason});

  Future<Report> generateReport({
    required DateTime startDate,
    required DateTime endDate,
    int? habitId,
  });
}
