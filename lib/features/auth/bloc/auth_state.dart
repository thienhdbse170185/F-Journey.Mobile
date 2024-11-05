part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

class AuthInProgress extends AuthState {}

class AuthError extends AuthState {
  final String message;
  AuthError({required this.message});
}

class AuthSuccess extends AuthState {}

class LoginError extends AuthState {
  final String message;
  LoginError({required this.message});
}

class LoginSuccess extends AuthState {}

class RegisterError extends AuthState {
  final String message;
  RegisterError({required this.message});
}

class RegisterSuccess extends AuthState {}

class LoginGoogleError extends AuthState {
  final String message;
  LoginGoogleError({required this.message});
}

class LoginGoogleSuccess extends AuthState {}

class CheckNewUserError extends AuthState {
  final String message;
  CheckNewUserError({required this.message});
}

class UserAlreadyExists extends AuthState {}

class UserDoesNotExist extends AuthState {
  final GetUserProfileResult profile;
  UserDoesNotExist({required this.profile});
}

class RegisterPassengerProfileError extends AuthState {
  final String message;
  RegisterPassengerProfileError({required this.message});
}

class RegisterPassengerProfileSuccess extends AuthState {}

class RegisterPassengerProfileInProgress extends AuthState {}
