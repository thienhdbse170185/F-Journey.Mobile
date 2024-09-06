import 'package:f_journey/core/entities/user.dart';
import 'package:f_journey/core/error/failures.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class AuthRepository {
  Future<Either<Failure, User>> loginWithEmailPassword(
      {String phone, String password});
  Future<Either<Failure, User>> register(
      {String phone, String password, String confirm, String name});
}
