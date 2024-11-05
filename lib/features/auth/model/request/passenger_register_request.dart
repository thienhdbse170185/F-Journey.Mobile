import 'package:dio/dio.dart';
import 'package:f_journey/features/auth/model/request/driver.dart';
import 'package:f_journey/features/auth/model/request/vehicle.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';

class PassengerRegisterRequest {
  int id;
  String name;
  String email;
  String phoneNumber;
  String profileImageUrl;
  XFile studentIdCardUrl;
  String studentId;

  PassengerRegisterRequest(
      {required this.id,
      required this.name,
      required this.email,
      required this.phoneNumber,
      required this.profileImageUrl,
      required this.studentIdCardUrl,
      required this.studentId});

  factory PassengerRegisterRequest.fromJson(Map<String, dynamic> json) {
    return PassengerRegisterRequest(
      id: json['Id'],
      name: json['Name'],
      email: json['Email'],
      phoneNumber: json['PhoneNumber'],
      profileImageUrl: json['ProfileImageUrl'],
      studentIdCardUrl: json['StudentIdCardUrl'],
      studentId: json['StudentId'],
    );
  }

  Future<Map<String, dynamic>> toJson() async => {
        'Id': id,
        'Name': name,
        'Email': email,
        'PhoneNumber': phoneNumber,
        'ProfileImageUrl': profileImageUrl,
        'StudentIdCardUrl': await MultipartFile.fromFile(studentIdCardUrl!.path,
            filename: studentIdCardUrl!.name,
            contentType: MediaType('image', 'jpeg')),
        'StudentId': studentId,
      };
}
