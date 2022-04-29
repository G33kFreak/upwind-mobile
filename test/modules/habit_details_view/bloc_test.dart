import 'package:bloc_test/bloc_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:upwind/src/modules/habit_details/bloc/habit_details_bloc.dart';
import 'package:upwind/src/repositories/habits_repository/habits_repository.dart';
import 'package:upwind/src/repositories/relapses_repository/relapses_repository.dart';
import 'package:upwind/src/utils/form_status.dart';

import 'bloc_test.mocks.dart';

@GenerateMocks([HabitsRepository, RelapsesRepository, HabitDetails])
void main() {
  final habitsRepository = MockHabitsRepository();
  final relapsesRepository = MockRelapsesRepository();
  final habitDetails = MockHabitDetails();

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
}
