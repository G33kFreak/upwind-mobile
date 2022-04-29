import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:upwind/src/config/colors.dart';
import 'package:upwind/src/widgets/m_input.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

Future<String?> showAddRelapseDialog(BuildContext context) async {
  final relapseReason = await showAnimatedDialog<String?>(
    context: context,
    barrierDismissible: true,
    animationType: DialogTransitionType.slideFromBottomFade,
    curve: Curves.easeInOutCubicEmphasized,
    builder: (context) => const Dialog(
      child: AddRelapseDialog(),
    ),
  );

  return relapseReason;
}

class AddRelapseDialog extends StatefulWidget {
  const AddRelapseDialog({Key? key}) : super(key: key);

  @override
  State<AddRelapseDialog> createState() => _AddRelapseDialogState();
}

class _AddRelapseDialogState extends State<AddRelapseDialog> {
  String reason = '';

  void _onReasonChanged(String newValue) {
    reason = newValue;
  }

  void _onSavePressed() {
    context.router.pop(reason.isNotEmpty ? reason : null);
  }

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
          const SizedBox(height: 24),
          //TODO: Add snackbar for empty reason
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
