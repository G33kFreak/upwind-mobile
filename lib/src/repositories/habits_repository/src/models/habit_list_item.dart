import 'package:json_annotation/json_annotation.dart';

part 'habit_list_item.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class HabitListItem {
  final int id;
  final String name;
  final double timeSpendWeekly;
  final double moneySpendWeekly;
  final int days;
  final DateTime startDate;
  final double savedMoney;
  final double savedTime;

  HabitListItem({
    required this.id,
    required this.name,
    required this.timeSpendWeekly,
    required this.moneySpendWeekly,
    required this.days,
    required this.startDate,
    required this.savedMoney,
    required this.savedTime,
  });

  factory HabitListItem.fromJson(Map<String, dynamic> json) =>
      _$HabitListItemFromJson(json);

  Map<String, dynamic> toJson() => _$HabitListItemToJson(this);
}
