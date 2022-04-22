part of 'main_view_bloc.dart';

enum MainViewMenuStatus {
  hidden,
  showed,
}

@autoequalMixin
class MainViewState extends Equatable with _$MainViewStateAutoequalMixin {
  final MainViewMenuStatus menuStatus;
  final List<HabitListItem> habits;
  final FormStatus listLoadingStatus;
  final MainViewBlocError error;

  const MainViewState({
    this.menuStatus = MainViewMenuStatus.hidden,
    this.habits = const [],
    this.listLoadingStatus = const LoadingFormStatus(),
    this.error = MainViewBlocError.none,
  });

  MainViewState copyWith({
    MainViewMenuStatus? menuStatus,
    List<HabitListItem>? habits,
    FormStatus? listLoadingStatus,
    MainViewBlocError? error,
  }) =>
      MainViewState(
        menuStatus: menuStatus ?? this.menuStatus,
        habits: habits ?? this.habits,
        listLoadingStatus: listLoadingStatus ?? this.listLoadingStatus,
        error: error ?? this.error,
      );
}
