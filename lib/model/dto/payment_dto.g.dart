// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaymentDto _$PaymentDtoFromJson(Map<String, dynamic> json) => PaymentDto(
      id: (json['id'] as num).toInt(),
      amount: (json['amount'] as num).toInt(),
      type: json['type'] as String,
      transactionDate: json['transactionDate'] as String,
    );

Map<String, dynamic> _$PaymentDtoToJson(PaymentDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'amount': instance.amount,
      'type': instance.type,
      'transactionDate': instance.transactionDate,
    };
