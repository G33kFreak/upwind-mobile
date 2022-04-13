import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'tokens.g.dart';

@HiveType(typeId: 0)
@JsonSerializable(fieldRename: FieldRename.snake)
class Tokens extends HiveObject {
  @HiveField(0)
  final String accessToken;
  @HiveField(1)
  final String refreshToken;

  Tokens({required this.accessToken, required this.refreshToken});

  factory Tokens.fromJson(Map<String, dynamic> json) => _$TokensFromJson(json);

  Map<String, dynamic> toJson() => _$TokensToJson(this);
}
