import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_task_manager/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:mini_task_manager/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:mini_task_manager/features/auth/domain/usecases/logout_usecase.dart';
import 'package:mini_task_manager/features/auth/domain/usecases/signin_usecase.dart';
import 'package:mini_task_manager/features/auth/domain/usecases/signup_usecase.dart';
import 'package:mini_task_manager/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:mini_task_manager/features/auth/presentation/view/login_view.dart';
import 'package:mini_task_manager/features/auth/presentation/view/signup_view.dart';
import 'package:mini_task_manager/features/splash/view/splash_view.dart';
import 'package:mini_task_manager/features/task/data/datasources/task_remote_data_source.dart';
import 'package:mini_task_manager/features/task/data/repositories/task_repository_impl.dart';
import 'package:mini_task_manager/features/task/domain/usecases/delete_task.dart';
import 'package:mini_task_manager/features/task/domain/usecases/get_tasks.dart';
import 'package:mini_task_manager/features/task/domain/usecases/toggle_task_status.dart';
import 'package:mini_task_manager/features/task/presentation/cubit/task_list_cubit.dart';
import 'package:mini_task_manager/features/task/presentation/view/task_list_view.dart';
import 'package:mini_task_manager/core/services/network/firebase_firestore_service.dart';
import 'app_routes.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  final authRepository =
      AuthRepositoryImpl(FirebaseAuthDataSourceImpl(FirebaseAuth.instance));
  final firestoreService = FirestoreService();
  final taskRepository = TaskRepositoryImpl(
    TaskRemoteDataSource(firestoreService: firestoreService),
  );

  switch (settings.name) {
    case AppRoutes.splash:
      return MaterialPageRoute(builder: (_) => const SplashView());

    case AppRoutes.signin:
      return MaterialPageRoute(
        builder: (_) => BlocProvider(
          create: (_) => AuthCubit(
            signInUseCase: SignIn(authRepository),
            signUpUseCase: SignUp(authRepository),
            signOutUseCase: SignOut(authRepository),
          ),
          child: LoginView(),
        ),
      );

    case AppRoutes.signup:
      return MaterialPageRoute(
        builder: (_) => BlocProvider(
          create: (_) => AuthCubit(
            signInUseCase: SignIn(authRepository),
            signUpUseCase: SignUp(authRepository),
            signOutUseCase: SignOut(authRepository),
          ),
          child: SignupView(),
        ),
      );

    case AppRoutes.taskList:
      return MaterialPageRoute(
        builder: (_) => BlocProvider(
          create: (_) => TaskListCubit(
            getTasksUseCase: GetTasks(taskRepository),
            toggleTaskUseCase: ToggleTaskStatus(taskRepository),
            deleteTaskUseCase: DeleteTask(taskRepository),
          )..loadTasks(), // auto load tasks when screen opens
          child: const TaskListView(),
        ),
      );

    default:
      return MaterialPageRoute(
        builder: (_) => Scaffold(
          body: Center(child: Text('No route defined for ${settings.name}')),
        ),
      );
  }
}
