import 'package:f_journey/model/dto/driver_dto.dart';
import 'package:f_journey/model/dto/trip_request_dto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'trip_match_dto.g.dart';

@JsonSerializable()
class TripMatchDto {
  int id;
  int tripRequestId;
  int driverId;
  String matchedAt;
  String status;
  DriverDto driver;
  TripRequestDto tripRequest;

  TripMatchDto(
      {required this.id,
      required this.tripRequestId,
      required this.driverId,
      required this.matchedAt,
      required this.status,
      required this.driver,
      required this.tripRequest});

  factory TripMatchDto.fromJson(Map<String, dynamic> json) =>
      _$TripMatchDtoFromJson(json);

  Map<String, dynamic> toJson() => _$TripMatchDtoToJson(this);
}
