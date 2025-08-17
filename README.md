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

### Dependency Injection
The app uses **`get_it`** for dependency injection. Services, repositories, and remote data sources are registered as singletons or factories:


## 2. Firebase Configuration

Firebase is integrated using **FlutterFire CLI**, which generates a `firebase_options.dart` file for project configuration.

- **Authentication:** Firebase Auth is used for email/password registration and login.  
- **Firestore:** Tasks are stored under each user’s UID with the following fields:
  - `title` (String, required)  
  - `description` (String, optional)  
  - `isDone` (bool, default false)  
  - `createdAt` (Timestamp)  
- **Initialization in `main.dart`:**

The firebase_options.dart file contains API keys for Android and iOS. These keys are safe to commit to version control.

3. Features
Authentication

User registration and login using Firebase Auth.

Logout functionality.

Task Management

Add, edit, delete, and toggle tasks.

Tasks are displayed in a list with title, description, status, and creation date.

Task list updates appropriately after any operation.

Forms

Built using flutter_form_builder.

Validation rules:

Title: required, minimum length 3.

Description: optional, maximum length 200.

Dashboard / Task List

After login, a random quote or joke fetched from a public API is displayed at the top of the task list screen.

Below the quote, all tasks for the logged-in user are listed.

State Management

BLoC Cubit is used for all global state management.

4. Challenges Faced
Adapting to BLoC/Cubit:
Coming from a Stacked state management, learning Cubit patterns for state management was an adjustment, especially for coordinating task add, edit, toggle, and delete operations.

Task-specific Loading States:
Showing a loading indicator on a single task (e.g., when deleting) required minor adjustments to the state structure.
