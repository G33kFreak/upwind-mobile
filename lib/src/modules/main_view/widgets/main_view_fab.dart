import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:upwind/src/modules/main_view/bloc/main_view_bloc.dart';

class MainViewFab extends StatefulWidget {
  const MainViewFab({Key? key}) : super(key: key);

  @override
  State<MainViewFab> createState() => _MainViewFabState();
}

class _MainViewFabState extends State<MainViewFab>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    super.initState();
  }

  void animateIcon() => controller.forward();

  void reverseIcon() => controller.reverse();

  @override
  Widget build(BuildContext context) {
    return BlocListener<MainViewBloc, MainViewState>(
      listener: (context, state) {
        if (state.menuStatus == MainViewMenuStatus.hidden) {
          reverseIcon();
        } else if (state.menuStatus == MainViewMenuStatus.showed) {
          animateIcon();
        }
      },
      child: FloatingActionButton(
        onPressed: () =>
            context.read<MainViewBloc>().add(const TurnMainViewMenu()),
        child: AnimatedIcon(
          icon: AnimatedIcons.menu_close,
          progress: controller,
        ),
      ),
    );
  }
}
