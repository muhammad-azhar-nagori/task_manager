import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_task_manager/core/utils/setup_locators.dart';
import 'package:mini_task_manager/features/auth/presentation/view/login_view.dart';
import 'package:mini_task_manager/features/auth/presentation/view/signup_view.dart';
import 'package:mini_task_manager/features/quote/domain/repositories/quote_repository.dart';
import 'package:mini_task_manager/features/quote/domain/usecases/get_random_qoute.dart';
import 'package:mini_task_manager/features/quote/presentation/cubit/quote_cubit.dart';
import 'package:mini_task_manager/features/splash/view/splash_view.dart';
import 'package:mini_task_manager/features/task/domain/entities/task_entity.dart';
import 'package:mini_task_manager/features/task/domain/repositories/task_repository.dart';
import 'package:mini_task_manager/features/task/domain/usecases/add_task.dart';
import 'package:mini_task_manager/features/task/domain/usecases/delete_task.dart';
import 'package:mini_task_manager/features/task/domain/usecases/get_tasks.dart';
import 'package:mini_task_manager/features/task/domain/usecases/toggle_task_status.dart';
import 'package:mini_task_manager/features/task/presentation/cubit/task_cubit.dart';
import 'package:mini_task_manager/features/task/presentation/view/task_list_view.dart';
import 'package:mini_task_manager/features/task/presentation/view/task_form_view.dart';
import 'app_routes.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case AppRoutes.splash:
      return MaterialPageRoute(builder: (_) => const SplashView());

    case AppRoutes.login:
      return MaterialPageRoute(builder: (_) => LoginView());

    case AppRoutes.signup:
      return MaterialPageRoute(
        builder: (_) => SignupView(),
      );

    case AppRoutes.taskList:
      return MaterialPageRoute(
        builder: (_) => MultiBlocProvider(
          providers: [
            BlocProvider<QuoteCubit>(
                create: (_) => QuoteCubit(
                    getRandomQuote: GetRandomQuote(locator<QuoteRepository>()))
                  ..fetchQuote()),
            BlocProvider(
                create: (_) => TaskCubit(
                      getTasksUseCase: GetTasks(locator<TaskRepository>()),
                      toggleTaskUseCase:
                          ToggleTaskStatus(locator<TaskRepository>()),
                      deleteTaskUseCase: DeleteTask(locator<TaskRepository>()),
                    )..loadTasks())
          ],
          child: const TaskListView(),
        ),
      );
    case AppRoutes.taskForm:
      return MaterialPageRoute(
        builder: (_) => BlocProvider(
          create: (_) =>
              TaskCubit(addTaskUseCase: AddTask(locator<TaskRepository>())),
          child: TaskFormView(
            task: settings.arguments as TaskEntity?,
          ),
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
