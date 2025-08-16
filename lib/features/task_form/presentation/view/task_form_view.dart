import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:mini_task_manager/features/task/domain/entities/task_entity.dart';
import '../cubit/task_form_cubit.dart';

class TaskFormView extends StatelessWidget {
  final TaskEntity? task; // null for add, not null for edit
  final _formKey = GlobalKey<FormBuilderState>();

  TaskFormView({super.key, this.task});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(task == null ? "Add Task" : "Edit Task"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: FormBuilder(
          key: _formKey,
          child: Column(
            children: [
              FormBuilderTextField(
                name: 'title',
                initialValue: task?.title ?? '',
                decoration: const InputDecoration(labelText: 'Title'),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(),
                  FormBuilderValidators.minLength(3),
                ]),
              ),
              FormBuilderTextField(
                name: 'description',
                initialValue: task?.description ?? '',
                decoration: const InputDecoration(labelText: 'Description'),
                validator: FormBuilderValidators.maxLength(200),
              ),
              const SizedBox(height: 20),
              BlocConsumer<TaskFormCubit, TaskFormState>(
                listener: (context, state) {
                  if (state is TaskFormError) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(state.message)),
                    );
                  } else if (state is TaskFormSuccess) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(task == null
                            ? 'Task added successfully'
                            : 'Task updated successfully'),
                      ),
                    );
                    Navigator.pop(context, true);
                  }
                },
                builder: (context, state) {
                  if (state is TaskFormLoading) {
                    return const CircularProgressIndicator();
                  }
                  return ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.saveAndValidate()) {
                        final values = _formKey.currentState!.value;
                        final newTask = TaskEntity(
                          id: task?.id ??
                              DateTime.now().millisecondsSinceEpoch.toString(),
                          title: values['title'],
                          description: values['description'],
                          isDone: task?.isDone ?? false,
                          createdAt: task?.createdAt ?? DateTime.now(),
                        );
                        context.read<TaskFormCubit>().submitTask(newTask);
                      }
                    },
                    child: Text(task == null ? 'Add Task' : 'Update Task'),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
