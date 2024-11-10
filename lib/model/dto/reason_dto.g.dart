// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reason_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReasonDto _$ReasonDtoFromJson(Map<String, dynamic> json) => ReasonDto(
      reasonId: (json['reasonId'] as num).toInt(),
      content: json['content'] as String,
    );

Map<String, dynamic> _$ReasonDtoToJson(ReasonDto instance) => <String, dynamic>{
      'reasonId': instance.reasonId,
      'content': instance.content,
    };
