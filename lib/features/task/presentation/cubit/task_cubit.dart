import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_task_manager/features/task/domain/entities/task_entity.dart';
import 'package:mini_task_manager/features/task/domain/usecases/delete_task.dart';
import 'package:mini_task_manager/features/task/domain/usecases/get_tasks.dart';
import 'package:mini_task_manager/features/task/domain/usecases/toggle_task_status.dart';
part 'task_state.dart';

class TaskListCubit extends Cubit<TaskListState> {
  final GetTasks getTasks;
  final ToggleTaskStatus toggleTask;
  final DeleteTask deleteTask;

  TaskListCubit({
    required this.getTasks,
    required this.toggleTask,
    required this.deleteTask,
  }) : super(TaskListInitial());

  Future<void> loadTasks() async {
    emit(TaskListLoading());
    try {
      final tasks = await getTasks();
      emit(TaskListLoaded(tasks));
    } catch (e) {
      emit(TaskListError(e.toString()));
    }
  }

  Future<void> toggleTaskStatus(TaskEntity task) async {
    await toggleTaskStatus(task);
    await loadTasks();
  }

  Future<void> removeTask(String taskId) async {
    await deleteTask(taskId);
    await loadTasks();
  }
}
