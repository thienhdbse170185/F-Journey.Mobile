import 'package:json_annotation/json_annotation.dart';

part 'trip_request_dto.g.dart';

@JsonSerializable()
class TripRequestDto {
  final int id;
  final int userId;
  final int fromZoneId;
  final int toZoneId;
  final String tripDate;
  final String startTime;
  final int slot;
  final String status;
  final String createdAt;
  final String fromZoneName;
  final String toZoneName;

  TripRequestDto({
    required this.id,
    required this.userId,
    required this.fromZoneId,
    required this.toZoneId,
    required this.tripDate,
    required this.startTime,
    required this.slot,
    required this.status,
    required this.createdAt,
    required this.fromZoneName,
    required this.toZoneName,
  });

  factory TripRequestDto.fromJson(Map<String, dynamic> json) =>
      _$TripRequestDtoFromJson(json);

  Map<String, dynamic> toJson() => _$TripRequestDtoToJson(this);

  Map<String, dynamic> toJsonForTripMatch() {
    return {
      'userId': userId,
      "fromZoneId": fromZoneId,
      'toZoneId': toZoneId,
      'fromZoneName': fromZoneName,
      'toZoneName': toZoneName,
      'tripDate': tripDate,
      'startTime': startTime,
    };
  }
}
