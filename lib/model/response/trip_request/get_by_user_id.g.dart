// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_by_user_id.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetTripRequestByUserIdResponse _$GetTripRequestByUserIdResponseFromJson(
        Map<String, dynamic> json) =>
    GetTripRequestByUserIdResponse(
      success: json['success'] as bool,
      result: GetTripRequestByUserIdResult.fromJson(
          json['result'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GetTripRequestByUserIdResponseToJson(
        GetTripRequestByUserIdResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'result': instance.result,
    };

GetTripRequestByUserIdResult _$GetTripRequestByUserIdResultFromJson(
        Map<String, dynamic> json) =>
    GetTripRequestByUserIdResult(
      page: (json['page'] as num).toInt(),
      pageSize: (json['pageSize'] as num).toInt(),
      totalItems: (json['totalItems'] as num).toInt(),
      totalPages: (json['totalPages'] as num).toInt(),
      data: (json['data'] as List<dynamic>)
          .map((e) => TripRequestDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetTripRequestByUserIdResultToJson(
        GetTripRequestByUserIdResult instance) =>
    <String, dynamic>{
      'page': instance.page,
      'pageSize': instance.pageSize,
      'totalItems': instance.totalItems,
      'totalPages': instance.totalPages,
      'data': instance.data,
    };
