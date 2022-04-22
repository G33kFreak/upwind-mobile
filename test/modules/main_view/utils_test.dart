import 'package:flutter_test/flutter_test.dart';
import 'package:upwind/src/modules/main_view/utils/main_view_utils.dart';

void main() {
  final testDates = [
    DateTime(2022, DateTime.april, 18),
    DateTime(2022, DateTime.april, 19),
    DateTime(2022, DateTime.april, 20),
    DateTime(2022, DateTime.april, 21),
    DateTime(2022, DateTime.april, 22),
    DateTime(2022, DateTime.april, 23),
    DateTime(2022, DateTime.april, 24),
  ];
  test('getDatesOfWeek() returns correct dates', () {
    for (final date in testDates) {
      expect(MainViewUtils.getDatesOfWeek(date), equals(testDates));
    }
  });
  test('getWeekdayName() returns correct names', () {
    final expectedResults = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];

    for (int i = 0; i < testDates.length; i++) {
      expect(
        MainViewUtils.getWeekdayName(testDates[i]),
        equals(expectedResults[i]),
      );
    }
  });

  test('getProgressValueByTime() returns correct values', () {
    final List<List<DateTime>> testValues = [
      [
        DateTime(2022, DateTime.april, 18, 15),
        DateTime(2022, DateTime.april, 18, 18)
      ],
      [
        DateTime(2022, DateTime.april, 18, 18),
        DateTime(2001, DateTime.april, 18, 6)
      ],
      [
        DateTime(2022, DateTime.april, 18, 0),
        DateTime(2030, DateTime.april, 18, 18)
      ],
      [
        DateTime(2001, DateTime.may, 2, 3),
        DateTime(2030, DateTime.april, 18, 15)
      ],
    ];
    final List<double> expectedValues = [0.875, 0.5, 0.25, 0.5];

    for (int i = 0; i < testValues.length; i++) {
      expect(
        MainViewUtils.getProgressValueByTime(
          testValues[i][0],
          testValues[i][1],
        ),
        equals(expectedValues[i]),
      );
    }
  });
}
