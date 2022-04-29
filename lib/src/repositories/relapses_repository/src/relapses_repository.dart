import 'package:dio/dio.dart';
import 'package:upwind/src/repositories/relapses_repository/relapses_repository.dart';
import 'package:upwind/src/repositories/relapses_repository/src/api/relapses_endpoints.dart';

class RelapsesRepository implements IRelapsesRepository {
  final Dio authHttpClient;
  final PostAddRelapse postAddRelapse;

  const RelapsesRepository({
    required this.authHttpClient,
    required this.postAddRelapse,
  });

  @override
  Future<void> createRelapse({
    required int habitId,
    required String reason,
  }) async =>
      await postAddRelapse(authHttpClient, habitId, reason);
}
