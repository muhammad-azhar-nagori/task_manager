# Mini Task Manager – App Explanation

## 1. App Structure

The Mini Task Manager app is built following **Clean Code Architecture** with separate layers to maintain clear separation of concerns.

### Domain Layer
- **Entities:** Core objects such as `TaskEntity` with properties `title`, `description`, `isDone`, and `createdAt`.  
- **Use Cases:** Business logic operations like `AddTask`, `DeleteTask`, `ToggleTask`, and `GetTasks`.  
- **Repositories (Abstract):** Define interfaces for data operations, ensuring the domain layer does not depend on implementation details.  

### Data Layer
- **Models:** Convert Firestore data into Dart objects (`TaskModel`).  
- **Repositories (Implementation):** Concrete implementations of the abstract repositories defined in the domain layer.  
- **Data Sources / Services:** Responsible for interacting directly with Firebase Firestore through a `FirestoreService` class, which handles all CRUD operations with the database.  

### Presentation Layer
- **Cubit/State Management:** BLoC Cubit manages authentication state, task list state, and add/edit task operations.  
- **Views/Screens:** Includes Login, Register, Task List, Add/Edit Task, and Dashboard.  
- **Widgets:** Reusable components such as TaskCard, Loading indicators, and Form widgets.  

---

## 2. Firebase Configuration

Firebase is integrated using **FlutterFire CLI**, which generates a `firebase_options.dart` file for project configuration.

- **Authentication:** Firebase Auth is used for email/password registration and login.  
- **Firestore:** Tasks are stored under each user’s UID with the following fields:
  - `title` (String, required)  
  - `description` (String, optional)  
  - `isDone` (bool, default false)  
  - `createdAt` (Timestamp)  
- **Initialization in `main.dart`:**
```dart
await Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform,
);
