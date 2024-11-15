// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_all_payment_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetAllPaymentResponse _$GetAllPaymentRepsonseFromJson(
        Map<String, dynamic> json) =>
    GetAllPaymentResponse(
      success: (json['success'] as bool),
      result:
          GetAllPaymentResult.fromJson(json['result'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GetAllPaymentRepsonseToJson(
        GetAllPaymentResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'result': instance.result,
    };

GetAllPaymentResult _$GetAllPaymentResultFromJson(Map<String, dynamic> json) =>
    GetAllPaymentResult(
      items: (json['items'] as List<dynamic>)
          .map((e) => PaymentDto.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalCount: (json['totalCount'] as num).toInt(),
      currentPage: (json['currentPage'] as num).toInt(),
      pageSize: (json['pageSize'] as num).toInt(),
      hasPreviousPage: json['hasPreviousPage'] as bool,
      hasNextPage: json['hasNextPage'] as bool,
      totalPages: (json['totalPages'] as num).toInt(),
    );

Map<String, dynamic> _$GetAllPaymentResultToJson(
        GetAllPaymentResult instance) =>
    <String, dynamic>{
      'items': instance.items,
      'totalCount': instance.totalCount,
      'currentPage': instance.currentPage,
      'pageSize': instance.pageSize,
      'hasPreviousPage': instance.hasPreviousPage,
      'hasNextPage': instance.hasNextPage,
      'totalPages': instance.totalPages,
    };
