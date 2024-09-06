part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

class AuthInitial extends AuthState {}

class LoginEmailPasswordStarted extends AuthState {}

class LoginInProgress extends AuthState {}

class LoginSuccessfully extends AuthState {}

class LoginError extends AuthState {
  final String message;
  LoginError({required this.message});
}

class LoginWithGoogleStarted extends AuthState {}

class LoginWithGoogleInProgress extends AuthState {}

class LoginWithGoogleError extends AuthState {
  final String message;
  LoginWithGoogleError({required this.message});
}

class RegisterStarted extends AuthState {}

class RegisterInProgress extends AuthState {}

class RegisterError extends AuthState {
  final String message;
  RegisterError({required this.message});
}

class RegisterSuccessfully extends AuthState {}
