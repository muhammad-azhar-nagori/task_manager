import 'package:flutter/material.dart';
import '../../data/models/task_model.dart';

class TaskItemWidget extends StatelessWidget {
  final TaskModel task;
  const TaskItemWidget({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(task.title),
      subtitle: Text(task.description ?? ''),
      trailing: Icon(
        task.isDone ? Icons.check_circle : Icons.radio_button_unchecked,
        color: task.isDone ? Colors.green : Colors.grey,
      ),
    );
  }
}
