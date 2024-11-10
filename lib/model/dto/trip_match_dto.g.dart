// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trip_match_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TripMatchDto _$TripMatchDtoFromJson(Map<String, dynamic> json) => TripMatchDto(
      id: (json['id'] as num).toInt(),
      driverId: (json['driverId'] as num).toInt(),
      matchedAt: json['matchedAt'] as String,
      status: json['status'] as String,
      driver: DriverDto.fromJson(json['driver'] as Map<String, dynamic>),
      tripRequest:
          TripRequestDto.fromJson(json['tripRequest'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$TripMatchDtoToJson(TripMatchDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'driverId': instance.driverId,
      'matchedAt': instance.matchedAt,
      'status': instance.status,
      'driver': instance.driver,
      'tripRequest': instance.tripRequest,
    };
