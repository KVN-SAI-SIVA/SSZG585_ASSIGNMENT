# 📱 Task Admin App

> A modern Flutter-based task management application with Back4App cloud backend integration

[![Flutter](https://img.shields.io/badge/Flutter-3.0+-blue.svg)](https://flutter.dev/)
[![Back4App](https://img.shields.io/badge/Backend-Back4App-green.svg)](https://www.back4app.com/)
<!--
README for Task Admin
This README was created by merging local changes with the remote repository.
The document below is the canonical project README for the Task Admin application.
-->

# 📱 Task Admin

> A modern Flutter-based Task Admin application with Back4App cloud backend integration

[![Flutter](https://img.shields.io/badge/Flutter-3.0+-blue.svg)](https://flutter.dev/)
[![Back4App](https://img.shields.io/badge/Backend-Back4App-green.svg)](https://www.back4app.com/)
[![License](https://img.shields.io/badge/license-MIT-purple.svg)](LICENSE)

## 📋 Table of Contents

- [Overview](#overview)
- [Features](#features)
- [Screenshots](#screenshots)
- [Technology Stack](#technology-stack)
- [Project Structure](#project-structure)
- [Getting Started](#getting-started)
- [Back4App Setup](#back4app-setup)
- [Running the App](#running-the-app)
- [Usage Guide](#usage-guide)
- [API Documentation](#api-documentation)
- [Assignment Information](#assignment-information)
- [License](#license)

## 🎯 Overview

Task Admin is a full-featured CRUD (Create, Read, Update, Delete) application built with Flutter that demonstrates the power of Backend-as-a-Service (BaaS) using Back4App. The app provides a seamless task management experience with cloud synchronization, user authentication, and a modern, intuitive interface.
Task Admin is a full-featured CRUD (Create, Read, Update, Delete) application built with Flutter that demonstrates the power of Backend-as-a-Service (BaaS) using Back4App. The app provides a seamless task management experience with cloud synchronization, user authentication, and a modern, intuitive interface.

### Why This Project?

- **No Backend Coding Required:** Back4App handles all server-side operations
- **Real-time Synchronization:** Changes sync automatically across devices
- **Secure Authentication:** Built-in user management and session handling
- **Production-Ready:** Scalable architecture suitable for real-world applications
- **Learning Focused:** Perfect for understanding BaaS integration and Flutter development

## ✨ Features

### 🔐 Authentication
- User registration with email validation
- Secure login/logout functionality
- Persistent session management
- Password validation (minimum 6 characters)

### ✅ Task Management (CRUD)
- **Create:** Add new tasks with title and description
- **Read:** View all tasks in an organized list
- **Update:** Edit existing task details
- **Delete:** Remove tasks with confirmation dialog
- **Toggle:** Mark tasks as complete/incomplete

### 🔍 Additional Features
- Real-time search functionality
- Pull-to-refresh task list
- Task completion status indicators
- Timestamp tracking (created/updated dates)
- User-specific task isolation
- Responsive Material Design UI
- Splash screen with auth state check

## 📸 Screenshots

> **Note:** Add screenshots here after running the app. Recommended screenshots:
> - Splash screen
> - Login screen
> - Register screen
> - Home screen with tasks
> - Add task screen
> - Edit task screen
> - Task deletion confirmation

## 🛠 Technology Stack

### Frontend
- **Framework:** Flutter 3.0+
- **Language:** Dart
- **UI:** Material Design 3
- **State Management:** Provider pattern

### Backend (BaaS)
- **Service:** Back4App
- **Platform:** Parse Server
- **Database:** Cloud-based (automatically managed)
- **Authentication:** Parse Authentication System

### Dependencies
```yaml
dependencies:
  parse_server_sdk_flutter: ^6.0.0  # Back4App integration
  provider: ^6.0.5                   # State management
  http: ^1.1.0                       # HTTP requests
  shared_preferences: ^2.2.2         # Local storage
  intl: ^0.18.1                      # Date formatting
```

## 📁 Project Structure

```
task_manager_app/
├── lib/
│   ├── main.dart                      # App entry point
│   ├── models/
│   │   └── task.dart                  # Task data model
│   ├── screens/
│   │   ├── login_screen.dart          # Login UI
│   │   ├── register_screen.dart       # Registration UI
│   │   ├── home_screen.dart           # Task list view
│   │   └── add_edit_task_screen.dart  # Task form
│   ├── services/
│   │   ├── back4app_config.dart       # Backend configuration
│   │   ├── auth_service.dart          # Authentication logic
│   │   └── task_service.dart          # CRUD operations
│   └── widgets/
│       └── task_card.dart             # Task list item widget
├── android/                           # Android configuration
├── ios/                               # iOS configuration
├── pubspec.yaml                       # Dependencies
├── README.md                          # This file
├── QUICKSTART.md                      # Quick setup guide
├── BACK4APP_SETUP.md                  # Detailed Back4App guide
├── PROJECT_GUIDE.md                   # Presentation guide
└── CHANGELOG.md                       # Version history
```

## 🚀 Getting Started

### Prerequisites

Before you begin, ensure you have the following installed:

- ✅ [Flutter SDK](https://flutter.dev/docs/get-started/install) (3.0 or higher)
- ✅ [Dart SDK](https://dart.dev/get-dart) (comes with Flutter)
- ✅ [Android Studio](https://developer.android.com/studio) or [Xcode](https://developer.apple.com/xcode/)
- ✅ A [Back4App account](https://www.back4app.com/) (free tier available)
- ✅ Git (for version control)

### Quick Check

Verify your Flutter installation:

```bash
flutter doctor
```

## 🔧 Back4App Setup

### Quick Setup (5 minutes)

1. **Create Account:** Sign up at [back4app.com](https://www.back4app.com/)
2. **Create App:** Click "Build a new app" → Select "Parse"
3. **Get Credentials:**
   - Navigate to: App Settings → Security & Keys
   - Copy: Application ID and Client Key
4. **Configure App:**
   - Open: `lib/services/back4app_config.dart`
   - Replace `YOUR_APP_ID_HERE` with your Application ID
   - Replace `YOUR_CLIENT_KEY_HERE` with your Client Key

📖 For detailed instructions, see [BACK4APP_SETUP.md](BACK4APP_SETUP.md)

## ▶️ Running the App

### Step 1: Install Dependencies

```bash
flutter pub get
```

### Step 2: Configure Back4App

Edit `lib/services/back4app_config.dart` with your credentials.

### Step 3: Run the App

```bash
flutter run
```

### Build for Release

```bash
# Android APK
flutter build apk --release

# iOS (macOS only)
flutter build ios --release
```

## 📱 Usage Guide

### First Time Setup

1. **Register:**
   - Click "Register" button
   - Enter username (min 3 characters)
   - Enter student email
   - Create password (min 6 characters)
2. **Login:** Use your credentials to log in

### Managing Tasks

- **Create:** Tap "+ Add Task" button
- **Edit:** Tap on any task card
- **Complete:** Tap the checkbox
- **Delete:** Tap the delete icon (🗑️)
- **Search:** Use the search bar at the top
- **Refresh:** Pull down to refresh

## 📚 API Documentation

### AuthService

```dart
// Register
await AuthService.registerUser(
  username: 'john_doe',
  email: 'john@example.com',
  password: 'secure123',
);

// Login
await AuthService.loginUser(
  email: 'john@example.com',
  password: 'secure123',
);

// Logout
await AuthService.logoutUser();
```

### TaskService

```dart
// Create
await TaskService.createTask(
  title: 'Complete assignment',
  description: 'Finish Flutter project',
);

// Read
List<Task> tasks = await TaskService.getAllTasks();

// Update
await TaskService.updateTask(
  task: myTask,
  title: 'New title',
);

// Delete
await TaskService.deleteTask(myTask);

// Toggle
await TaskService.toggleTaskCompletion(myTask);

// Search
List<Task> results = await TaskService.searchTasks('flutter');
```

## 🎓 Assignment Information

### Deliverables

1. **YouTube Video (2 minutes)** - Demo of all features
2. **GitHub Repository** - Complete source code
3. **PPT Presentation** - Project explanation
4. **Submission** - Via Taxila platform

### Features Demonstrated

✅ User registration with student email  
✅ User login  
✅ Task creation  
✅ Task viewing (READ)  
✅ Task updating (EDIT)  
✅ Task deletion  
✅ Real-time sync with Back4App  
✅ Secure logout  

### Learning Objectives

- Backend-as-a-Service (BaaS) integration
- Flutter app development
- Cloud database usage
- User authentication
- CRUD operations
- UI/UX design

## 📄 License

This project is licensed under the MIT License.

## 🙏 Acknowledgments

- **Flutter Team** - For the amazing framework
- **Back4App** - For providing free BaaS
- **Parse Platform** - For the robust backend solution

## 📞 Contact

For questions or support:
- 📧 Email: your.email@example.com
- 🐙 GitHub: [@yourusername](https://github.com/yourusername)

### Useful Resources

- [Flutter Documentation](https://flutter.dev/docs)
- [Back4App Docs](https://www.back4app.com/docs/)
- [Parse SDK Guide](https://docs.parseplatform.org/)
- [QUICKSTART.md](QUICKSTART.md) - Quick setup guide
- [PROJECT_GUIDE.md](PROJECT_GUIDE.md) - Presentation guide

---

<div align="center">

**Made with ❤️ using Flutter and Back4App**

⭐ Star this repo if you found it helpful!

</div>
