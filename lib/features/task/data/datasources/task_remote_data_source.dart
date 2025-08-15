import 'package:mini_task_manager/core/services/network/firebase_firestore_service.dart';
import '../models/task_model.dart';

class TaskRemoteDataSource {
  final FirestoreService firestoreService;
  String path = 'tasks';
  TaskRemoteDataSource({required this.firestoreService});

  Future<void> addTask(TaskModel task) async {
    await firestoreService.setDocument(
      path: path,
      docId: task.id,
      data: task.toMap(),
    );
  }

  Future<List<TaskModel>> getTasks() async {
    final snapshot = await firestoreService.getCollection(path: path);
    return snapshot.docs
        .map((doc) => TaskModel.fromMap(doc.data(), doc.id))
        .toList();
  }

  Future<void> toggleTaskStatus(String taskId, bool isDone) async {
    await firestoreService.updateDocument(
      docId: taskId,
      path: path,
      data: {'isDone': isDone},
    );
  }

  Future<void> deleteTask(String taskId) async {
    await firestoreService.deleteDocument(
      path: path,
      docId: taskId,
    );
  }
}
