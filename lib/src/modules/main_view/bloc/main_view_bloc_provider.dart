import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:upwind/src/modules/main_view/bloc/main_view_bloc.dart';

class MainViewBlocProvider extends StatelessWidget {
  final Widget? child;

  const MainViewBlocProvider({Key? key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<MainViewBloc>(
      create: (context) => MainViewBloc(),
      child: child,
    );
  }
}
