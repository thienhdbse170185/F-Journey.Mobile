// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'driver_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DriverDto _$DriverDtoFromJson(Map<String, dynamic> json) => DriverDto(
      name: json['name'] as String,
      email: json['email'] as String,
      profileImageUrl: json['profileImageUrl'] as String,
      liceseNumber: json['liceseNumber'] as String,
      licenseImageUrl: json['licenseImageUrl'] as String,
      licensePlate: json['licensePlate'] as String,
      vehicleImageUrl: json['vehicleImageUrl'] as String,
    );

Map<String, dynamic> _$DriverDtoToJson(DriverDto instance) => <String, dynamic>{
      'name': instance.name,
      'email': instance.email,
      'profileImageUrl': instance.profileImageUrl,
      'liceseNumber': instance.liceseNumber,
      'licenseImageUrl': instance.licenseImageUrl,
      'licensePlate': instance.licensePlate,
      'vehicleImageUrl': instance.vehicleImageUrl,
    };
