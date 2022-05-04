import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:upwind/src/modules/habit_details/widgets/add_relapse_dialog.dart';
import 'package:upwind/src/modules/main_view/bloc/main_view_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:upwind/src/modules/main_view/widgets/menu/main_view_menu_item.dart';
import 'package:upwind/src/repositories/habits_repository/habits_repository.dart';

class MainMenuItems extends StatefulWidget {
  const MainMenuItems({Key? key}) : super(key: key);

  @override
  State<MainMenuItems> createState() => _MainMenuItemsState();
}

class _MainMenuItemsState extends State<MainMenuItems>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late CurvedAnimation _curvedAnimation;

  @override
  void initState() {
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
      lowerBound: 0,
    );
    _curvedAnimation = CurvedAnimation(
      parent: animationController,
      curve: Curves.easeInOutCubicEmphasized,
    );
    super.initState();
  }

  void animateMenuItems() => animationController.forward();

  void reverseMenuItems() => animationController.reverse();

  Offset getTransitionOffset(BuildContext context) {
    final animationSize = MediaQuery.of(context).size.height * .5;
    final yOffset = animationSize - (animationSize * _curvedAnimation.value);
    return Offset(0, yOffset);
  }

  void _onAddRelapsePressed(List<HabitListItem> habits) async {
    context.read<MainViewBloc>().add(const TurnMainViewMenu());
    final response = await showAddRelapseDialog(context, habits: habits);
    if (response != null && response.habit != null) {
      context.read<MainViewBloc>().add(AddRelapseToHabit(
          reason: response.reason, habitId: response.habit!.id));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<MainViewBloc, MainViewState>(
      listener: (context, state) {
        if (state.menuStatus == MainViewMenuStatus.showed) {
          animateMenuItems();
        } else if (state.menuStatus == MainViewMenuStatus.hidden) {
          reverseMenuItems();
        }
      },
      child: AnimatedBuilder(
        animation: animationController,
        builder: (context, child) => Transform.translate(
          offset: getTransitionOffset(context),
          child: child,
        ),
        child: BlocBuilder<MainViewBloc, MainViewState>(
          builder: (context, state) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                MainViewMenuItem(
                  icon: Icons.info_rounded,
                  title: AppLocalizations.of(context)!.showRaport,
                  onPressed: () {},
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    MainViewMenuItem(
                      icon: Icons.message,
                      title: AppLocalizations.of(context)!.newRelapse,
                      onPressed: () => _onAddRelapsePressed(state.habits),
                    ),
                    const SizedBox(width: 24),
                    MainViewMenuItem(
                      icon: Icons.add_box_rounded,
                      title: AppLocalizations.of(context)!.newHabit,
                      onPressed: () {},
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
