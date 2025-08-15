import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_task_manager/features/auth/domain/entities/user_entity.dart';
import 'package:mini_task_manager/features/auth/domain/usecases/logout_usecase.dart';
import 'package:mini_task_manager/features/auth/domain/usecases/signin_usecase.dart';
import 'package:mini_task_manager/features/auth/domain/usecases/signup_usecase.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final SignIn signInUseCase;
  final SignUp signUpUseCase;
  final SignOut signOutUseCase;

  AuthCubit({
    required this.signInUseCase,
    required this.signUpUseCase,
    required this.signOutUseCase,
  }) : super(AuthInitial());

  Future<void> signIn(String email, String password) async {
    emit(AuthLoading());
    try {
      final user = await signInUseCase(email, password);
      emit(AuthSuccess(user));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> signUp(String email, String password) async {
    emit(AuthLoading());
    try {
      final user = await signUpUseCase(email, password);
      emit(AuthSuccess(user));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> signOut() async {
    await signOutUseCase();
    emit(AuthInitial());
  }
}
