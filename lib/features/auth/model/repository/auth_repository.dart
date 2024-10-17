import 'package:f_journey/features/auth/model/dto/user_dto.dart';
import 'package:f_journey/features/auth/model/example/users.dart';
import 'package:f_journey/features/auth/model/repository/auth_api_client.dart';
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

  Future<Result?> getAuthToken(String accessTokenGoogle) async {
    try {
      LoginGoogleResponse? response =
          await authApiClient.getAuthToken(accessTokenGoogle);
      if (response.success) {
        return response.result;
      }
    } catch (e) {
      rethrow;
    }
  }
}
