import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';

class Driver {
  String licenseNumber;
  bool verified;
  XFile? licenseImage;

  Driver({
    required this.licenseNumber,
    required this.verified,
    required this.licenseImage,
  });
  factory Driver.fromJson(Map<String, dynamic> json) {
    return Driver(
      licenseNumber: json['licenseNumber'],
      verified: json['verified'],
      licenseImage: json['licenseImageUrl'],
    );
  }

  Future<Map<String, dynamic>> toJson() async {
    return {
      'LicenseNumber': licenseNumber,
      'Verified': verified,
      'LicenseImageUrl': await MultipartFile.fromFile(licenseImage!.path,
          filename: licenseImage!.name,
          contentType: MediaType('image', 'jpeg')),
    };
  }
}
