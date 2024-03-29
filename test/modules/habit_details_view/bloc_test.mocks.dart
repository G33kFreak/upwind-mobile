// Mocks generated by Mockito 5.1.0 from annotations
// in upwind/test/modules/habit_details_view/bloc_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i4;

import 'package:dio/dio.dart' as _i2;
import 'package:mockito/mockito.dart' as _i1;
import 'package:upwind/src/repositories/habits_repository/habits_repository.dart'
    as _i3;
import 'package:upwind/src/repositories/relapses_repository/relapses_repository.dart'
    as _i5;
import 'package:upwind/src/repositories/relapses_repository/src/api/relapses_endpoints.dart'
    as _i6;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types

class _FakeDio_0 extends _i1.Fake implements _i2.Dio {}

class _FakeResponse_1<T> extends _i1.Fake implements _i2.Response<T> {}

class _FakeHabitDetails_2 extends _i1.Fake implements _i3.HabitDetails {}

class _FakeDateTime_3 extends _i1.Fake implements DateTime {}

/// A class which mocks [HabitsRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockHabitsRepository extends _i1.Mock implements _i3.HabitsRepository {
  MockHabitsRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.Dio get authHttpClient =>
      (super.noSuchMethod(Invocation.getter(#authHttpClient),
          returnValue: _FakeDio_0()) as _i2.Dio);
  @override
  _i3.GetHabitsList get getHabitsList => (super.noSuchMethod(
          Invocation.getter(#getHabitsList),
          returnValue: (_i2.Dio __p0) =>
              Future<_i2.Response<dynamic>>.value(_FakeResponse_1<dynamic>()))
      as _i3.GetHabitsList);
  @override
  _i3.DeleteHabitItem get deleteHabitItem => (super.noSuchMethod(
          Invocation.getter(#deleteHabitItem),
          returnValue: (_i2.Dio __p0, int __p1) =>
              Future<_i2.Response<dynamic>>.value(_FakeResponse_1<dynamic>()))
      as _i3.DeleteHabitItem);
  @override
  _i3.GetHabitDetails get getHabitDetails => (super.noSuchMethod(
          Invocation.getter(#getHabitDetails),
          returnValue: (_i2.Dio __p0, int __p1) =>
              Future<_i2.Response<dynamic>>.value(_FakeResponse_1<dynamic>()))
      as _i3.GetHabitDetails);
  @override
  _i3.PostHabit get postHabit => (super.noSuchMethod(
          Invocation.getter(#postHabit),
          returnValue: (_i2.Dio __p0, String __p1, double __p2, double __p3) =>
              Future<_i2.Response<dynamic>>.value(_FakeResponse_1<dynamic>()))
      as _i3.PostHabit);
  @override
  _i4.Future<List<_i3.HabitListItem>> getHabits() =>
      (super.noSuchMethod(Invocation.method(#getHabits, []),
              returnValue:
                  Future<List<_i3.HabitListItem>>.value(<_i3.HabitListItem>[]))
          as _i4.Future<List<_i3.HabitListItem>>);
  @override
  _i4.Future<_i3.HabitDetails> getHabitsDetails({int? id}) =>
      (super.noSuchMethod(Invocation.method(#getHabitsDetails, [], {#id: id}),
              returnValue:
                  Future<_i3.HabitDetails>.value(_FakeHabitDetails_2()))
          as _i4.Future<_i3.HabitDetails>);
  @override
  _i4.Future<void> deleteHabit({int? id}) =>
      (super.noSuchMethod(Invocation.method(#deleteHabit, [], {#id: id}),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i4.Future<void>);
  @override
  _i4.Future<void> createHabit(
          {String? habitName, double? moneyPerWeek, double? timePerWeek}) =>
      (super.noSuchMethod(
          Invocation.method(#createHabit, [], {
            #habitName: habitName,
            #moneyPerWeek: moneyPerWeek,
            #timePerWeek: timePerWeek
          }),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i4.Future<void>);
}

/// A class which mocks [RelapsesRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockRelapsesRepository extends _i1.Mock
    implements _i5.RelapsesRepository {
  MockRelapsesRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.Dio get authHttpClient =>
      (super.noSuchMethod(Invocation.getter(#authHttpClient),
          returnValue: _FakeDio_0()) as _i2.Dio);
  @override
  _i6.PostAddRelapse get postAddRelapse => (super.noSuchMethod(
          Invocation.getter(#postAddRelapse),
          returnValue: (_i2.Dio __p0, int __p1, String __p2) =>
              Future<_i2.Response<dynamic>>.value(_FakeResponse_1<dynamic>()))
      as _i6.PostAddRelapse);
  @override
  _i4.Future<void> createRelapse({int? habitId, String? reason}) =>
      (super.noSuchMethod(
          Invocation.method(
              #createRelapse, [], {#habitId: habitId, #reason: reason}),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i4.Future<void>);
}

/// A class which mocks [HabitDetails].
///
/// See the documentation for Mockito's code generation for more information.
class MockHabitDetails extends _i1.Mock implements _i3.HabitDetails {
  MockHabitDetails() {
    _i1.throwOnMissingStub(this);
  }

  @override
  List<_i5.Relapse> get relapses =>
      (super.noSuchMethod(Invocation.getter(#relapses),
          returnValue: <_i5.Relapse>[]) as List<_i5.Relapse>);
  @override
  int get id =>
      (super.noSuchMethod(Invocation.getter(#id), returnValue: 0) as int);
  @override
  String get name =>
      (super.noSuchMethod(Invocation.getter(#name), returnValue: '') as String);
  @override
  double get timeSpendWeekly =>
      (super.noSuchMethod(Invocation.getter(#timeSpendWeekly), returnValue: 0.0)
          as double);
  @override
  double get moneySpendWeekly => (super
          .noSuchMethod(Invocation.getter(#moneySpendWeekly), returnValue: 0.0)
      as double);
  @override
  int get days =>
      (super.noSuchMethod(Invocation.getter(#days), returnValue: 0) as int);
  @override
  DateTime get startDate => (super.noSuchMethod(Invocation.getter(#startDate),
      returnValue: _FakeDateTime_3()) as DateTime);
  @override
  double get savedMoney =>
      (super.noSuchMethod(Invocation.getter(#savedMoney), returnValue: 0.0)
          as double);
  @override
  double get savedTime =>
      (super.noSuchMethod(Invocation.getter(#savedTime), returnValue: 0.0)
          as double);
  @override
  Map<String, dynamic> toJson() =>
      (super.noSuchMethod(Invocation.method(#toJson, []),
          returnValue: <String, dynamic>{}) as Map<String, dynamic>);
}

/// A class which mocks [Relapse].
///
/// See the documentation for Mockito's code generation for more information.
class MockRelapse extends _i1.Mock implements _i5.Relapse {
  MockRelapse() {
    _i1.throwOnMissingStub(this);
  }

  @override
  DateTime get dateTime => (super.noSuchMethod(Invocation.getter(#dateTime),
      returnValue: _FakeDateTime_3()) as DateTime);
  @override
  String get reason =>
      (super.noSuchMethod(Invocation.getter(#reason), returnValue: '')
          as String);
  @override
  Map<String, dynamic> toJson() =>
      (super.noSuchMethod(Invocation.method(#toJson, []),
          returnValue: <String, dynamic>{}) as Map<String, dynamic>);
}
