import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';

class Vehicle {
  String licensePlate;
  String vehicleType;
  bool isVerified;
  String registration;
  XFile? vehicleImage;
  XFile? registrationImage;

  Vehicle({
    required this.licensePlate,
    required this.vehicleType,
    required this.isVerified,
    required this.registration,
    required this.vehicleImage,
    required this.registrationImage,
  });
  factory Vehicle.fromJson(Map<String, dynamic> json) {
    return Vehicle(
      licensePlate: json['LicensePlate'],
      vehicleType: json['VehicleType'],
      isVerified: json['IsVerified'],
      registration: json['Registration'],
      vehicleImage: json['VehicleImageUrl'],
      registrationImage: json['RegistrationImageUrl'],
    );
  }

  Future<Map<String, dynamic>> toJson() async {
    return {
      'LicensePlate': licensePlate,
      'VehicleType': vehicleType,
      'IsVerified': isVerified,
      'Registration': registration,
      'VehicleImageUrl': await MultipartFile.fromFile(vehicleImage!.path,
          filename: vehicleImage!.name,
          contentType: MediaType('image', 'jpeg')),
      'RegistrationImageUrl': await MultipartFile.fromFile(
          registrationImage!.path,
          filename: registrationImage!.name,
          contentType: MediaType('image', 'jpeg')),
    };
  }
}
