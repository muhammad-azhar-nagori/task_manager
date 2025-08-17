import 'package:get_it/get_it.dart';
import 'package:mini_task_manager/core/services/network/firebase_firestore_service.dart';
import 'package:mini_task_manager/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:mini_task_manager/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:mini_task_manager/features/auth/domain/repositories/auth_repository.dart';
import 'package:mini_task_manager/features/task/data/datasources/task_remote_data_source.dart';
import 'package:mini_task_manager/features/task/data/repositories/task_repository_impl.dart';
import 'package:mini_task_manager/features/task/domain/repositories/task_repository.dart';

final GetIt locator = GetIt.instance;

void setupLocators() {
  locator.registerLazySingleton<FirestoreService>(() => FirestoreService());
  locator.registerFactory<TaskRepository>(() => TaskRepositoryImpl(
        TaskRemoteDataSource(firestoreService: locator<FirestoreService>()),
      ));
  locator.registerFactory<AuthRepository>(
      () => AuthRepositoryImpl(FirebaseAuthDataSourceImpl()));
}
