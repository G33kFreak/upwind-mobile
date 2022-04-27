part of 'main_view_bloc.dart';

abstract class MainViewEvent extends Equatable {
  const MainViewEvent();

  @override
  List<Object?> get props => [];
}

@autoequalMixin
class TurnMainViewMenu extends MainViewEvent
    with _$TurnMainViewMenuAutoequalMixin {
  const TurnMainViewMenu();
}

@autoequalMixin
class LoadHabits extends MainViewEvent with _$LoadHabitsAutoequalMixin {
  const LoadHabits();
}

@autoequalMixin
class DeleteHabit extends MainViewEvent with _$DeleteHabitAutoequalMixin {
  final int habitId;

  const DeleteHabit({required this.habitId});
}
