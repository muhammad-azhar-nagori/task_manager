import 'package:equatable/equatable.dart';

enum SingleTaskStatus { idle, deleting, toggling }

class TaskEntity extends Equatable {
  final String id;
  final String title;
  final String? description;
  final bool isDone;
  final DateTime createdAt;
  final SingleTaskStatus status;

  const TaskEntity({
    required this.id,
    required this.title,
    this.description,
    this.isDone = false,
    required this.createdAt,
    this.status = SingleTaskStatus.idle,
  });

  TaskEntity copyWith({
    String? id,
    String? title,
    String? description,
    bool? isDone,
    DateTime? createdAt,
    SingleTaskStatus? status,
  }) {
    return TaskEntity(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      isDone: isDone ?? this.isDone,
      createdAt: createdAt ?? this.createdAt,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props =>
      [id, title, description, isDone, createdAt, status];
}
