part of 'habit_details_bloc.dart';

abstract class HabitDetailsEvent extends Equatable {
  const HabitDetailsEvent();

  @override
  List<Object?> get props => [];
}

@autoequalMixin
class LoadHabitDetails extends HabitDetailsEvent
    with _$LoadHabitDetailsAutoequalMixin {
  final int habitId;

  const LoadHabitDetails({required this.habitId});
}

@autoequalMixin
class AddRelapseToHabit extends HabitDetailsEvent
    with _$AddRelapseToHabitAutoequalMixin {
  final String reason;

  const AddRelapseToHabit({required this.reason});
}
