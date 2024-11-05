import 'package:f_journey/features/auth/model/dto/wallet.dart';

class GetUserProfileResponse {
  final bool success;
  final GetUserProfileResult? result;

  GetUserProfileResponse({required this.success, this.result});

  factory GetUserProfileResponse.fromJson(Map<String, dynamic> json) {
    return GetUserProfileResponse(
      success: json['success'],
      result: json['success']
          ? GetUserProfileResult.fromJson(json['result'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'result': success ? result?.toJson() : null,
    };
  }
}

class GetUserProfileResult {
  final int id;
  final String name;
  final String email;
  final String? phoneNumber;
  final String profileImageUrl;
  final String? studentIdCardUrl;
  final String role;
  final String? studentId;
  final bool verified;
  final String verificationStatus;
  final bool isMailValid;
  final String createdAt;
  final String? modifiedAt;
  final Wallet wallet;

  GetUserProfileResult({
    required this.id,
    required this.name,
    required this.email,
    this.phoneNumber,
    required this.profileImageUrl,
    this.studentIdCardUrl,
    required this.role,
    this.studentId,
    required this.verified,
    required this.verificationStatus,
    required this.isMailValid,
    required this.createdAt,
    this.modifiedAt,
    required this.wallet,
  });

  factory GetUserProfileResult.fromJson(Map<String, dynamic> json) {
    return GetUserProfileResult(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      phoneNumber: json['phoneNumber'],
      profileImageUrl: json['profileImageUrl'],
      studentIdCardUrl: json['studentIdCardUrl'],
      role: json['role'],
      studentId: json['studentId'],
      verified: json['verified'],
      verificationStatus: json['verificationStatus'],
      isMailValid: json['isMailValid'],
      createdAt: json['createdAt'],
      modifiedAt: json['modifiedAt'],
      wallet: Wallet.fromJson(json['wallet']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phoneNumber': phoneNumber,
      'profileImageUrl': profileImageUrl,
      'studentIdCardUrl': studentIdCardUrl,
      'role': role,
      'studentId': studentId,
      'verified': verified,
      'verificationStatus': verificationStatus,
      'isMailValid': isMailValid,
      'createdAt': createdAt,
      'modifiedAt': modifiedAt,
      'wallet': wallet.toJson(),
    };
  }
}
