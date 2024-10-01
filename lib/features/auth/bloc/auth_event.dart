part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

class AuthInitialEvent extends AuthEvent {}

class LoginEmailPasswordStarted extends AuthEvent {
  final String email;
  final String password;
  LoginEmailPasswordStarted({
    required this.email,
    required this.password,
  });
}

class LoginGoogleStarted extends AuthEvent {}

class CheckNewUserStarted extends AuthEvent {
  final UserCredential userCredential;
  CheckNewUserStarted({required this.userCredential});
}

class RegisterStarted extends AuthEvent {
  final String email;
  final String password;
  final String name;
  RegisterStarted({
    required this.email,
    required this.password,
    required this.name,
  });
}
