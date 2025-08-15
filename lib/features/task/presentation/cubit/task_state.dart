part of 'task_cubit.dart';

abstract class TaskListState {}

class TaskListInitial extends TaskListState {}

class TaskListLoading extends TaskListState {}

class TaskListLoaded extends TaskListState {
  final List<TaskEntity> tasks;
  TaskListLoaded(this.tasks);
}

class TaskListError extends TaskListState {
  final String message;
  TaskListError(this.message);
}
