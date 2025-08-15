import '../entities/task_entity.dart';
import '../repositories/task_repository.dart';

class AddTask {
  final TaskRepository repository;
  AddTask(this.repository);

  Future<void> call(TaskEntity task) {
    return repository.addTask(task);
  }
}
