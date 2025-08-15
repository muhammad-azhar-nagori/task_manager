import 'package:mini_task_manager/features/auth/data/datasources/auth_remote_data_source.dart';

import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../models/user_model.dart';

class AuthRepositoryImpl implements AuthRepository {
  final FirebaseAuthDataSource dataSource;

  AuthRepositoryImpl(this.dataSource);

  @override
  Future<UserEntity?> signIn(String email, String password) async {
    final user = await dataSource.signIn(email, password);
    return user != null ? UserModel.fromFirebaseUser(user) : null;
  }

  @override
  Future<UserEntity?> signUp(String email, String password) async {
    final user = await dataSource.signUp(email, password);
    return user != null ? UserModel.fromFirebaseUser(user) : null;
  }

  @override
  Future<void> signOut() => dataSource.signOut();
}
