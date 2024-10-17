import 'package:dio/dio.dart';
import 'package:f_journey/core/network/api_endpoints.dart';
import 'package:f_journey/features/auth/model/response/login_google_response.dart';

class AuthApiClient {
  const AuthApiClient({required this.dio});
  final Dio dio;

  Future<LoginGoogleResponse> getAuthToken(String accessToken) async {
    try {
      final response = await dio
          .post(ApiEndpoints.loginGoogle, data: {'idToken': accessToken});
      if (response.statusCode == 200) {
        return LoginGoogleResponse.fromJson(response.data);
      } else {
        throw Exception('Failed to login with Google');
      }
    } catch (e) {
      rethrow;
    }
  }
}
