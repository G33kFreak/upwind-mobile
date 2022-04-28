import 'package:dio/dio.dart';

typedef GetHabitsList = Future<Response> Function(Dio);

final GetHabitsList getHabitsList = (Dio httpClient) => httpClient.get(
      '/api/habits/',
    );

typedef DeleteHabitItem = Future<Response> Function(
  Dio,
  int,
);

final DeleteHabitItem deleteHabitItem = (
  Dio httpClient,
  int habitId,
) =>
    httpClient.delete('/api/habit/$habitId/');
