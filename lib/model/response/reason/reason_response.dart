import 'package:f_journey/model/dto/reason_dto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'reason_response.g.dart';

@JsonSerializable()
class ReasonResponse {
  bool success;
  List<ReasonDto> result;

  ReasonResponse({required this.success, required this.result});

  factory ReasonResponse.fromJson(Map<String, dynamic> json) =>
      _$ReasonResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ReasonResponseToJson(this);
}
