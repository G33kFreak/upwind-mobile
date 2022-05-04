import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:upwind/src/config/colors.dart';
import 'package:upwind/src/repositories/habits_repository/habits_repository.dart';
import 'package:upwind/src/widgets/m_snackbar.dart';
import 'package:upwind/src/widgets/m_dropdown.dart';
import 'package:upwind/src/widgets/m_input.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AddRelapseDialogResponse {
  final String reason;
  final HabitListItem? habit;

  const AddRelapseDialogResponse({required this.reason, this.habit});
}

Future<AddRelapseDialogResponse?> showAddRelapseDialog(
  BuildContext context, {
  List<HabitListItem>? habits,
}) async {
  final relapseReason = await showAnimatedDialog<AddRelapseDialogResponse?>(
    context: context,
    barrierDismissible: true,
    animationType: DialogTransitionType.slideFromBottomFade,
    curve: Curves.easeInOutCubicEmphasized,
    builder: (context) => Dialog(
      child: AddRelapseDialog(habits: habits),
    ),
  );

  return relapseReason;
}

class AddRelapseDialog extends StatefulWidget {
  final List<HabitListItem>? habits;

  const AddRelapseDialog({
    Key? key,
    this.habits,
  }) : super(key: key);

  @override
  State<AddRelapseDialog> createState() => _AddRelapseDialogState();
}

class _AddRelapseDialogState extends State<AddRelapseDialog> {
  String reason = '';
  HabitListItem? _selectedHabit;

  @override
  void initState() {
    _selectedHabit = widget.habits != null ? widget.habits!.first : null;
    super.initState();
  }

  void _onHabitSelected(HabitListItem? newSelectedHabit) {
    if (newSelectedHabit != null && newSelectedHabit != _selectedHabit) {
      setState(() {
        _selectedHabit = newSelectedHabit;
      });
    }
  }

  void _onReasonChanged(String newValue) {
    reason = newValue;
  }

  void _onSavePressed() {
    if (reason.isEmpty) {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: MSnackbar(
            text: AppLocalizations.of(context)!.reasonEmptyError,
          ),
        ),
      );
    }
    if (reason.isNotEmpty) {
      context.router.pop<AddRelapseDialogResponse>(
        AddRelapseDialogResponse(reason: reason, habit: _selectedHabit),
      );
    } else {
      context.router.pop();
    }
  }

  Widget _dropdownItemBuilder(HabitListItem habit) => Text(
        habit.name,
        style: Theme.of(context).textTheme.bodyText2,
      );

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            AppLocalizations.of(context)!.addRelapse,
            style: Theme.of(context).textTheme.headline6,
          ),
          const SizedBox(height: 20),
          MInput(
            hintText: AppLocalizations.of(context)!.writeReason,
            onChanged: _onReasonChanged,
          ),
          const SizedBox(height: 8),
          Text(
            AppLocalizations.of(context)!.addingRelapseDesc,
          ),
          const SizedBox(height: 8),
          if (widget.habits != null)
            MDropdown<HabitListItem>(
              items: widget.habits!,
              onItemSelected: _onHabitSelected,
              itemBuilder: _dropdownItemBuilder,
            ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: _onSavePressed,
            child: Text(
              AppLocalizations.of(context)!.save,
              style: Theme.of(context)
                  .textTheme
                  .bodyText2
                  ?.copyWith(color: whiteSnow),
            ),
          )
        ],
      ),
    );
  }
}
