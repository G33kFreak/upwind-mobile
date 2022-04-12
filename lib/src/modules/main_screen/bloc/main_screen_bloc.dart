import 'package:autoequal/autoequal.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'main_screen_bloc.g.dart';
part 'main_screen_event.dart';
part 'main_screen_state.dart';

class MainScreenBloc extends Bloc<MainScreenEvent, MainScreenState> {
  MainScreenBloc() : super(InitState()) {}
}
