import 'package:upwind/src/repositories/habits_repository/src/models/habit_list_item.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:upwind/src/repositories/relapses_repository/src/models/relapse.dart';

part 'habit_details.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class HabitDetails extends HabitListItem {
  final List<Relapse> relapses;

  HabitDetails({
    required int id,
    required String name,
    required double timeSpendWeekly,
    required double moneySpendWeekly,
    required int days,
    required DateTime startDate,
    required double savedMoney,
    required double savedTime,
    required this.relapses,
  }) : super(
          id: id,
          name: name,
          timeSpendWeekly: timeSpendWeekly,
          moneySpendWeekly: moneySpendWeekly,
          days: days,
          startDate: startDate,
          savedMoney: savedMoney,
          savedTime: savedTime,
        );

  factory HabitDetails.fromJson(Map<String, dynamic> json) =>
      _$HabitDetailsFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$HabitDetailsToJson(this);
}
