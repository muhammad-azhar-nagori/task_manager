import 'package:flutter/material.dart';
import 'package:mini_task_manager/features/auth/presentation/view/login_view.dart';
import 'package:mini_task_manager/features/auth/presentation/view/signup_view.dart';
import 'package:mini_task_manager/features/task/presentation/view/task_view.dart';
import 'app_routes.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case AppRoutes.login:
      return MaterialPageRoute(builder: (_) => LoginView());
    case AppRoutes.signup:
      return MaterialPageRoute(builder: (_) => SignupView());
    case AppRoutes.taskList:
      return MaterialPageRoute(builder: (_) => const TaskListView());
    default:
      return MaterialPageRoute(
        builder: (_) => Scaffold(
          body: Center(child: Text('No route defined for ${settings.name}')),
        ),
      );
  }
}
