part of 'habit_details_bloc.dart';

@autoequalMixin
class HabitDetailsState extends Equatable
    with _$HabitDetailsStateAutoequalMixin {
  final HabitDetails? habitDetails;
  final FormStatus relapsesLoadingStatus;
  final HabitDetailsBlocError error;

  const HabitDetailsState({
    this.habitDetails,
    this.relapsesLoadingStatus = const LoadingFormStatus(),
    this.error = HabitDetailsBlocError.none,
  });

  HabitDetailsState copyWith({
    HabitDetails? habitDetails,
    FormStatus? relapsesLoadingStatus,
    HabitDetailsBlocError? error,
  }) =>
      HabitDetailsState(
        habitDetails: habitDetails ?? this.habitDetails,
        relapsesLoadingStatus:
            relapsesLoadingStatus ?? this.relapsesLoadingStatus,
        error: error ?? this.error,
      );
}
