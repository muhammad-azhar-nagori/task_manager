import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_task_manager/features/auth/domain/usecases/logout_usecase.dart';
import 'package:mini_task_manager/features/auth/domain/usecases/signin_usecase.dart';
import 'package:mini_task_manager/features/auth/domain/usecases/signup_usecase.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final SignIn _signInUseCase;
  final SignUp _signUpUseCase;
  final SignOut _signOutUseCase;

  AuthCubit({
    required SignIn signInUseCase,
    required SignUp signUpUseCase,
    required SignOut signOutUseCase,
  })  : _signInUseCase = signInUseCase,
        _signUpUseCase = signUpUseCase,
        _signOutUseCase = signOutUseCase,
        super(const AuthState());

  Future<void> signIn(String email, String password) async {
    emit(state.copyWith(status: AuthStatus.loading));
    try {
      await _signInUseCase(email, password);
      emit(state.copyWith(
          status: AuthStatus.success, message: 'Login Successful'));
    } catch (e) {
      emit(state.copyWith(status: AuthStatus.error, message: e.toString()));
    }
  }

  Future<void> signUp(String email, String password) async {
    emit(state.copyWith(status: AuthStatus.loading));
    try {
      await _signUpUseCase(email, password);
      emit(state.copyWith(
          status: AuthStatus.success, message: 'Registration Successful'));
    } catch (e) {
      emit(state.copyWith(status: AuthStatus.error, message: e.toString()));
    }
  }

  Future<void> signOut() async {
    await _signOutUseCase();
    emit(
      state.copyWith(
          status: AuthStatus.success, message: 'Logged out successfully'),
    );
  }
}
