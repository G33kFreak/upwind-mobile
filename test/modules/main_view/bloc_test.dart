import 'package:bloc_test/bloc_test.dart';
import 'package:dio/dio.dart';
import 'package:http_status_code/http_status_code.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:upwind/src/modules/main_view/bloc/main_view_bloc.dart';
import 'package:upwind/src/modules/main_view/utils/exceptions.dart';
import 'package:upwind/src/repositories/habits_repository/habits_repository.dart';
import 'package:upwind/src/repositories/relapses_repository/relapses_repository.dart';
import 'package:upwind/src/utils/dio_error_log_extract.dart';
import 'package:upwind/src/utils/form_status.dart';

import 'bloc_test.mocks.dart';

class TestHabitListItem extends MockHabitListItem {
  final int _id;

  TestHabitListItem(int id) : _id = id;

  @override
  int get id => _id;
}

@GenerateMocks([HabitsRepository, HabitListItem, RelapsesRepository])
void main() {
  final habitsRepository = MockHabitsRepository();
  final relapsesRepository = MockRelapsesRepository();
  final habits = List.generate(10, (index) => TestHabitListItem(index));
  final dioError = DioError(
    requestOptions: RequestOptions(path: 'Test'),
    response: Response(
      requestOptions: RequestOptions(path: 'Test'),
      statusCode: StatusCode.INTERNAL_SERVER_ERROR,
    ),
  );

  blocTest<MainViewBloc, MainViewState>(
    'MainView loading habits ok',
    setUp: () {
      when(habitsRepository.getHabits())
          .thenAnswer((_) => Future.value(habits));
    },
    build: () => MainViewBloc(
      habitsRepository: habitsRepository,
      relapsesRepository: relapsesRepository,
    ),
    act: (bloc) => bloc.add(const LoadHabits()),
    expect: () => <MainViewState>[
      MainViewState(
        listLoadingStatus: const SuccessFormStatus(),
        habits: habits,
      )
    ],
  );

  blocTest<MainViewBloc, MainViewState>(
    'MainView turning menu ok',
    build: () => MainViewBloc(
      habitsRepository: habitsRepository,
      relapsesRepository: relapsesRepository,
    ),
    act: (bloc) => bloc
      ..add(const TurnMainViewMenu())
      ..add(const TurnMainViewMenu())
      ..add(const TurnMainViewMenu()),
    expect: () => const <MainViewState>[
      MainViewState(menuStatus: MainViewMenuStatus.showed),
      MainViewState(menuStatus: MainViewMenuStatus.hidden),
      MainViewState(menuStatus: MainViewMenuStatus.showed),
    ],
  );

  blocTest<MainViewBloc, MainViewState>(
    'MainView deleting items ok',
    setUp: () {
      when(habitsRepository.getHabits())
          .thenAnswer((_) => Future.value(habits));
      when(habitsRepository.deleteHabit(id: anyNamed('id')))
          .thenAnswer((_) => Future.value());
    },
    build: () {
      final bloc = MainViewBloc(
        habitsRepository: habitsRepository,
        relapsesRepository: relapsesRepository,
      );
      bloc.add(const LoadHabits());
      return bloc;
    },
    act: (bloc) => bloc
      ..add(const DeleteHabit(habitId: 5))
      ..add(const DeleteHabit(habitId: 2)),
    expect: () => <MainViewState>[
      MainViewState(
        listLoadingStatus: const SuccessFormStatus(),
        habits: habits,
      ),
      MainViewState(
        listLoadingStatus: const SuccessFormStatus(),
        habits: List.from(habits)..removeWhere((habit) => habit.id == 5),
      ),
      MainViewState(
        listLoadingStatus: const SuccessFormStatus(),
        habits: List.from(habits)
          ..removeWhere((habit) => habit.id == 2 || habit.id == 5),
      )
    ],
  );

  blocTest<MainViewBloc, MainViewState>(
    'MainView loading items DioError',
    setUp: () {
      when(habitsRepository.getHabits()).thenThrow(dioError);
    },
    build: () => MainViewBloc(
      habitsRepository: habitsRepository,
      relapsesRepository: relapsesRepository,
    ),
    act: (bloc) => bloc.add(const LoadHabits()),
    errors: () => [
      MainViewBlocException(
        '${MainViewBlocError.serverError.text} ${convertDioErrorToLogMessage(dioError)}',
      )
    ],
    expect: () => const <MainViewState>[
      MainViewState(
        listLoadingStatus: ErrorFormStatus(),
        error: MainViewBlocError.serverError,
      )
    ],
  );

  blocTest<MainViewBloc, MainViewState>(
    'MainView deleting items DioError',
    setUp: () {
      when(habitsRepository.getHabits())
          .thenAnswer((_) => Future.value(habits));
      when(habitsRepository.deleteHabit(id: anyNamed('id')))
          .thenThrow(dioError);
    },
    build: () => MainViewBloc(
      habitsRepository: habitsRepository,
      relapsesRepository: relapsesRepository,
    ),
    act: (bloc) => bloc
      ..add(const LoadHabits())
      ..add(const DeleteHabit(habitId: 2)),
    errors: () => [
      MainViewBlocException(
        '${MainViewBlocError.serverError.text} ${convertDioErrorToLogMessage(dioError)}',
      )
    ],
    expect: () => <MainViewState>[
      MainViewState(
        listLoadingStatus: const SuccessFormStatus(),
        habits: habits,
      ),
      MainViewState(
        listLoadingStatus: const SuccessFormStatus(),
        habits: List.from(habits)..removeWhere((habit) => habit.id == 2),
      ),
      MainViewState(
        listLoadingStatus: const SuccessFormStatus(),
        habits: habits,
      ),
      MainViewState(
        habits: habits,
        listLoadingStatus: const ErrorFormStatus(),
        error: MainViewBlocError.serverError,
      )
    ],
  );

  final habitsAfterAdding =
      List<TestHabitListItem>.from([...habits, TestHabitListItem(10)]);
  blocTest<MainViewBloc, MainViewState>(
    'MainView adding habit ok',
    setUp: () {
      int requestCounter = 0;
      when(habitsRepository.getHabits()).thenAnswer((_) {
        if (requestCounter == 0) {
          requestCounter++;
          return Future.value(habits);
        } else {
          return Future.value(habitsAfterAdding);
        }
      });
      when(habitsRepository.createHabit(
        habitName: 'test',
        moneyPerWeek: 1,
        timePerWeek: 1,
      )).thenAnswer((_) => Future.value());
    },
    build: () => MainViewBloc(
      habitsRepository: habitsRepository,
      relapsesRepository: relapsesRepository,
    ),
    act: (bloc) => bloc
      ..add(const LoadHabits())
      ..add(
        const AddHabit(
          habitTitle: 'test',
          moneyPerWeek: 1,
          timePerWeek: 1,
        ),
      ),
    expect: () => <MainViewState>[
      MainViewState(
        listLoadingStatus: const SuccessFormStatus(),
        habits: habits,
      ),
      MainViewState(
        listLoadingStatus: const LoadingFormStatus(),
        habits: habits,
      ),
      MainViewState(
        listLoadingStatus: const SuccessFormStatus(),
        habits: habitsAfterAdding,
      )
    ],
  );
}
