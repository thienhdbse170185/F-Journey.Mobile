import 'package:f_journey/features/auth/model/dto/user_dto.dart';
import 'package:f_journey/features/auth/model/example/users.dart';

class AuthRepository {
  Future<UserDto?> getUserByEmail(String email) async {
    try {
      await Future.delayed(const Duration(seconds: 3));
      UserDto? user = users.firstWhere((user) => user.email == email);
      return user;
    } catch (e) {
      rethrow;
    }
  }
}
