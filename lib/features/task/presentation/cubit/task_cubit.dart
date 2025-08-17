import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_task_manager/features/task/domain/entities/task_entity.dart';
import 'package:mini_task_manager/features/task/domain/usecases/add_task.dart';
import 'package:mini_task_manager/features/task/domain/usecases/delete_task.dart';
import 'package:mini_task_manager/features/task/domain/usecases/get_tasks.dart';
import 'package:mini_task_manager/features/task/domain/usecases/toggle_task_status.dart';

part 'task_state.dart';

class TaskCubit extends Cubit<TaskState> {
  final GetTasks? _getTasksUseCase;
  final ToggleTaskStatus? _toggleTaskUseCase;
  final DeleteTask? _deleteTaskUseCase;
  final AddTask? _addTaskUseCase;

  TaskCubit({
    GetTasks? getTasksUseCase,
    ToggleTaskStatus? toggleTaskUseCase,
    DeleteTask? deleteTaskUseCase,
    AddTask? addTaskUseCase,
  })  : _getTasksUseCase = getTasksUseCase,
        _toggleTaskUseCase = toggleTaskUseCase,
        _deleteTaskUseCase = deleteTaskUseCase,
        _addTaskUseCase = addTaskUseCase,
        super(const TaskState());

  Future<void> loadTasks() async {
    emit(state.copyWith(status: TaskListStatus.loading, errorMessage: null));
    try {
      final tasks = await _getTasksUseCase?.call();
      emit(state.copyWith(status: TaskListStatus.loaded, tasks: tasks));
    } catch (e) {
      emit(state.copyWith(
        status: TaskListStatus.error,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> removeTask(String taskId) async {
    try {
      // mark as deleting
      final updatedTasks = state.tasks
          .map((t) => t.id == taskId
              ? t.copyWith(status: SingleTaskStatus.deleting)
              : t)
          .toList();
      emit(state.copyWith(tasks: updatedTasks));

      await _deleteTaskUseCase?.call(taskId);

      final remainingTasks = updatedTasks.where((t) => t.id != taskId).toList();

      emit(
          state.copyWith(status: TaskListStatus.loaded, tasks: remainingTasks));
    } catch (e) {
      // revert to idle if failed
      final revertedTasks = state.tasks
          .map((t) =>
              t.id == taskId ? t.copyWith(status: SingleTaskStatus.idle) : t)
          .toList();
      emit(state.copyWith(
        status: TaskListStatus.error,
        errorMessage: e.toString(),
        tasks: revertedTasks,
      ));
    }
  }

  Future<void> toggleTaskStatus(TaskEntity task) async {
    try {
      final updatedTasks = state.tasks
          .map((t) => t.id == task.id
              ? t.copyWith(status: SingleTaskStatus.toggling)
              : t)
          .toList();
      emit(state.copyWith(tasks: updatedTasks));

      await _toggleTaskUseCase?.call(task.id, !task.isDone);

      final toggledTasks = updatedTasks.map((t) {
        if (t.id == task.id) {
          return t.copyWith(
            isDone: !t.isDone,
            status: SingleTaskStatus.idle,
          );
        }
        return t;
      }).toList();

      emit(state.copyWith(status: TaskListStatus.loaded, tasks: toggledTasks));
    } catch (e) {
      final revertedTasks = state.tasks
          .map((t) =>
              t.id == task.id ? t.copyWith(status: SingleTaskStatus.idle) : t)
          .toList();
      emit(state.copyWith(
        status: TaskListStatus.error,
        errorMessage: e.toString(),
        tasks: revertedTasks,
      ));
    }
  }

  Future<void> submitTask(TaskEntity task) async {
    emit(state.copyWith(status: TaskListStatus.submitting, errorMessage: null));
    try {
      await _addTaskUseCase?.call(task);
      final tasks = await _getTasksUseCase?.call();
      emit(state.copyWith(status: TaskListStatus.submitted, tasks: tasks));
    } catch (e) {
      emit(state.copyWith(
        status: TaskListStatus.error,
        errorMessage: e.toString(),
      ));
    }
  }
}
