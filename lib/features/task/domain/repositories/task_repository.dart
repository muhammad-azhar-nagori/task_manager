import 'package:mini_task_manager/features/task/domain/entities/task_entity.dart';

abstract class TaskRepository {
  Future<void> addTask(TaskEntity task);
  Future<List<TaskEntity>> getTasks();
  Future<void> toggleTaskStatus(String taskId, bool isDone);
  Future<void> deleteTask(String taskId);
}
