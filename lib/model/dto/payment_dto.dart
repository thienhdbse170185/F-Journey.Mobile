import 'package:json_annotation/json_annotation.dart';

part 'payment_dto.g.dart';

@JsonSerializable()
class PaymentDto {
  int id;
  int amount;
  String type;
  String transactionDate;

  PaymentDto({
    required this.id,
    required this.amount,
    required this.type,
    required this.transactionDate,
  });

  factory PaymentDto.fromJson(Map<String, dynamic> json) =>
      _$PaymentDtoFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentDtoToJson(this);
}
