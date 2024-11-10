// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_trip_match_by_user_id_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetTripMatchByUserIdResponse _$GetTripMatchByUserIdResponseFromJson(
        Map<String, dynamic> json) =>
    GetTripMatchByUserIdResponse(
      success: json['success'] as bool,
      result: GetTripMatchByUserIdResult.fromJson(
          json['result'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GetTripMatchByUserIdResponseToJson(
        GetTripMatchByUserIdResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'result': instance.result,
    };

GetTripMatchByUserIdResult _$GetTripMatchByUserIdResultFromJson(
        Map<String, dynamic> json) =>
    GetTripMatchByUserIdResult(
      page: (json['page'] as num).toInt(),
      pageSize: (json['pageSize'] as num).toInt(),
      totalItems: (json['totalItems'] as num).toInt(),
      totalPages: (json['totalPages'] as num).toInt(),
      data: (json['data'] as List<dynamic>)
          .map((e) => TripMatchDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetTripMatchByUserIdResultToJson(
        GetTripMatchByUserIdResult instance) =>
    <String, dynamic>{
      'page': instance.page,
      'pageSize': instance.pageSize,
      'totalItems': instance.totalItems,
      'totalPages': instance.totalPages,
      'data': instance.data,
    };
