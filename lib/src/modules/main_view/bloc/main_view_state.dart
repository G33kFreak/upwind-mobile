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
  final Report? generatedReport;

  const MainViewState({
    this.menuStatus = MainViewMenuStatus.hidden,
    this.habits = const [],
    this.listLoadingStatus = const LoadingFormStatus(),
    this.error = MainViewBlocError.none,
    this.generatedReport,
  });

  MainViewState copyWith({
    MainViewMenuStatus? menuStatus,
    List<HabitListItem>? habits,
    FormStatus? listLoadingStatus,
    MainViewBlocError? error,
    Report? generatedReport,
  }) =>
      MainViewState(
        menuStatus: menuStatus ?? this.menuStatus,
        habits: habits ?? this.habits,
        listLoadingStatus: listLoadingStatus ?? this.listLoadingStatus,
        error: error ?? this.error,
        generatedReport: generatedReport ?? this.generatedReport,
      );
}

@autoequalMixin
class GeneratingRaportState extends MainViewState
    with _$GeneratingRaportStateAutoequalMixin {
  final MainViewState stateBefore;

  GeneratingRaportState({required this.stateBefore})
      : super(
          habits: stateBefore.habits,
          menuStatus: stateBefore.menuStatus,
          listLoadingStatus: stateBefore.listLoadingStatus,
          error: stateBefore.error,
        );
}
