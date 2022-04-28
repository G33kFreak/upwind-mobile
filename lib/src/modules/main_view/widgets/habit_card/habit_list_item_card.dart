import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:upwind/src/config/colors.dart';
import 'package:upwind/src/modules/main_view/bloc/main_view_bloc.dart';
import 'package:upwind/src/modules/main_view/widgets/habit_card/habit_card_content.dart';
import 'package:upwind/src/modules/main_view/widgets/habit_card/habit_progress_indicator.dart';
import 'package:upwind/src/repositories/habits_repository/habits_repository.dart';

class HabitListItemCard extends StatefulWidget {
  final HabitListItem habit;

  const HabitListItemCard({
    Key? key,
    required this.habit,
  }) : super(key: key);

  @override
  State<HabitListItemCard> createState() => _HabitListItemCardState();
}

class _HabitListItemCardState extends State<HabitListItemCard> {
  bool _isDeleteButtonOpen = false;

  void _turnDeleteButton() {
    setState(() {
      _isDeleteButtonOpen = !_isDeleteButtonOpen;
    });
  }

  void _onDeletePressed() {
    _turnDeleteButton();
    context.read<MainViewBloc>().add(DeleteHabit(habitId: widget.habit.id));
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      color: whiteSnow,
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: _isDeleteButtonOpen ? null : () {},
        onLongPress: _isDeleteButtonOpen ? null : _turnDeleteButton,
        child: SizedBox(
          width: double.infinity,
          height: 136,
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    HabitProgressIndicator(
                      days: widget.habit.days,
                      timeStart: widget.habit.startDate,
                    ),
                    const Spacer(),
                    HabitCardContent(habit: widget.habit),
                  ],
                ),
              ),
              IgnorePointer(
                ignoring: !_isDeleteButtonOpen,
                child: AnimatedOpacity(
                  opacity: _isDeleteButtonOpen ? 1 : 0,
                  duration: const Duration(milliseconds: 150),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 2.5, sigmaY: 2.5),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: purpleDark.withOpacity(0.65),
                      ),
                      width: double.infinity,
                      height: double.infinity,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          IconButton(
                            onPressed: _onDeletePressed,
                            iconSize: 48,
                            icon: const Icon(
                              Icons.delete_forever_rounded,
                              color: whiteSnow,
                            ),
                          ),
                          IconButton(
                            onPressed: _turnDeleteButton,
                            iconSize: 48,
                            icon: const Icon(
                              Icons.close_rounded,
                              color: whiteSnow,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
