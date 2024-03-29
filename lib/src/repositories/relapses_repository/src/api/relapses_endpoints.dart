import 'package:dio/dio.dart';

typedef PostAddRelapse = Future<Response> Function(Dio, int, String);

final PostAddRelapse postAddRelapse = (
  Dio httpClient,
  int habitId,
  String reason,
) =>
    httpClient.post(
      '/api/relapses/',
      data: {
        "habit": habitId,
        "reason": reason,
      },
    );
