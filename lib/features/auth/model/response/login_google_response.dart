class LoginGoogleResponse {
  final bool success;
  final GoogleResult result;

  LoginGoogleResponse({required this.success, required this.result});

  factory LoginGoogleResponse.fromJson(Map<String, dynamic> json) {
    return LoginGoogleResponse(
      success: json['success'],
      result: json['success']
          ? GoogleResult(
              accessToken: json['result']['accessToken'],
              refreshToken: json['result']['refreshToken'],
            )
          : GoogleResult(
              message: json['result']['message'],
            ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'result': success
          ? {
              'accessToken': result.accessToken,
              'refreshToken': result.refreshToken,
            }
          : {
              'message': result.message,
            },
    };
  }
}

class GoogleResult {
  final String? accessToken;
  final String? refreshToken;
  final String? message;

  GoogleResult({this.accessToken, this.refreshToken, this.message});
}
