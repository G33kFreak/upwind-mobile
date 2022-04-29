import 'package:json_annotation/json_annotation.dart';

part 'relapse.g.dart';

@JsonSerializable()
class Relapse {
  @JsonKey(name: 'datetime')
  final DateTime dateTime;
  final String reason;

  Relapse({required this.dateTime, required this.reason});

  factory Relapse.fromJson(Map<String, dynamic> json) =>
      _$RelapseFromJson(json);

  Map<String, dynamic> toJson() => _$RelapseToJson(this);
}
