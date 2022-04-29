import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:upwind/src/config/colors.dart';
import 'package:upwind/src/modules/habit_details/bloc/habit_details_bloc.dart';
import 'package:upwind/src/modules/habit_details/widgets/add_relapse_dialog.dart';

class RelapsesTitleAndButton extends StatelessWidget {
  const RelapsesTitleAndButton({Key? key}) : super(key: key);

  Future<void> _onAddRelapsePressed(BuildContext context) async {
    final reason = await showAddRelapseDialog(context);

    if (reason != null && reason.isNotEmpty) {
      context.read<HabitDetailsBloc>().add(AddRelapseToHabit(reason: reason));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          AppLocalizations.of(context)!.relapses,
          style: Theme.of(context).textTheme.headline6,
        ),
        const SizedBox(width: 4),
        ElevatedButton(
          onPressed: () => _onAddRelapsePressed(context),
          style: ElevatedButton.styleFrom(
            shape: const CircleBorder(),
          ),
          child: const Icon(
            Icons.add,
            color: whiteSnow,
            size: 20,
          ),
        )
      ],
    );
  }
}
