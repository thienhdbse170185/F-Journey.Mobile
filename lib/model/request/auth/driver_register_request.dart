import 'package:dio/dio.dart';
import 'package:f_journey/model/entity/driver.dart';
import 'package:f_journey/model/entity/vehicle.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';

class RegisterDriverRequest {
  String name;
  String email;
  String phoneNumber;
  String password;
  XFile? profileImage;
  Driver driver;
  Vehicle vehicle;

  RegisterDriverRequest({
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.password,
    this.profileImage,
    required this.driver,
    required this.vehicle,
  });

  factory RegisterDriverRequest.fromJson(Map<String, dynamic> json) {
    return RegisterDriverRequest(
      name: json['Name'],
      email: json['Email'],
      phoneNumber: json['PhoneNumber'],
      password: json['Password'],
      profileImage: json['ProfileImageUrl'] != null
          ? XFile(json['ProfileImageUrl'])
          : null,
      driver: Driver.fromJson(json['Driver']),
      vehicle: Vehicle.fromJson(json['Vehicle']),
    );
  }

  Future<Map<String, dynamic>> toJson() async {
    return {
      'Name': name,
      'Email': email,
      'PhoneNumber': phoneNumber,
      'Password': password,
      if (profileImage != null)
        'ProfileImageUrl': await MultipartFile.fromFile(
          profileImage!.path,
          filename: profileImage!.name,
          contentType: MediaType('image', 'jpeg'),
        ),
      'Driver.LicenseNumber': driver.licenseNumber,
      'Driver.Verified': driver.verified.toString(),
      'Driver.LicenseImageUrl': await MultipartFile.fromFile(
        driver.licenseImage!.path,
        filename: driver.licenseImage!.name,
        contentType: MediaType('image', 'jpeg'),
      ),
      'Vehicle.VehicleType': vehicle.vehicleType,
      'Vehicle.IsVerified': vehicle.isVerified.toString(),
      'Vehicle.LicensePlate': vehicle.licensePlate,
      'Vehicle.Registration': vehicle.registration,
      'Vehicle.RegistrationImageUrl': await MultipartFile.fromFile(
        vehicle.registrationImage!.path,
        filename: vehicle.registrationImage!.name,
        contentType: MediaType('image', 'jpeg'),
      ),
      'Vehicle.VehicleImageUrl': await MultipartFile.fromFile(
        vehicle.vehicleImage!.path,
        filename: vehicle.vehicleImage!.name,
        contentType: MediaType('image', 'jpeg'),
      ),
    };
  }
}
