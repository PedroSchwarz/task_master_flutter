# Task Master

A comprehensive task management application built with Flutter, designed for collaborative team productivity. Task Master enables users to organize tasks within groups, track progress, and collaborate in real-time.

## Features

### 🔐 Authentication
- User registration and login
- Secure credential storage
- Session management

### 👥 Groups & Collaboration
- Create and manage task groups
- Invite team members via invitation system
- Group color customization
- Member management
- View tasks by ownership or assignment

### ✅ Task Management
- **Create & Edit Tasks**: Full CRUD operations for tasks
- **Task Details**: Title, description, due dates, priorities, and status
- **Task Assignment**: Assign tasks to group members
- **Task Status**: To Do, In Progress, Done
- **Priority Levels**: Low, Medium, High
- **Task Filtering**: Filter by assignee, completion status, priority, and date
- **Task Sorting**: Sort by date (newest/oldest) and priority (highest/lowest)
- **Checklists**: Add checklist items to tasks
- **Recurring Tasks**: Set up daily, weekly, or monthly recurring tasks
- **Task Duplication**: Duplicate existing tasks
- **Calendar & List Views**: Switch between calendar and list views

### 💬 Comments
- Add comments to tasks
- Real-time comment updates
- View comment history

### 📊 Dashboard & Analytics
- **Dashboard Overview**: Quick access to all groups and tasks
- **Completion Summary**: Track task completion statistics
- **Overdue Summary**: Monitor overdue tasks
- **Priority & Status Summaries**: Visual breakdowns of task distribution
- **Upcoming Tasks**: View tasks due soon
- **Highlights**: Key metrics and insights

### 📈 Progress Tracking
- Visual progress charts and analytics
- Track task completion over time periods (1 month, 3 months, 6 months, 1 year)
- Weekly progression tracking
- Task completion trends

### 🔔 Notifications
- Push notifications via Firebase Cloud Messaging
- Local notifications for task reminders
- Real-time updates for task and group changes

### 🌐 Internationalization
- Multi-language support (English, Portuguese)
- Localized UI and content

### 🎨 User Experience
- Dark mode support
- Modern, responsive UI design
- Smooth animations and transitions
- Custom design system with consistent theming

## Architecture

Task Master follows **Clean Architecture** principles with a feature-based modular structure:

### Architecture Patterns
- **BLoC Pattern**: State management using `flutter_bloc`
- **Repository Pattern**: Abstraction layer between data sources and business logic
- **Dependency Injection**: Service locator pattern with `get_it`
- **Feature Modules**: Organized by domain (auth, tasks, groups, comments, etc.)

### Project Structure
```
lib/
├── app/              # Core app configuration, DI, design system
├── auth/             # Authentication module
├── tasks/            # Task management module
├── groups/           # Group management module
├── comments/         # Comments module
├── dashboard/        # Dashboard module
├── progress/         # Progress tracking module
├── invites/          # Invitation system
├── notifications/    # Push notifications
└── users/            # User management
```

### Data Flow
- **Remote Data Sources**: REST API communication via Dio/Retrofit
- **Local Data Sources**: Persistent storage with SharedPreferences and FlutterSecureStorage
- **WebSocket**: Real-time updates for tasks, groups, and comments
- **Repositories**: Combine remote and local data sources
- **Cubits/BLoCs**: Business logic and state management
- **UI**: Reactive widgets that respond to state changes

## Main Packages

### State Management & Architecture
- **flutter_bloc** (^9.1.1): State management using BLoC pattern
- **get_it** (^9.1.1): Dependency injection and service locator
- **freezed** (^3.2.3): Immutable data classes and union types

### Navigation
- **go_router** (^17.0.0): Declarative routing and navigation

### Networking
- **dio** (^5.9.0): HTTP client for API calls
- **retrofit** (^4.9.1): Type-safe REST client generator
- **socket_io_client** (^3.1.2): WebSocket client for real-time updates
- **rxdart** (^0.28.0): Reactive extensions for Dart streams

### Storage
- **flutter_secure_storage** (^9.2.4): Secure credential storage
- **shared_preferences** (^2.5.3): Local key-value storage

### Firebase
- **firebase_core** (^4.2.1): Firebase SDK initialization
- **firebase_messaging** (^16.0.4): Push notifications

### UI & Design
- **google_fonts** (^6.2.1): Custom typography
- **fl_chart** (^1.0.0): Beautiful charts and graphs
- **flutter_svg** (^2.1.0): SVG image support
- **flutter_animate** (^4.5.2): Animation utilities
- **gap** (^3.0.1): Spacing utilities
- **calendar_pager**: Custom calendar widget (from GitHub)

### Notifications
- **flutter_local_notifications** (^19.2.0): Local notification support

### Internationalization
- **intl** (^0.20.2): Internationalization and localization
- **flutter_localizations**: Flutter localization support

### Utilities
- **uuid** (^4.5.1): UUID generation
- **logging** (^1.3.0): Logging utilities
- **collection** (^1.19.1): Collection utilities

### Code Generation
- **build_runner**: Code generation runner
- **json_serializable**: JSON serialization
- **retrofit_generator**: Retrofit code generation

## Getting Started

### Prerequisites
- Flutter SDK (>=3.10.0 <4.0.0)

### Project Structure
Each feature module follows a consistent structure:
- `data/`: Data sources, models, repositories
- `ui/`: Cubits/BLoCs, views, and components
- `domain/`: Business logic and use cases (where applicable)

## Version

Current version: **1.0.10+1**

## License

This project is private and not licensed for public use.
