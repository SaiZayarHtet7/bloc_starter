# bloc_starter

A Flutter Clean Architecture starter project with BLoC state management.

## 🏗️ Architecture

This project implements **Clean Architecture** with a **feature-first** approach:

```
┌─────────────────────────────────────────────────────────────┐
│                      PRESENTATION LAYER                      │
│  ┌────────────┐  ┌────────────┐  ┌────────────────────────┐ │
│  │   Pages    │  │  Widgets   │  │  Cubits (State Mgmt)   │ │
│  └────────────┘  └────────────┘  └────────────────────────┘ │
└─────────────────────────────────────────────────────────────┘
                            ↕
┌─────────────────────────────────────────────────────────────┐
│                       DOMAIN LAYER                           │
│  ┌────────────┐  ┌────────────┐  ┌────────────────────────┐ │
│  │  Entities  │  │ Use Cases  │  │  Repository Interface  │ │
│  └────────────┘  └────────────┘  └────────────────────────┘ │
└─────────────────────────────────────────────────────────────┘
                            ↕
┌─────────────────────────────────────────────────────────────┐
│                        DATA LAYER                            │
│  ┌────────────┐  ┌────────────┐  ┌────────────────────────┐ │
│  │   Models   │  │Data Sources│  │ Repository Impl        │ │
│  └────────────┘  └────────────┘  └────────────────────────┘ │
└─────────────────────────────────────────────────────────────┘
```

## ✨ Features

- ✅ **Clean Architecture** - Separation of concerns across layers
- ✅ **BLoC/Cubit** - Predictable state management
- ✅ **Dependency Injection** - Using get_it & injectable
- ✅ **Network Layer** - Dio with error handling
- ✅ **Routing** - Declarative routing with go_router
- ✅ **Theme Management** - Light/Dark/System modes with persistence
- ✅ **Localization** - Multi-language support (English & Myanmar)
- ✅ **Error Handling** - Functional approach with Dartz (Either type)

## 🚀 Quick Start

### Prerequisites
- Flutter SDK ≥ 3.10.1
- Dart SDK ≥ 3.10.1

### Installation

1. **Install dependencies:**
```bash
flutter pub get
```

2. **Generate code:**
```bash
# Generate dependency injection
dart run build_runner build --delete-conflicting-outputs

# Generate localization
flutter gen-l10n
```

3. **Run the app:**
```bash
flutter run
```

## 📁 Project Structure

```
lib/
├── core/                    # Core functionality
│   ├── network/            # HTTP client, error handling
│   ├── theme/              # Theme management
│   ├── router/             # Navigation
│   └── di/                 # Dependency injection
├── features/               # Feature modules
│   └── counter/
│       ├── presentation/   # UI, Cubits, Widgets
│       ├── domain/         # Business logic
│       └── data/           # Data sources, repositories
└── main.dart
```

## 🛠️ Tech Stack

| Purpose | Package |
|---------|---------|
| State Management | flutter_bloc, equatable |
| Networking | dio |
| Error Handling | dartz |
| Dependency Injection | get_it, injectable |
| Routing | go_router |
| Storage | shared_preferences |
| Localization | intl, flutter_localizations |

## 📖 Documentation

- [ARCHITECTURE.md](ARCHITECTURE.md) - Detailed architecture documentation
- [QUICKSTART.md](QUICKSTART.md) - Quick start guide and common commands
- [PROJECT_SUMMARY.md](PROJECT_SUMMARY.md) - Complete project summary

## 🎯 Example: Counter Feature

Demonstrates Clean Architecture implementation:

**Domain Layer:**
- Entity: Pure business object
- Use Cases: Business logic operations
- Repository: Abstract interface

**Data Layer:**
- Models: Data transfer objects
- Data Sources: Local (SharedPreferences) & Remote (API)
- Repository Implementation: Concrete data operations

**Presentation Layer:**
- Cubit: State management
- Pages: Screen widgets
- Widgets: Reusable UI components

## 🧪 Testing

```bash
# Run tests
flutter test

# With coverage
flutter test --coverage
```

## 🏗️ Building

```bash
# Android
flutter build apk --release

# iOS
flutter build ios --release

# Web
flutter build web --release
```

## 📝 Code Quality

```bash
# Format code
dart format lib/

# Analyze code
flutter analyze

# Fix issues
dart fix --apply
```

## 🤝 Contributing

Follow the existing architecture patterns:
1. Create features in `features/` directory
2. Maintain Clean Architecture layers
3. Use dependency injection
4. Write tests
5. Update documentation

## 📄 License

This project is licensed under the MIT License.

## 🙏 Acknowledgments

- Clean Architecture by Robert C. Martin
- Flutter BLoC library
- Flutter community

---

**Built with Flutter & Clean Architecture principles** 🚀


## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
