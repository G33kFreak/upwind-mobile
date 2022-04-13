import 'package:dio/dio.dart';

typedef GetHabitsList = Future<Response> Function(Dio);

final GetHabitsList getHabitsList = (Dio httpClient) => httpClient.get(
      '/api/habits/',
    );
