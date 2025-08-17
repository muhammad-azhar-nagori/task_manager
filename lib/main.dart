import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_task_manager/core/utils/setup_locators.dart';
import 'package:mini_task_manager/features/auth/domain/repositories/auth_repository.dart';
import 'package:mini_task_manager/features/auth/domain/usecases/logout_usecase.dart';
import 'package:mini_task_manager/features/auth/domain/usecases/signin_usecase.dart';
import 'package:mini_task_manager/features/auth/domain/usecases/signup_usecase.dart';
import 'package:mini_task_manager/features/auth/presentation/cubit/auth_cubit.dart';
import 'firebase_options.dart';
import 'core/routes/routes_generator.dart';
import 'core/routes/app_routes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocators();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => AuthCubit(
            signInUseCase: SignIn(locator<AuthRepository>()),
            signUpUseCase: SignUp(locator<AuthRepository>()),
            signOutUseCase: SignOut(locator<AuthRepository>()),
          ),
        ),
      ],
      child: MaterialApp(
        title: 'Task Manager',
        theme: ThemeData(primarySwatch: Colors.blue),
        initialRoute: AppRoutes.splash,
        onGenerateRoute: generateRoute,
      ),
    );
  }
}
