import 'package:json_annotation/json_annotation.dart';

part 'reason_dto.g.dart';

@JsonSerializable()
class ReasonDto {
  int reasonId;
  String content;

  ReasonDto({required this.reasonId, required this.content});

  factory ReasonDto.fromJson(Map<String, dynamic> json) =>
      _$ReasonDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ReasonDtoToJson(this);
}
