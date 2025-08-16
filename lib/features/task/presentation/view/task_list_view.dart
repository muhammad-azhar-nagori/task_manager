import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_task_manager/core/routes/app_routes.dart';
import 'package:mini_task_manager/features/task/presentation/cubit/task_list_cubit.dart';

class TaskListView extends StatelessWidget {
  const TaskListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Tasks"),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => context.read<TaskListCubit>().loadTasks(),
          )
        ],
      ),
      body: BlocBuilder<TaskListCubit, TaskListState>(
        builder: (context, state) {
          if (state is TaskListLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is TaskListLoaded) {
            if (state.tasks.isEmpty) {
              return const Center(child: Text("No tasks yet"));
            }
            return ListView.builder(
              itemCount: state.tasks.length,
              itemBuilder: (context, index) {
                final task = state.tasks[index];
                return ListTile(
                  title: Text(
                    task.title,
                    style: TextStyle(
                      decoration: task.isDone
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                    ),
                  ),
                  subtitle:
                      task.description != null ? Text(task.description!) : null,
                  leading: Checkbox(
                    value: task.isDone,
                    onChanged: (_) =>
                        context.read<TaskListCubit>().toggleTaskStatus(task),
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () =>
                        context.read<TaskListCubit>().removeTask(task.id),
                  ),
                );
              },
            );
          } else if (state is TaskListError) {
            return Center(child: Text("Error: ${state.message}"));
          }
          return const SizedBox.shrink();
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async {
          final result = await Navigator.pushNamed(context, AppRoutes.taskForm);
          if (result == true) {
            context.read<TaskListCubit>().loadTasks();
          }
        },
      ),
    );
  }
}
