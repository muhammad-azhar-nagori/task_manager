import '../../domain/entities/task_entity.dart';
import '../../domain/repositories/task_repository.dart';
import '../datasources/task_remote_data_source.dart';
import '../models/task_model.dart';

class TaskRepositoryImpl implements TaskRepository {
  final TaskRemoteDataSource remoteDataSource;
  TaskRepositoryImpl(this.remoteDataSource);

  @override
  Future<void> addTask(TaskEntity task) {
    return remoteDataSource.addTask(
      TaskModel(
        id: task.id,
        title: task.title,
        description: task.description,
        isDone: task.isDone,
        createdAt: task.createdAt,
      ),
    );
  }

  @override
  Future<List<TaskEntity>> getTasks() async {
    return await remoteDataSource.getTasks();
  }

  @override
  Future<void> toggleTaskStatus(String taskId, bool isDone) {
    return remoteDataSource.toggleTaskStatus(taskId, isDone);
  }

  @override
  Future<void> deleteTask(String taskId) {
    return remoteDataSource.deleteTask(taskId);
  }
}
