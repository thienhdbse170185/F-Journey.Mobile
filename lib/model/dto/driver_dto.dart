import 'package:json_annotation/json_annotation.dart';

part 'driver_dto.g.dart';

@JsonSerializable()
class DriverDto {
  String name;
  String email;
  String profileImageUrl;
  String licenseNumber;
  String licenseImageUrl;
  String licensePlate;
  String vehicleImageUrl;

  DriverDto({
    required this.name,
    required this.email,
    required this.profileImageUrl,
    required this.licenseNumber,
    required this.licenseImageUrl,
    required this.licensePlate,
    required this.vehicleImageUrl,
  });

  factory DriverDto.fromJson(Map<String, dynamic> json) =>
      _$DriverDtoFromJson(json);

  Map<String, dynamic> toJson() => _$DriverDtoToJson(this);
}
