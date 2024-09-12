import 'package:f_journey/features/auth/model/dto/user_dto.dart';
import 'package:f_journey/features/auth/model/repository/auth_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;
  AuthBloc({required this.authRepository}) : super(AuthInitial()) {
    on<LoginEmailPasswordStarted>(
      (event, emit) => _onLoginEmailPassword(event, emit),
    );
  }

  Future<void> _onLoginEmailPassword(
      LoginEmailPasswordStarted event, Emitter<AuthState> emit) async {
    emit(AuthInProgress());
    try {
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
}
