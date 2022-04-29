import 'package:autoequal/autoequal.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:upwind/src/repositories/habits_repository/habits_repository.dart';
import 'package:upwind/src/repositories/relapses_repository/relapses_repository.dart';
import 'package:upwind/src/utils/form_status.dart';

part 'habit_details_event.dart';
part 'habit_details_state.dart';
part 'habit_details_bloc.g.dart';

class HabitDetailsBloc extends Bloc<HabitDetailsEvent, HabitDetailsState> {
  final HabitsRepository habitsRepository;
  final IRelapsesRepository relapsesRepository;

  HabitDetailsBloc({
    required this.habitsRepository,
    required this.relapsesRepository,
  }) : super(const HabitDetailsState()) {
    on<LoadHabitDetails>(_onLoadDetails);
    on<AddRelapseToHabit>(_onAddRelapse);
  }

  Future<void> _onLoadDetails(
    LoadHabitDetails event,
    Emitter<HabitDetailsState> emit,
  ) async {
    try {
      final habitDetails = await habitsRepository.getHabitsDetails(
        id: event.habitId,
      );

      emit(state.copyWith(
        habitDetails: habitDetails,
        relapsesLoadingStatus: const SuccessFormStatus(),
      ));
    } on DioError catch (e) {
      print(e);
    }
  }

  Future<void> _onAddRelapse(
    AddRelapseToHabit event,
    Emitter<HabitDetailsState> emit,
  ) async {
    emit(state.copyWith(relapsesLoadingStatus: const LoadingFormStatus()));
    try {
      await relapsesRepository.createRelapse(
        habitId: state.habitDetails!.id,
        reason: event.reason,
      );
      add(LoadHabitDetails(habitId: state.habitDetails!.id));
    } on DioError catch (e) {
      print(e);
    }
  }
}
