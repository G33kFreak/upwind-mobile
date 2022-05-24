import 'package:dio/dio.dart';

typedef GetHabitsList = Future<Response> Function(Dio);

final GetHabitsList getHabitsList = (Dio httpClient) => httpClient.get(
      '/api/habits/',
    );

typedef DeleteHabitItem = Future<Response> Function(Dio, int);

final DeleteHabitItem deleteHabitItem =
    (Dio httpClient, int habitId) => httpClient.delete('/api/habit/$habitId/');

typedef GetHabitDetails = Future<Response> Function(Dio, int);

final GetHabitDetails getHabitDetails =
    (Dio httpClient, int habitId) => httpClient.get('/api/habit/$habitId/');

typedef PostHabit = Future<Response> Function(Dio, String, double, double);

final PostHabit postHabit =
    (Dio httpClient, String name, double moneyPerWeek, double timePerWeek) =>
        httpClient.post('/api/habits/', data: {
          'name': name,
          'time_spend_weekly': timePerWeek,
          'money_spend_weekly': moneyPerWeek,
        });
