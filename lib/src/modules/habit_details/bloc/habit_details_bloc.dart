import 'package:autoequal/autoequal.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:upwind/src/repositories/habits_repository/habits_repository.dart';
import 'package:upwind/src/utils/form_status.dart';

part 'habit_details_event.dart';
part 'habit_details_state.dart';
part 'habit_details_bloc.g.dart';

class HabitDetailsBloc extends Bloc<HabitDetailsEvent, HabitDetailsState> {
  final HabitsRepository habitsRepository;

  HabitDetailsBloc({required this.habitsRepository})
      : super(const HabitDetailsState()) {
    on<LoadHabitDetails>(_onLoadDetails);
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
}
