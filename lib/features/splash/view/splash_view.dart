// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mini_task_manager/core/routes/app_routes.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    _navigate();
  }

  Future<void> _navigate() async {
    final User? user = FirebaseAuth.instance.currentUser;
    await Future.delayed(Durations.extralong4);
   
        if (user != null) {
          Navigator.pushReplacementNamed(
            context,
            AppRoutes.taskList,
          );
        } else {
          Navigator.pushReplacementNamed(
            context,
            AppRoutes.login,
          );
        }
      }
  

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          "Mini Task Manager",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
