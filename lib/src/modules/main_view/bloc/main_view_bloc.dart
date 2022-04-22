import 'package:autoequal/autoequal.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:upwind/src/modules/main_view/utils/exceptions.dart';
import 'package:upwind/src/repositories/habits_repository/habits_repository.dart';
import 'package:upwind/src/utils/dio_error_log_extract.dart';
import 'package:upwind/src/utils/form_status.dart';

part 'main_view_event.dart';
part 'main_view_state.dart';
part 'main_view_bloc.g.dart';

class MainViewBloc extends Bloc<MainViewEvent, MainViewState> {
  final IHabitsRepository habitsRepository;

  MainViewBloc({
    required this.habitsRepository,
  }) : super(const MainViewState()) {
    on<TurnMainViewMenu>(_onMenuTurned);
    on<LoadHabits>(_onLoadHabits);
  }

  void _onMenuTurned(TurnMainViewMenu event, Emitter<MainViewState> emit) {
    final newMenuStatus = state.menuStatus == MainViewMenuStatus.showed
        ? MainViewMenuStatus.hidden
        : MainViewMenuStatus.showed;

    emit(state.copyWith(menuStatus: newMenuStatus));
  }

  Future<void> _onLoadHabits(
    LoadHabits event,
    Emitter<MainViewState> emit,
  ) async {
    try {
      final habits = await habitsRepository.getHabits();

      emit(state.copyWith(
        listLoadingStatus: const SuccessFormStatus(),
        habits: habits,
      ));
    } on DioError catch (e) {
      throw _emitErrorState(
        MainViewBlocError.serverError,
        emit,
        convertDioErrorToLogMessage(e),
      );
    }
  }

  MainViewBlocException _emitErrorState(
    MainViewBlocError error,
    Emitter<MainViewState> emit, [
    dynamic extra,
  ]) {
    emit(state.copyWith(
      listLoadingStatus: const ErrorFormStatus(),
      error: error,
    ));

    final errorText = extra == null ? error.text : '${error.text} $extra';

    return MainViewBlocException(errorText);
  }
}
