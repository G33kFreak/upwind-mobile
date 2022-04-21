import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:upwind/src/config/colors.dart';
import 'package:upwind/src/modules/main_view/bloc/main_view_bloc.dart';
import 'package:upwind/src/modules/main_view/widgets/main_menu_items.dart';

class MainViewMenu extends StatelessWidget {
  const MainViewMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainViewBloc, MainViewState>(
      builder: (context, state) {
        return IgnorePointer(
          ignoring: state.menuStatus == MainViewMenuStatus.hidden,
          child: AnimatedOpacity(
            duration: const Duration(milliseconds: 200),
            opacity: state.menuStatus == MainViewMenuStatus.showed ? 1 : 0,
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 2.5, sigmaY: 2.5),
              child: Container(
                height: double.infinity,
                width: double.infinity,
                color: whiteSnow.withOpacity(0.5),
                child: const SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 90, right: 20),
                    child: MainMenuItems(),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
