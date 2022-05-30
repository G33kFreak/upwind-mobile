import 'package:dio/dio.dart';
import 'package:upwind/src/config/api/exceptions.dart';
import 'package:upwind/src/repositories/relapses_repository/relapses_repository.dart';
import 'package:upwind/src/repositories/relapses_repository/src/api/relapses_endpoints.dart';
import 'package:upwind/src/repositories/relapses_repository/src/models/report.dart';

class RelapsesRepository implements IRelapsesRepository {
  final Dio authHttpClient;
  final PostAddRelapse postAddRelapse;
  final PostReport postReport;

  const RelapsesRepository({
    required this.authHttpClient,
    required this.postAddRelapse,
    required this.postReport,
  });

  @override
  Future<void> createRelapse({
    required int habitId,
    required String reason,
  }) async =>
      await postAddRelapse(authHttpClient, habitId, reason);

  @override
  Future<Report> generateReport({
    required DateTime startDate,
    required DateTime endDate,
    int? habitId,
  }) async {
    final response = await postReport(
      authHttpClient,
      startDate,
      endDate,
      habitId,
    );

    try {
      return Report.fromJson(response.data);
    } catch (e) {
      throw ApiResponseParseException(e.toString());
    }
  }
}
