import 'package:flutter/material.dart';
import 'package:mini_task_manager/core/routes/app_routes.dart';
import 'package:mini_task_manager/features/task/domain/entities/task_entity.dart';
import 'package:mini_task_manager/features/task/presentation/cubit/task_cubit.dart';

class CustomTile extends StatelessWidget {
  const CustomTile({
    super.key,
    required this.task,
    required this.cubit,
  });

  final TaskEntity task;
  final TaskCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        task.status == SingleTaskStatus.toggling
            ? const SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(strokeWidth: 2),
              )
            : Checkbox(
                value: task.isDone,
                onChanged: (_) => cubit.toggleTaskStatus(task),
              ),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                task.title,
                style: TextStyle(
                  decoration: task.isDone
                      ? TextDecoration.lineThrough
                      : TextDecoration.none,
                ),
              ),
              if (task.description != null) Text(task.description!),
              Text(
                "Created at: ${task.createdAt.toLocal().toIso8601String()}",
                style: const TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ],
          ),
        ),
        const SizedBox(width: 8),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.edit, color: Colors.blue),
              onPressed: () async {
                final result = await Navigator.pushNamed(
                    context, AppRoutes.taskForm,
                    arguments: task);
                if (result == true) {
                  cubit.loadTasks();
                }
              },
            ),
            task.status == SingleTaskStatus.deleting
                ? const SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () => cubit.removeTask(task.id),
                  ),
          ],
        ),
      ],
    );
  }
}
