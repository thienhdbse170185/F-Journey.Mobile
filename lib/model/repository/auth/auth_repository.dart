import 'package:f_journey/model/repository/auth/auth_api_client.dart';
import 'package:f_journey/model/request/auth/driver_register_request.dart';
import 'package:f_journey/model/request/auth/passenger_register_request.dart';
import 'package:f_journey/model/response/auth/get_user_profile_response.dart';
import 'package:f_journey/model/response/auth/login_driver_response.dart';
import 'package:f_journey/model/response/auth/login_google_response.dart';

class AuthRepository {
  AuthRepository({required this.authApiClient});
  final AuthApiClient authApiClient;

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

  Future<bool?> registerDriver(RegisterDriverRequest request) async {
    try {
      bool? response = await authApiClient.registerDriver(request);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<LoginDriverResponse?> loginDriver(
      String email, String password) async {
    try {
      LoginDriverResponse? response =
          await authApiClient.loginDriver(email, password);
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
