part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

class LoginEmailPasswordEvent extends AuthEvent {
  final String phone;
  final String password;

  LoginEmailPasswordEvent({required this.phone, required this.password});
}

class LoginWithGoogleEvent extends AuthEvent {}

class RegisterEvent extends AuthEvent {
  final String phone;
  final String password;
  final String name;

  RegisterEvent(
      {required this.phone, required this.password, required this.name});
}
