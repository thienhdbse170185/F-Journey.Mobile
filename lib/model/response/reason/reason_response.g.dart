// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reason_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReasonResponse _$ReasonResponseFromJson(Map<String, dynamic> json) =>
    ReasonResponse(
      success: json['success'] as bool,
      result: (json['result'] as List<dynamic>)
          .map((e) => ReasonDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ReasonResponseToJson(ReasonResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'result': instance.result,
    };
