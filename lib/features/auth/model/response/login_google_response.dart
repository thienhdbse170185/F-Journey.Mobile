class LoginGoogleResponse {
  final bool success;
  final Result result;

  LoginGoogleResponse({required this.success, required this.result});

  factory LoginGoogleResponse.fromJson(Map<String, dynamic> json) {
    return LoginGoogleResponse(
      success: json['success'],
      result: json['success']
          ? Result(
              accessToken: json['result']['accessToken'],
              refreshToken: json['result']['refreshToken'],
            )
          : Result(
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

class Result {
  final String? accessToken;
  final String? refreshToken;
  final String? message;

  Result({this.accessToken, this.refreshToken, this.message});
}
