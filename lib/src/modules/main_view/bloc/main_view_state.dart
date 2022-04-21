part of 'main_view_bloc.dart';

enum MainViewMenuStatus {
  hidden,
  showed,
}

@autoequalMixin
class MainViewState extends Equatable with _$MainViewStateAutoequalMixin {
  final MainViewMenuStatus menuStatus;

  const MainViewState({
    this.menuStatus = MainViewMenuStatus.hidden,
  });

  MainViewState copyWith({MainViewMenuStatus? menuStatus}) => MainViewState(
        menuStatus: menuStatus ?? this.menuStatus,
      );
}
