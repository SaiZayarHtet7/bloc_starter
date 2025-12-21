# Bloc Starter - Flutter Clean Architecture

A production-ready Flutter application demonstrating Clean Architecture principles with BLoC state management.

## 🏗️ Architecture Overview

This project follows **Clean Architecture** with a **feature-first** approach, ensuring:
- Clear separation of concerns
- High testability
- Maintainability and scalability
- Independence of frameworks and external dependencies

### Project Structure

```
lib/
├── core/
│   ├── network/
│   │   ├── api_exception.dart
│   │   └── base_dio_client.dart          # Dio HTTP client wrapper
│   ├── theme/
│   │   ├── app_theme.dart                # Light/Dark theme definitions
│   │   ├── theme_cubit.dart              # Theme state management
│   │   └── theme_state.dart
│   ├── router/
│   │   └── app_router.dart               # GoRouter configuration
│   ├── di/
│   │   ├── injection.dart                # Dependency injection setup
│   │   └── injection.config.dart         # Generated DI code
│   └── l10n/
│       └── app_localizations.dart        # Generated localization
├── features/
│   └── counter/
│       ├── presentation/
│       │   ├── cubit/
│       │   │   ├── counter_cubit.dart
│       │   │   └── counter_state.dart
│       │   ├── pages/
│       │   │   └── counter_page.dart
│       │   └── widgets/
│       │       ├── counter_display.dart
│       │       └── counter_controls.dart
│       ├── domain/
│       │   ├── entities/
│       │   │   └── counter_entity.dart
│       │   ├── repositories/
│       │   │   └── counter_repository.dart
│       │   └── usecases/
│       │       ├── get_counter_usecase.dart
│       │       ├── increment_counter_usecase.dart
│       │       ├── decrement_counter_usecase.dart
│       │       └── reset_counter_usecase.dart
│       └── data/
│           ├── datasources/
│           │   ├── counter_local_datasource.dart
│           │   └── counter_remote_datasource.dart
│           ├── models/
│           │   └── counter_model.dart
│           └── repositories/
│               └── counter_repository_impl.dart
└── main.dart
```

## 🎯 Core Principles

### SOLID Principles
- **S**ingle Responsibility: Each class has one reason to change
- **O**pen/Closed: Open for extension, closed for modification
- **L**iskov Substitution: Subtypes must be substitutable for base types
- **I**nterface Segregation: Many specific interfaces over one general
- **D**ependency Inversion: Depend on abstractions, not concretions

### DRY (Don't Repeat Yourself)
- Reusable components and utilities
- Shared business logic in use cases
- Common UI widgets

### KISS (Keep It Simple, Stupid)
- Clear and readable code
- Avoid over-engineering
- Simple solutions to complex problems

## 🔧 Technology Stack

### State Management
- **flutter_bloc** (^8.1.6) - BLoC pattern implementation
- **equatable** (^2.0.5) - Value equality for state comparison

### Networking
- **dio** (^5.7.0) - HTTP client with interceptors
- **dartz** (^0.10.1) - Functional programming (Either type)

### Dependency Injection
- **get_it** (^8.0.2) - Service locator
- **injectable** (^2.5.0) - Code generation for DI

### Routing
- **go_router** (^14.6.2) - Declarative routing

### Local Storage
- **shared_preferences** (^2.3.3) - Persistent key-value storage

### Localization
- **flutter_localizations** - Multi-language support
- **intl** - Internationalization

## 📚 Feature: Counter

The counter feature demonstrates the complete Clean Architecture implementation:

### Domain Layer
- **Entity**: `CounterEntity` - Pure business object
- **Repository Interface**: `CounterRepository` - Contract for data operations
- **Use Cases**: 
  - `GetCounterUseCase`
  - `IncrementCounterUseCase`
  - `DecrementCounterUseCase`
  - `ResetCounterUseCase`

### Data Layer
- **Models**: `CounterModel` - Data transfer object
- **Data Sources**:
  - `CounterLocalDataSource` - SharedPreferences operations
  - `CounterRemoteDataSource` - API calls (demo with JSONPlaceholder)
- **Repository Implementation**: `CounterRepositoryImpl`

### Presentation Layer
- **Cubit**: `CounterCubit` - State management
- **States**: Initial, Loading, Loaded, Error
- **Pages**: `CounterPage` - Main UI
- **Widgets**: Reusable UI components

## 🎨 Theme Management

The app supports three theme modes:
- **Light Mode** - Optimized for daylight viewing
- **Dark Mode** - Comfortable for low-light environments
- **System Mode** - Follows device settings

Theme preference is persisted using SharedPreferences.

## 🌍 Localization

Currently supports:
- **English (en)**
- **Myanmar/Burmese (my)**

### Adding New Language

1. Create `lib/l10n/app_{locale}.arb`
2. Add translations following the English template
3. Run `flutter gen-l10n`
4. Add locale to `supportedLocales` in main.dart

## 🚀 Getting Started

### Prerequisites
- Flutter SDK ≥ 3.10.1
- Dart SDK ≥ 3.10.1

### Installation

1. **Clone and install dependencies:**
```bash
flutter pub get
```

2. **Generate code:**
```bash
# Generate dependency injection code
dart run build_runner build --delete-conflicting-outputs

# Generate localization files
flutter gen-l10n
```

3. **Run the app:**
```bash
flutter run
```

## 🧪 Testing

```bash
# Run all tests
flutter test

# Run with coverage
flutter test --coverage
```

## 🏗️ Building

### Android
```bash
flutter build apk --release
flutter build appbundle --release
```

### iOS
```bash
flutter build ios --release
```

### Web
```bash
flutter build web --release
```

## 📦 Dependency Injection

This project uses `get_it` with `injectable` for automatic DI code generation:

```dart
// Register dependencies
await configureDependencies();

// Resolve dependencies
final cubit = getIt<CounterCubit>();
```

All dependencies are automatically registered based on annotations:
- `@injectable` - Factory (new instance each time)
- `@lazySingleton` - Singleton (created on first use)
- `@singleton` - Singleton (created immediately)

## 🔄 Data Flow

```
UI (Widget)
    ↓
Cubit (State Management)
    ↓
Use Case (Business Logic)
    ↓
Repository Interface
    ↓
Repository Implementation
    ↓
Data Sources (Local/Remote)
```

## 🎯 Key Features

### Network Layer
- Centralized HTTP client with Dio
- Request/Response interceptors
- Error handling with custom exceptions
- Type-safe API calls

### Error Handling
- `Either<Exception, Result>` pattern from dartz
- Graceful error states in UI
- Retry mechanisms

### State Management
- Predictable state changes with BLoC
- Separation of business logic from UI
- Reactive UI updates

## 📝 Code Style

This project follows:
- [Effective Dart](https://dart.dev/guides/language/effective-dart)
- Flutter best practices
- Clean Code principles

## 🤝 Contributing

1. Follow the existing architecture patterns
2. Write tests for new features
3. Update documentation
4. Use meaningful commit messages

## 📄 License

This project is licensed under the MIT License.

## 🙏 Acknowledgments

- Clean Architecture by Robert C. Martin
- Flutter BLoC library by Felix Angelov
- Flutter team for excellent documentation

---

**Made with ❤️ using Flutter and Clean Architecture**
