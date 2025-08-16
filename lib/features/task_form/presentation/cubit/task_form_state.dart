part of 'task_form_cubit.dart';

abstract class TaskFormState {}

class TaskFormInitial extends TaskFormState {}

class TaskFormLoading extends TaskFormState {}

class TaskFormSuccess extends TaskFormState {}

class TaskFormError extends TaskFormState {
  final String message;
  TaskFormError(this.message);
}
