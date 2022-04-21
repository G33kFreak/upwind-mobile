import 'package:autoequal/autoequal.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'main_view_event.dart';
part 'main_view_state.dart';
part 'main_view_bloc.g.dart';

class MainViewBloc extends Bloc<MainViewEvent, MainViewState> {
  MainViewBloc() : super(const MainViewState()) {
    on<TurnMainViewMenu>(_onMenuTurned);
  }

  void _onMenuTurned(TurnMainViewMenu event, Emitter<MainViewState> emit) {
    final newMenuStatus = state.menuStatus == MainViewMenuStatus.showed
        ? MainViewMenuStatus.hidden
        : MainViewMenuStatus.showed;

    emit(state.copyWith(menuStatus: newMenuStatus));
  }
}
