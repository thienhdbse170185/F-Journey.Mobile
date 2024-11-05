import 'package:f_journey/features/auth/model/dto/user_dto.dart';
import 'package:f_journey/features/auth/model/example/users.dart';
import 'package:f_journey/features/auth/model/repository/auth_api_client.dart';
import 'package:f_journey/features/auth/model/request/passenger_register_request.dart';
import 'package:f_journey/features/auth/model/response/get_user_profile_response.dart';
import 'package:f_journey/features/auth/model/response/login_google_response.dart';

class AuthRepository {
  AuthRepository({required this.authApiClient});
  final AuthApiClient authApiClient;

  Future<UserDto?> getUserByEmail(String email) async {
    try {
      await Future.delayed(const Duration(seconds: 3));
      UserDto? user = users.firstWhere((user) => user.email == email);
      return user;
    } catch (e) {
      rethrow;
    }
  }

  Future<GoogleResult?> getAuthToken(String accessTokenGoogle) async {
    try {
      LoginGoogleResponse? response =
          await authApiClient.getAuthToken(accessTokenGoogle);
      if (response.success) {
        return response.result;
      }
    } catch (e) {
      rethrow;
    }
    return null;
  }

  Future<GetUserProfileResult?> getUserProfile(String accessToken) async {
    try {
      GetUserProfileResponse? profile =
          await authApiClient.getUserProfile(accessToken);
      return profile.result;
    } catch (e) {
      rethrow;
    }
  }

  Future<bool?> registerPassenger(PassengerRegisterRequest request) async {
    try {
      bool? response = await authApiClient.registerPassenger(request);
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
