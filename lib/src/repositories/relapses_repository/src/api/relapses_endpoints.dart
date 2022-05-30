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

typedef PostReport = Future<Response> Function(
  Dio,
  DateTime,
  DateTime,
  int?,
);

final PostReport postReport = (
  Dio httpClient,
  DateTime dateStart,
  DateTime dateEnd,
  int? habitId,
) {
  final Map<String, dynamic> data = {
    'date_start': dateStart.toIso8601String(),
    'date_end': dateEnd.toIso8601String(),
  };

  if (habitId != null) {
    data['habit'] = habitId;
  }

  return httpClient.post(
    '/api/relapse/report/',
    data: data,
  );
};
