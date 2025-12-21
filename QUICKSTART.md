# Quick Start Guide - Bloc Starter

## 🚀 Setup Instructions

### 1. Install Dependencies
```bash
flutter pub get
```

### 2. Generate Required Code
```bash
# Generate dependency injection code
dart run build_runner build --delete-conflicting-outputs

# Generate localization files
flutter gen-l10n
```

### 3. Run the App
```bash
flutter run
```

## 🎮 Features to Try

1. **Counter Operations**
   - Tap "Increment" to increase the counter
   - Tap "Decrement" to decrease the counter
   - Tap "Reset" to reset to zero
   - Counter value persists across app restarts

2. **Theme Switching**
   - Tap the theme icon in the app bar
   - Choose between Light, Dark, or System theme
   - Theme preference is saved automatically

3. **Localization**
   - App supports English and Myanmar languages
   - Language follows system settings

## 📁 Project Organization

### Adding a New Feature

1. **Create feature folder:**
```
lib/features/your_feature/
├── presentation/
│   ├── cubit/
│   ├── pages/
│   └── widgets/
├── domain/
│   ├── entities/
│   ├── repositories/
│   └── usecases/
└── data/
    ├── datasources/
    ├── models/
    └── repositories/
```

2. **Add route in `app_router.dart`:**
```dart
GoRoute(
  path: '/your-feature',
  name: 'yourFeature',
  builder: (context, state) => YourFeaturePage(),
)
```

3. **Register dependencies:**
```dart
@injectable
class YourFeatureCubit extends Cubit<YourFeatureState> {
  // Implementation
}
```

4. **Regenerate code:**
```bash
dart run build_runner build --delete-conflicting-outputs
```

## 🔧 Common Commands

### Code Generation
```bash
# Watch mode (auto-rebuild on changes)
dart run build_runner watch --delete-conflicting-outputs

# One-time build
dart run build_runner build --delete-conflicting-outputs

# Clean previous builds
dart run build_runner clean
```

### Localization
```bash
# Generate localization files
flutter gen-l10n

# Add new language: create lib/l10n/app_{locale}.arb
# Then regenerate
```

### Testing
```bash
# Run all tests
flutter test

# Run specific test
flutter test test/features/counter_test.dart

# With coverage
flutter test --coverage
```

### Building
```bash
# Android APK
flutter build apk --release

# Android App Bundle (for Play Store)
flutter build appbundle --release

# iOS
flutter build ios --release

# Web
flutter build web --release
```

### Code Quality
```bash
# Format code
dart format lib/

# Analyze code
flutter analyze

# Fix common issues
dart fix --apply
```

## 🐛 Troubleshooting

### Build Runner Issues
```bash
# Clean and rebuild
flutter clean
flutter pub get
dart run build_runner clean
dart run build_runner build --delete-conflicting-outputs
```

### Localization Not Working
```bash
# Ensure l10n.yaml exists
# Regenerate localization
flutter gen-l10n
flutter clean
flutter run
```

### Dependency Injection Errors
```bash
# Check all classes have @injectable or @lazySingleton
# Regenerate DI code
dart run build_runner build --delete-conflicting-outputs
```

## 📚 Learning Resources

- [Flutter Documentation](https://flutter.dev/docs)
- [BLoC Documentation](https://bloclibrary.dev)
- [Clean Architecture Guide](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html)
- [Effective Dart](https://dart.dev/guides/language/effective-dart)

## 💡 Tips

1. **State Management**: Always keep business logic in Cubits, not in widgets
2. **Dependency Injection**: Use `@injectable` for factories, `@lazySingleton` for singletons
3. **Error Handling**: Use `Either<Exception, Result>` for all repository methods
4. **Testing**: Write tests for domain layer first (use cases, entities)
5. **Widgets**: Keep widgets small and reusable

## 🎯 Next Steps

1. Add unit tests for use cases
2. Add widget tests for UI components
3. Implement more features using the same architecture
4. Add API integration for real backend
5. Implement proper error handling and retry logic

---

Need help? Check [ARCHITECTURE.md](ARCHITECTURE.md) for detailed documentation.
