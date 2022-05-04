import 'package:bloc_test/bloc_test.dart';
import 'package:dio/dio.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:upwind/src/modules/habit_details/bloc/habit_details_bloc.dart';
import 'package:upwind/src/modules/habit_details/utils/exceptions.dart';
import 'package:upwind/src/repositories/habits_repository/habits_repository.dart';
import 'package:upwind/src/repositories/relapses_repository/relapses_repository.dart';
import 'package:upwind/src/utils/dio_error_log_extract.dart';
import 'package:upwind/src/utils/form_status.dart';

import 'bloc_test.mocks.dart';

class MockRelapseExtended extends MockRelapse {
  final int id;

  MockRelapseExtended({required this.id});
}

class MockHabitDetailsExtended extends MockHabitDetails {
  final List<MockRelapseExtended> _relapses;
  final int _id;

  MockHabitDetailsExtended({
    required List<MockRelapseExtended> relapses,
    required int id,
  })  : _relapses = relapses,
        _id = id;

  @override
  List<Relapse> get relapses => _relapses;

  @override
  int get id => _id;
}

@GenerateMocks([HabitsRepository, RelapsesRepository, HabitDetails, Relapse])
void main() {
  final habitsRepository = MockHabitsRepository();
  final relapsesRepository = MockRelapsesRepository();
  final habitDetails = MockHabitDetails();
  final dioError = DioError(requestOptions: RequestOptions(path: ''));

  blocTest<HabitDetailsBloc, HabitDetailsState>(
    'HabitDetailsView loads habits details ok',
    setUp: () {
      when(habitsRepository.getHabitsDetails(id: anyNamed('id')))
          .thenAnswer((_) => Future.value(habitDetails));
    },
    build: () => HabitDetailsBloc(
      habitsRepository: habitsRepository,
      relapsesRepository: relapsesRepository,
    ),
    act: (bloc) => bloc.add(const LoadHabitDetails(habitId: 1)),
    expect: () => <HabitDetailsState>[
      HabitDetailsState(
        habitDetails: habitDetails,
        relapsesLoadingStatus: const SuccessFormStatus(),
      ),
    ],
  );

  final List<MockRelapseExtended> relapses =
      List.generate(3, (index) => MockRelapseExtended(id: index));
  final MockHabitDetailsExtended habitDetailsBeforeAdding =
      MockHabitDetailsExtended(relapses: relapses, id: 2);
  final MockHabitDetailsExtended habitDetailsAfterAdding =
      MockHabitDetailsExtended(
          id: 2,
          relapses: List.from(relapses)..add(MockRelapseExtended(id: 3)));
  blocTest<HabitDetailsBloc, HabitDetailsState>(
    'HabitDetailsView adding relapse ok',
    setUp: () {
      when(habitsRepository.getHabitsDetails(id: 1))
          .thenAnswer((_) => Future.value(habitDetailsBeforeAdding));
      when(habitsRepository.getHabitsDetails(id: 2))
          .thenAnswer((_) => Future.value(habitDetailsAfterAdding));
      when(relapsesRepository.createRelapse(
        habitId: anyNamed('habitId'),
        reason: anyNamed('reason'),
      )).thenAnswer((_) => Future.value());
    },
    build: () => HabitDetailsBloc(
      habitsRepository: habitsRepository,
      relapsesRepository: relapsesRepository,
    ),
    act: (bloc) => bloc
      ..add(const LoadHabitDetails(habitId: 1))
      ..add(const AddRelapseToHabit(reason: '')),
    expect: () => <HabitDetailsState>[
      HabitDetailsState(
        habitDetails: habitDetailsBeforeAdding,
        relapsesLoadingStatus: const SuccessFormStatus(),
      ),
      HabitDetailsState(
        habitDetails: habitDetailsBeforeAdding,
        relapsesLoadingStatus: const LoadingFormStatus(),
      ),
      HabitDetailsState(
        habitDetails: habitDetailsAfterAdding,
        relapsesLoadingStatus: const SuccessFormStatus(),
      ),
    ],
  );

  blocTest<HabitDetailsBloc, HabitDetailsState>(
    'HabitDetailsView loads habits details DioError',
    setUp: () {
      when(habitsRepository.getHabitsDetails(id: anyNamed('id')))
          .thenThrow(dioError);
    },
    build: () => HabitDetailsBloc(
      habitsRepository: habitsRepository,
      relapsesRepository: relapsesRepository,
    ),
    act: (bloc) => bloc.add(const LoadHabitDetails(habitId: 1)),
    errors: () => [
      HabitDetailsBlocException(
        '${HabitDetailsBlocError.serverError.text} ${convertDioErrorToLogMessage(dioError)}',
      ),
    ],
    expect: () => const <HabitDetailsState>[
      HabitDetailsState(
        error: HabitDetailsBlocError.serverError,
        relapsesLoadingStatus: ErrorFormStatus(),
      ),
    ],
  );

  blocTest<HabitDetailsBloc, HabitDetailsState>(
    'HabitDetailsView adding relapse DioError',
    setUp: () {
      when(habitsRepository.getHabitsDetails(id: anyNamed('id')))
          .thenAnswer((_) => Future.value(habitDetailsBeforeAdding));
      when(relapsesRepository.createRelapse(
              habitId: anyNamed('habitId'), reason: anyNamed('reason')))
          .thenThrow(dioError);
    },
    build: () => HabitDetailsBloc(
      habitsRepository: habitsRepository,
      relapsesRepository: relapsesRepository,
    ),
    act: (bloc) => bloc
      ..add(const LoadHabitDetails(habitId: 1))
      ..add(const AddRelapseToHabit(reason: '')),
    errors: () => [
      HabitDetailsBlocException(
        '${HabitDetailsBlocError.serverError.text} ${convertDioErrorToLogMessage(dioError)}',
      ),
    ],
    expect: () => <HabitDetailsState>[
      HabitDetailsState(
        habitDetails: habitDetailsBeforeAdding,
        relapsesLoadingStatus: const SuccessFormStatus(),
      ),
      HabitDetailsState(
        habitDetails: habitDetailsBeforeAdding,
        relapsesLoadingStatus: const LoadingFormStatus(),
      ),
      HabitDetailsState(
        habitDetails: habitDetailsBeforeAdding,
        relapsesLoadingStatus: const ErrorFormStatus(),
        error: HabitDetailsBlocError.serverError,
      )
    ],
  );
}
