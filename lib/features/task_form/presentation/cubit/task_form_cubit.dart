import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_task_manager/features/task/domain/entities/task_entity.dart';
import 'package:mini_task_manager/features/task/domain/usecases/add_task.dart';

part 'task_form_state.dart';

class TaskFormCubit extends Cubit<TaskFormState> {
  final AddTask addTaskUseCase;

  TaskFormCubit({required this.addTaskUseCase}) : super(TaskFormInitial());

  Future<void> submitTask(TaskEntity task) async {
    emit(TaskFormLoading());
    try {
      await addTaskUseCase(task);
      emit(TaskFormSuccess());
    } catch (e) {
      emit(TaskFormError(e.toString()));
    }
  }
}
