import 'package:f_journey/core/utils/reg_util.dart';
import 'package:f_journey/features/auth/model/dto/user_dto.dart';
import 'package:f_journey/features/auth/model/repository/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;
  AuthBloc({required this.authRepository}) : super(AuthInitial()) {
    on<LoginEmailPasswordStarted>(
      (event, emit) => _onLoginEmailPassword(event, emit),
    );
    on<LoginGoogleStarted>(
      (event, emit) => _onLoginGoogleStarted(event, emit),
    );
  }

  Future<void> _onLoginEmailPassword(
      LoginEmailPasswordStarted event, Emitter<AuthState> emit) async {
    emit(AuthInProgress());
    try {
      if (RegUtil.validateEmail(event.email) != null &&
          RegUtil.validatePassword(event.password) != null) {
        emit(LoginError(message: 'Please enter valid email/password'));
        return;
      }
      UserDto? user = await authRepository.getUserByEmail(event.email);
      if (user == null) {
        emit(LoginError(message: 'User not found'));
        return;
      }
      emit(LoginSuccess());
    } catch (e) {
      emit(LoginError(message: 'User not found'));
      if (kDebugMode) {
        print('Error while login with email/password: $e');
      }
    }
  }

  Future<UserCredential?> signInWithGoogle() async {
    try {
      // Trigger the Google Sign In process
      final googleUser = await GoogleSignIn().signIn();

      // Handle the case when the user cancels the Google sign-in
      if (googleUser == null) {
        return null; // User canceled the sign-in
      }

      // Obtain the GoogleSignInAuthentication object
      final googleAuth = await googleUser.authentication;

      // Check if googleAuth has accessToken and idToken
      if (googleAuth.accessToken == null || googleAuth.idToken == null) {
        throw FirebaseAuthException(
          code: 'ERROR_MISSING_GOOGLE_AUTH_TOKENS',
          message: 'Missing Google Auth Token',
        );
      }

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      if (kDebugMode) {
        print('Credential AccessToken: ${credential.accessToken}');
      }

      // Sign in to Firebase with the Google credential
      return await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (e) {
      // Handle the error, print it in debug mode
      if (kDebugMode) {
        print('Error during Google Sign-In: $e');
      }
      rethrow; // Rethrow to handle in the calling function
    }
  }

  Future<void> _onLoginGoogleStarted(
    LoginGoogleStarted event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthInProgress());
    try {
      // Attempt to sign in with Google
      final UserCredential? userCredential = await signInWithGoogle();

      // Handle the case where user cancels the sign-in
      if (userCredential == null) {
        emit(LoginGoogleError(message: 'UserCredential is null.'));
      } else {
        emit(LoginGoogleSuccess());
      }
    } catch (e) {
      emit(LoginGoogleError(message: 'Error while login with Google'));
      if (kDebugMode) {
        print('Error while login with Google: $e');
      }
    }
  }

  Future<void> _onCheckNewUserStarted(
    CheckNewUserStarted event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthInProgress());
    try {
      UserDto? user = await authRepository
          .getUserByEmail(event.userCredential.user!.email!);
      if (user == null) {
        emit(UserDoesNotExist());
      } else {
        emit(UserAlreadyExists());
      }
    } catch (e) {
      emit(CheckNewUserError(message: 'Error while checking new user'));
      if (kDebugMode) {
        print('Error while checking new user: $e');
      }
    }
  }
}
