// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trip_request_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TripRequestDto _$TripRequestDtoFromJson(Map<String, dynamic> json) =>
    TripRequestDto(
      id: (json['id'] as num).toInt(),
      userId: (json['userId'] as num).toInt(),
      fromZoneId: (json['fromZoneId'] as num).toInt(),
      toZoneId: (json['toZoneId'] as num).toInt(),
      tripDate: json['tripDate'] as String,
      startTime: json['startTime'] as String,
      slot: (json['slot'] as num).toInt(),
      status: json['status'] as String,
      createdAt: json['createdAt'] as String,
      fromZone: json['fromZone'] as String?,
      toZone: json['toZone'] as String?,
    );

Map<String, dynamic> _$TripRequestDtoToJson(TripRequestDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'fromZoneId': instance.fromZoneId,
      'toZoneId': instance.toZoneId,
      'tripDate': instance.tripDate,
      'startTime': instance.startTime,
      'slot': instance.slot,
      'status': instance.status,
      'createdAt': instance.createdAt,
      'fromZone': instance.fromZone,
      'toZone': instance.toZone,
    };
