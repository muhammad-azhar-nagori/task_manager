// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_task_manager/core/routes/app_routes.dart';
import 'package:mini_task_manager/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:mini_task_manager/features/quote/presentation/cubit/quote_cubit.dart';
import 'package:mini_task_manager/features/quote/presentation/cubit/quote_state.dart';
import 'package:mini_task_manager/features/task/presentation/cubit/task_cubit.dart';
import 'package:mini_task_manager/features/task/presentation/widgets/task_item_widget.dart';

class TaskListView extends StatefulWidget {
  const TaskListView({super.key});

  @override
  State<TaskListView> createState() => _TaskListViewState();
}

class _TaskListViewState extends State<TaskListView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Tasks"),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => context.read<TaskCubit>().loadTasks(),
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await context.read<AuthCubit>().signOut();
              Navigator.pushReplacementNamed(context, AppRoutes.login);
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            BlocBuilder<QuoteCubit, QuoteState>(
              builder: (context, state) {
                if (state is QuoteLoading) {
                  return const Padding(
                    padding: EdgeInsets.all(16),
                    child: CircularProgressIndicator(),
                  );
                } else if (state is QuoteLoaded) {
                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Text(
                          '"${state.quote.author}"',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontStyle: FontStyle.italic, fontSize: 16),
                        ),
                        const SizedBox(height: 4),
                        Text('- ${state.quote.content}',
                            style: const TextStyle(fontSize: 14)),
                      ],
                    ),
                  );
                } else if (state is QuoteError) {
                  return const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      'Error loading quote',
                      style: TextStyle(color: Colors.red),
                    ),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
            const Divider(),
            Expanded(
              child: BlocBuilder<TaskCubit, TaskState>(
                builder: (context, state) {
                  final cubit = context.read<TaskCubit>();

                  switch (state.status) {
                    case TaskListStatus.loading:
                      return const Center(child: CircularProgressIndicator());

                    case TaskListStatus.loaded:
                    case TaskListStatus.submitting:
                    case TaskListStatus.submitted:
                      if (state.tasks.isEmpty) {
                        return const Center(child: Text("No tasks yet"));
                      }
                      return ListView.builder(
                        itemCount: state.tasks.length,
                        itemBuilder: (context, index) {
                          final task = state.tasks[index];
                          return CustomTile(task: task, cubit: cubit);
                        },
                      );

                    case TaskListStatus.error:
                      return Center(
                          child: Text("Error: ${state.errorMessage}"));
                  }
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async {
          final cubit = context.read<TaskCubit>();
          final result = await Navigator.pushNamed(context, AppRoutes.taskForm);
          if (result == true) {
            cubit.loadTasks();
          }
        },
      ),
    );
  }
}
