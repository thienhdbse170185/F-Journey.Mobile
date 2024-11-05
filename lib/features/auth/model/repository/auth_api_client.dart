import 'package:dio/dio.dart';
import 'package:f_journey/core/network/api_endpoints.dart';
import 'package:f_journey/features/auth/model/request/driver_register_request.dart';
import 'package:f_journey/features/auth/model/request/passenger_register_request.dart';
import 'package:f_journey/features/auth/model/response/get_user_profile_response.dart';
import 'package:f_journey/features/auth/model/response/login_driver_response.dart';
import 'package:f_journey/features/auth/model/response/login_google_response.dart';

class AuthApiClient {
  const AuthApiClient({required this.dio});
  final Dio dio;

  Future<LoginGoogleResponse> getAuthToken(String accessToken) async {
    try {
      final response = await dio.post(ApiEndpoints.login,
          data: {'idToken': accessToken, 'role': 'passenger'});
      if (response.statusCode == 200) {
        return LoginGoogleResponse.fromJson(response.data);
      } else {
        throw Exception('Failed to login with Google');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<GetUserProfileResponse> getUserProfile(String accessToken) async {
    try {
      final response = await dio.get(ApiEndpoints.getUserProfile,
          options: Options(headers: {'Authorization': 'Bearer $accessToken'}));
      if (response.statusCode == 200) {
        return GetUserProfileResponse.fromJson(response.data);
      } else {
        throw Exception('Failed to get user profile');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<bool?> registerPassenger(PassengerRegisterRequest request) async {
    try {
      FormData formData = FormData.fromMap(await request.toJson());
      final response = await dio.put(
          "${ApiEndpoints.updateUserProfile}/${request.id}",
          data: formData);
      if (response.statusCode == 200) {
        return true;
      } else {
        throw Exception('Failed to register passenger');
      }
    } on DioException catch (e) {
      rethrow;
    }
  }

  Future<bool?> registerDriver(RegisterDriverRequest request) async {
    try {
      FormData formData = FormData.fromMap(await request.toJson());
      final response = await dio.post(ApiEndpoints.register, data: formData);
      if (response.statusCode == 200) {
        return true;
      } else {
        throw Exception('Failed to register driver');
      }
    } on DioException catch (e) {
      rethrow;
    }
  }

  Future<LoginDriverResponse?> loginDriver(
      String email, String password) async {
    try {
      final response = await dio.post(ApiEndpoints.login,
          data: {'email': email, 'password': password, 'role': 'driver'});
      if (response.statusCode == 200) {
        return LoginDriverResponse.fromJson(response.data);
      } else {
        throw Exception('Failed to login driver');
      }
    } catch (e) {
      rethrow;
    }
  }
}
