import 'package:f_journey/core/data/local_datasource.dart';
import 'package:f_journey/core/utils/reg_util.dart';
import 'package:f_journey/features/auth/model/dto/user_dto.dart';
import 'package:f_journey/features/auth/model/repository/auth_repository.dart';
import 'package:f_journey/features/auth/model/request/driver_register_request.dart';
import 'package:f_journey/features/auth/model/request/passenger_register_request.dart';
import 'package:f_journey/features/auth/model/response/get_user_profile_response.dart';
import 'package:f_journey/features/auth/model/response/login_driver_response.dart';
import 'package:f_journey/features/auth/model/response/login_google_response.dart';
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
    on<GetUserProfileStarted>(
      (event, emit) => _onGetUserProfile(event, emit),
    );
    on<RegisterPassengerProfileStarted>(
      (event, emit) => _onRegisterPassenger(event, emit),
    );
    on<RegisterDriverProfileStarted>(
      (event, emit) => _onRegisterDriver(event, emit),
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
      LoginDriverResponse? user =
          await authRepository.loginDriver(event.email, event.password);
      if (user != null) {
        await LocalDataSource.saveAccessToken(user.result.accessToken);
        emit(LoginSuccess());
        return;
      } else {
        emit(LoginError(message: 'User not found'));
      }
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
        await _onGetAuthToken(userCredential.credential!.accessToken!);
        emit(LoginGoogleSuccess());
      }
    } catch (e) {
      emit(LoginGoogleError(message: 'Error while login with Google'));
      if (kDebugMode) {
        print('Error while login with Google: $e');
      }
    }
  }

  Future<void> _onGetAuthToken(String accessTokenGoogle) async {
    try {
      // Call API to get access token
      GoogleResult? authToken =
          await authRepository.getAuthToken(accessTokenGoogle);
      if (kDebugMode) {
        print('Access Token: ${authToken!.accessToken}');
      }

      // Save access token to Hive
      await LocalDataSource.saveAccessToken(authToken!.accessToken);
    } catch (e) {
      if (kDebugMode) {
        print('Error while saving access token: $e');
      }
    }
  }

  Future<void> _onGetUserProfile(
    GetUserProfileStarted event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthInProgress());
    try {
      String? accessToken = await LocalDataSource.getAccessToken();
      if (accessToken != null) {
        GetUserProfileResult? profile =
            await authRepository.getUserProfile(accessToken);
        if (profile != null) {
          if (profile.verificationStatus == 'Init') {
            emit(UserDoesNotExist(profile: profile));
          } else if (profile.verificationStatus == 'Pending') {
            emit(ProfileUserPending());
          } else if (profile.verificationStatus == 'Approved') {
            emit(ProfileUserApproved());
          } else {
            emit(ProfileUserRejected());
          }
        } else {
          emit(AuthError(message: 'Error while getting user profile'));
        }
      } else {
        emit(AuthError(message: 'Access token is null'));
      }
    } catch (e) {
      emit(CheckNewUserError(message: 'Error while checking new user'));
      if (kDebugMode) {
        print('Error while checking new user: $e');
      }
    }
  }

  Future<void> _onRegisterPassenger(
      RegisterPassengerProfileStarted event, Emitter<AuthState> emit) async {
    emit(RegisterPassengerProfileInProgress());
    try {
      bool? isRegistered =
          await authRepository.registerPassenger(event.request);
      if (isRegistered!) {
        emit(RegisterPassengerProfileSuccess());
      } else {
        emit(RegisterPassengerProfileError(message: 'Failed to register'));
      }
    } catch (e) {
      emit(RegisterPassengerProfileError(message: 'Error while registering'));
      if (kDebugMode) {
        print('Error while registering: $e');
      }
    }
  }

  Future<void> _onRegisterDriver(
      RegisterDriverProfileStarted event, Emitter<AuthState> emit) async {
    emit(RegisterDriverProfileInProgress());
    try {
      bool? isRegistered = await authRepository.registerDriver(event.request);
      if (isRegistered!) {
        emit(RegisterDriverProfileSuccess());
      } else {
        emit(RegisterDriverProfileError(message: 'Failed to register'));
      }
    } catch (e) {
      emit(RegisterDriverProfileError(message: 'Error while registering'));
      if (kDebugMode) {
        print('Error while registering: $e');
      }
    }
  }
}
