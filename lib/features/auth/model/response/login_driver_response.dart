class LoginDriverResponse {
  bool success;
  LoginDriverResult result;

  LoginDriverResponse({required this.success, required this.result});

  factory LoginDriverResponse.fromJson(Map<String, dynamic> json) {
    return LoginDriverResponse(
      success: json['success'],
      result: LoginDriverResult.fromJson(json['result']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'result': result.toJson(),
    };
  }
}

class LoginDriverResult {
  String accessToken;
  String refreshToken;

  LoginDriverResult({required this.accessToken, required this.refreshToken});

  factory LoginDriverResult.fromJson(Map<String, dynamic> json) {
    return LoginDriverResult(
      accessToken: json['accessToken'],
      refreshToken: json['refreshToken'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'accessToken': accessToken,
      'refreshToken': refreshToken,
    };
  }
}
