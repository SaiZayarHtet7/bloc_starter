# Test Documentation

## Overview
This project includes comprehensive unit tests for both the Counter and Posts features using the BLoC pattern. All tests follow Clean Architecture principles and use the `bloc_test` package for testing Cubits.

## Test Structure

### Counter Feature Tests
Location: `test/features/counter/presentation/cubit/counter_cubit_test.dart`

**Tests included:**
1. ✅ `loads counter from constructor successfully` - Verifies the cubit loads initial counter value on creation
2. ✅ `emits error when loadCounter fails in constructor` - Tests error handling during initialization
3. ✅ `emits CounterLoaded when increment is successful` - Tests increment operation
4. ✅ `emits CounterError when increment fails` - Tests increment error handling
5. ✅ `emits CounterLoaded when decrement is successful` - Tests decrement operation
6. ✅ `emits CounterError when decrement fails` - Tests decrement error handling
7. ✅ `emits CounterLoaded when reset is successful` - Tests reset operation
8. ✅ `emits CounterError when reset fails` - Tests reset error handling

### Posts Feature Tests
Location: `test/features/posts/presentation/cubit/posts_cubit_test.dart`

**Tests included:**
1. ✅ `initial state is PostsInitial` - Verifies initial state
2. ✅ `emits [PostsLoading, PostsLoaded] when loadPosts is successful` - Tests successful posts loading
3. ✅ `emits [PostsLoading, PostsError] when loadPosts fails` - Tests error handling
4. ✅ `emits [PostsLoading, PostsLoaded] with empty list when no posts` - Tests empty state handling
5. ✅ `emits [PostsLoading, PostsLoaded] when refreshPosts is successful` - Tests refresh functionality
6. ✅ `emits [PostsLoading, PostsError] when refreshPosts fails` - Tests refresh error handling
7. ✅ `emits [PostsLoading, PostsLoaded] multiple times on multiple refreshes` - Tests multiple refresh operations

## Important Notes About CounterCubit Tests

### Constructor Behavior
The `CounterCubit` automatically calls `loadCounter()` in its constructor. This means:
- When the cubit is created, it immediately emits `CounterLoading` followed by either `CounterLoaded` or `CounterError`
- Tests need to account for these initial state emissions

### The `skip` Parameter
The `skip` parameter in `blocTest` is used to skip a specific number of state emissions before checking expectations:

```dart
blocTest<CounterCubit, CounterState>(
  'emits CounterLoaded when increment is successful',
  build: () { /* setup */ },
  act: (cubit) async {
    await Future.delayed(const Duration(milliseconds: 100)); // Wait for constructor to complete
    await cubit.increment();
  },
  skip: 2, // Skip: 1) constructor's CounterLoaded, 2) increment's CounterLoading
  expect: () => [const CounterLoaded(tIncrementedCounter)],
)
```

**Why `skip: 2`?**
1. First skip: The constructor emits `CounterLoaded` with the initial value
2. Second skip: The `increment()` method emits `CounterLoading` before performing the operation
3. We only verify the final `CounterLoaded` state with the incremented value

### Async Delays
Tests include `await Future.delayed(const Duration(milliseconds: 100))` to ensure:
- The constructor's `loadCounter()` call completes before calling action methods
- Without this delay, the action might be called before the cubit is fully initialized

## Testing Dependencies

```yaml
dev_dependencies:
  bloc_test: ^9.1.7    # For testing BLoCs and Cubits
  mocktail: ^1.0.4     # For mocking dependencies
  flutter_test:        # Flutter's testing framework
    sdk: flutter
```

## Running Tests

### Run all tests:
```bash
flutter test
```

### Run only feature tests:
```bash
flutter test test/features/
```

### Run specific test file:
```bash
flutter test test/features/counter/presentation/cubit/counter_cubit_test.dart
```

### Run with coverage:
```bash
flutter test --coverage
```

## Mocking Strategy

### Counter Feature
- `MockGetCounterUseCase` - Mocks getting counter value
- `MockIncrementCounterUseCase` - Mocks increment operation
- `MockDecrementCounterUseCase` - Mocks decrement operation
- `MockResetCounterUseCase` - Mocks reset operation

### Posts Feature
- `MockGetPostsUseCase` - Mocks fetching posts from API

All mocks use `mocktail` and follow the AAA (Arrange-Act-Assert) pattern.

## Test Results

```
00:02 +15: All tests passed!
```

**Summary:**
- ✅ 8 Counter Cubit tests passed
- ✅ 7 Posts Cubit tests passed
- ✅ Total: 15 tests, 0 failures

## BLoC Observer

The project includes `AppBlocObserver` for debugging:
- Logs all BLoC/Cubit lifecycle events (onCreate, onChange, onError, onClose)
- Useful for development and debugging
- Automatically enabled in `main.dart`

## Best Practices Followed

1. **Isolated Testing**: Each test is independent and doesn't rely on other tests
2. **Mocking**: External dependencies are mocked to isolate the unit under test
3. **Clear Test Names**: Test names clearly describe what is being tested
4. **AAA Pattern**: Tests follow Arrange-Act-Assert structure
5. **Error Coverage**: Both success and failure paths are tested
6. **State Verification**: Tests verify state transitions, not just final states
7. **Use Case Verification**: Tests verify that use cases are called the correct number of times

## Future Test Improvements

Consider adding:
1. **Widget Tests**: Test UI components in isolation
2. **Integration Tests**: Test feature flows end-to-end
3. **Repository Tests**: Test data layer with mocked data sources
4. **Use Case Tests**: Test business logic in isolation
5. **Golden Tests**: Visual regression testing for UI components

## Troubleshooting

### Issue: Tests fail with "Expected X but got Y"
**Solution**: Check if you're accounting for all state emissions, including those from the constructor. Use `skip` parameter appropriately.

### Issue: "GetIt is not ready yet"
**Solution**: If testing widgets that depend on DI, you need to initialize GetIt in `setUp()` before running tests.

### Issue: Async timing issues
**Solution**: Add appropriate delays and use `await` for async operations in tests.

## Additional Resources

- [bloc_test documentation](https://pub.dev/packages/bloc_test)
- [mocktail documentation](https://pub.dev/packages/mocktail)
- [Flutter testing guide](https://docs.flutter.dev/testing)
- [BLoC testing guide](https://bloclibrary.dev/#/testing)
