import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/task_entity.dart';
import '../../domain/usecases/delete_task.dart';
import '../../domain/usecases/get_tasks.dart';
import '../../domain/usecases/toggle_task_status.dart';

part 'task_list_state.dart';

class TaskListCubit extends Cubit<TaskListState> {
  final GetTasks getTasksUseCase;
  final ToggleTaskStatus toggleTaskUseCase;
  final DeleteTask deleteTaskUseCase;

  TaskListCubit({
    required this.getTasksUseCase,
    required this.toggleTaskUseCase,
    required this.deleteTaskUseCase,
  }) : super(TaskListInitial());

  Future<void> loadTasks() async {
    emit(TaskListLoading());
    try {
      final tasks = await getTasksUseCase();
      emit(TaskListLoaded(tasks));
    } catch (e) {
      emit(TaskListError(e.toString()));
    }
  }

  Future<void> toggleTaskStatus(TaskEntity task) async {
    try {
      await toggleTaskUseCase(task.id, !task.isDone);
      await loadTasks();
    } catch (e) {
      emit(TaskListError(e.toString()));
    }
  }

  Future<void> removeTask(String taskId) async {
    try {
      await deleteTaskUseCase(taskId);
      await loadTasks();
    } catch (e) {
      emit(TaskListError(e.toString()));
    }
  }
}
