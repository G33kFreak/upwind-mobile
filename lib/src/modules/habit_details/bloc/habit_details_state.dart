part of 'habit_details_bloc.dart';

@autoequalMixin
class HabitDetailsState extends Equatable
    with _$HabitDetailsStateAutoequalMixin {
  final HabitDetails? habitDetails;
  final FormStatus relapsesLoadingStatus;

  const HabitDetailsState({
    this.habitDetails,
    this.relapsesLoadingStatus = const LoadingFormStatus(),
  });

  HabitDetailsState copyWith({
    HabitDetails? habitDetails,
    FormStatus? relapsesLoadingStatus,
  }) =>
      HabitDetailsState(
        habitDetails: habitDetails ?? this.habitDetails,
        relapsesLoadingStatus:
            relapsesLoadingStatus ?? this.relapsesLoadingStatus,
      );
}
