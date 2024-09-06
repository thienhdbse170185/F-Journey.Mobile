import 'package:f_journey/core/entities/user.dart';
import 'package:f_journey/core/error/exceptions.dart';
import 'package:f_journey/core/error/failures.dart';
import 'package:f_journey/features/auth/domain/repositories/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class AuthRepositoryImpl implements AuthRepository {
  @override
  Future<Either<Failure, User>> loginWithEmailPassword(
      {required String phone, required String password}) {}

  @override
  Future<Either<Failure, User>> register({
    required String phone,
    required String password,
    required String confirm,
    required String name,
  }) {}

  Future<Either<Failure, User>> _getUser(
    Future<User> Function() fn,
  ) async {
    try {
      final user = await fn();

      return right(user);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}
