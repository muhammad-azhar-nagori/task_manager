part of 'task_cubit.dart';

enum TaskListStatus { loading, loaded, submitting, submitted, error }

class TaskState {
  final TaskListStatus status;
  final List<TaskEntity> tasks;
  final String? errorMessage;

  const TaskState({
    this.status = TaskListStatus.loading,
    this.tasks = const [],
    this.errorMessage,
  });

  TaskState copyWith({
    TaskListStatus? status,
    List<TaskEntity>? tasks,
    String? errorMessage,
  }) {
    return TaskState(
      status: status ?? this.status,
      tasks: tasks ?? this.tasks,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
