import 'package:flutter/material.dart';
import 'package:upwind/src/config/colors.dart';
import 'package:upwind/src/modules/main_view/utils/main_view_utils.dart';

class MainViewCalendarItem extends StatelessWidget {
  final DateTime date;

  const MainViewCalendarItem({
    Key? key,
    required this.date,
  }) : super(key: key);

  bool get isToday => date.day == DateTime.now().day;

  Widget _buildDateText(BuildContext context) {
    return Text(
      date.day.toString(),
      style: Theme.of(context).textTheme.bodyText1?.copyWith(
          color: isToday ? textGrey : Colors.white.withOpacity(0.85)),
    );
  }

  Widget _buildDateTextContainer(BuildContext context) {
    if (!isToday) {
      return _buildDateText(context);
    } else {
      return Container(
        padding: const EdgeInsets.all(4),
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: whiteSnow,
        ),
        child: _buildDateText(context),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8),
        decoration: isToday
            ? const BoxDecoration(
                color: purpleDark,
                borderRadius: BorderRadius.all(Radius.circular(32)),
              )
            : null,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              MainViewUtils.getWeekdayName(date),
              style: Theme.of(context).textTheme.bodyText1?.copyWith(
                  color: isToday ? whiteSnow : whiteSnow.withOpacity(0.65)),
            ),
            const SizedBox(height: 8),
            _buildDateTextContainer(context),
          ],
        ),
      ),
    );
  }
}
