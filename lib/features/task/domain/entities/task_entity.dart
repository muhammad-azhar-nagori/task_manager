import 'package:equatable/equatable.dart';

class TaskEntity extends Equatable {
  final String id;
  final String title;
  final String? description;
  final bool isDone;
  final DateTime createdAt;

  const TaskEntity({
    required this.id,
    required this.title,
    this.description,
    this.isDone = false,
    required this.createdAt,
  });

  @override
  List<Object?> get props => [id, title, description, isDone, createdAt];
}
