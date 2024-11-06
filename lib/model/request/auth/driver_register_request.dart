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
      name: json['name'],
      email: json['email'],
      phoneNumber: json['phoneNumber'],
      password: json['password'],
      profileImage:
          json['profileImage'] != null ? XFile(json['profileImage']) : null,
      driver: Driver.fromJson(json['driver']),
      vehicle: Vehicle.fromJson(json['vehicle']),
    );
  }

  Future<Map<String, dynamic>> toJson() async {
    return {
      'Name': name,
      'Email': email,
      'PhoneNumber': phoneNumber,
      'Password': password,
      'ProfileImageUrl': await MultipartFile.fromFile(profileImage!.path,
          filename: profileImage!.name,
          contentType: MediaType('image', 'jpeg')),
      'Driver': driver.toJson(),
      'Vehicle': vehicle.toJson(),
    };
  }
}
