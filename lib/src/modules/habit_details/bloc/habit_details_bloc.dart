import 'package:autoequal/autoequal.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:upwind/src/modules/habit_details/utils/exceptions.dart';
import 'package:upwind/src/repositories/habits_repository/habits_repository.dart';
import 'package:upwind/src/repositories/relapses_repository/relapses_repository.dart';
import 'package:upwind/src/utils/dio_error_log_extract.dart';
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
      throw _emitErrorState(
        HabitDetailsBlocError.serverError,
        emit,
        convertDioErrorToLogMessage(e),
      );
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
      throw _emitErrorState(
        HabitDetailsBlocError.serverError,
        emit,
        convertDioErrorToLogMessage(e),
      );
    }
  }

  HabitDetailsBlocException _emitErrorState(
    HabitDetailsBlocError error,
    Emitter<HabitDetailsState> emit, [
    dynamic extra,
  ]) {
    emit(state.copyWith(
      relapsesLoadingStatus: const ErrorFormStatus(),
      error: error,
    ));

    final errorText = extra == null ? error.text : '${error.text} $extra';

    return HabitDetailsBlocException(errorText);
  }
}
