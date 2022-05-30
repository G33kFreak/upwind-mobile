import 'package:json_annotation/json_annotation.dart';
import 'package:upwind/src/repositories/relapses_repository/relapses_repository.dart';

part 'report.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Report {
  final DateTime dateStart;
  final DateTime dateEnd;
  final List<Relapse> reasonsToAvoid;
  final double percentage;
  final Map<String, int> weekdaysReport;

  Report({
    required this.dateStart,
    required this.dateEnd,
    required this.reasonsToAvoid,
    required this.percentage,
    required this.weekdaysReport,
  });

  factory Report.fromJson(Map<String, dynamic> json) => _$ReportFromJson(json);

  Map<String, dynamic> toJson() => _$ReportToJson(this);
}
