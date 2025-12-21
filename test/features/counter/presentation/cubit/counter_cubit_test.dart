import 'package:bloc_starter/features/counter/domain/entities/counter_entity.dart';
import 'package:bloc_starter/features/counter/domain/repositories/counter_repository.dart';
import 'package:bloc_starter/features/counter/domain/usecases/decrement_counter_usecase.dart';
import 'package:bloc_starter/features/counter/domain/usecases/get_counter_usecase.dart';
import 'package:bloc_starter/features/counter/domain/usecases/increment_counter_usecase.dart';
import 'package:bloc_starter/features/counter/domain/usecases/reset_counter_usecase.dart';
import 'package:bloc_starter/features/counter/presentation/cubit/counter_cubit.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockCounterRepository extends Mock implements CounterRepository {}

class MockGetCounterUseCase extends Mock implements GetCounterUseCase {}

class MockIncrementCounterUseCase extends Mock
    implements IncrementCounterUseCase {}

class MockDecrementCounterUseCase extends Mock
    implements DecrementCounterUseCase {}

class MockResetCounterUseCase extends Mock implements ResetCounterUseCase {}

void main() {
  late MockGetCounterUseCase mockGetCounterUseCase;
  late MockIncrementCounterUseCase mockIncrementCounterUseCase;
  late MockDecrementCounterUseCase mockDecrementCounterUseCase;
  late MockResetCounterUseCase mockResetCounterUseCase;

  setUp(() {
    mockGetCounterUseCase = MockGetCounterUseCase();
    mockIncrementCounterUseCase = MockIncrementCounterUseCase();
    mockDecrementCounterUseCase = MockDecrementCounterUseCase();
    mockResetCounterUseCase = MockResetCounterUseCase();
  });

  group('CounterCubit', () {
    const tCounterEntity = CounterEntity(value: 0);
    const tIncrementedCounter = CounterEntity(value: 1);
    const tDecrementedCounter = CounterEntity(value: -1);
    const tResetCounter = CounterEntity(value: 0);

    blocTest<CounterCubit, CounterState>(
      'loads counter from constructor successfully',
      build: () {
        when(() => mockGetCounterUseCase())
            .thenAnswer((_) async => const Right(tCounterEntity));
        return CounterCubit(
          mockGetCounterUseCase,
          mockIncrementCounterUseCase,
          mockDecrementCounterUseCase,
          mockResetCounterUseCase,
        );
      },
      // Constructor calls loadCounter(), we just check the final state
      expect: () => [const CounterLoaded(tCounterEntity)],
      verify: (_) {
        verify(() => mockGetCounterUseCase()).called(1);
      },
    );

    blocTest<CounterCubit, CounterState>(
      'emits error when loadCounter fails in constructor',
      build: () {
        when(() => mockGetCounterUseCase())
            .thenAnswer((_) async => Left(Exception('Failed to load counter')));
        return CounterCubit(
          mockGetCounterUseCase,
          mockIncrementCounterUseCase,
          mockDecrementCounterUseCase,
          mockResetCounterUseCase,
        );
      },
      expect: () => [isA<CounterError>()],
    );

    blocTest<CounterCubit, CounterState>(
      'emits CounterLoaded when increment is successful',
      build: () {
        when(() => mockGetCounterUseCase())
            .thenAnswer((_) async => const Right(tCounterEntity));
        when(() => mockIncrementCounterUseCase())
            .thenAnswer((_) async => const Right(tIncrementedCounter));
        return CounterCubit(
          mockGetCounterUseCase,
          mockIncrementCounterUseCase,
          mockDecrementCounterUseCase,
          mockResetCounterUseCase,
        );
      },
      act: (cubit) async {
        // Wait for constructor's loadCounter to complete
        await Future.delayed(const Duration(milliseconds: 100));
        await cubit.increment();
      },
      skip: 2, // Skip constructor's loaded state + loading state from increment
      expect: () => [const CounterLoaded(tIncrementedCounter)],
      verify: (_) {
        verify(() => mockIncrementCounterUseCase()).called(1);
      },
    );

    blocTest<CounterCubit, CounterState>(
      'emits CounterError when increment fails',
      build: () {
        when(() => mockGetCounterUseCase())
            .thenAnswer((_) async => const Right(tCounterEntity));
        when(() => mockIncrementCounterUseCase())
            .thenAnswer((_) async => Left(Exception('Failed to increment')));
        return CounterCubit(
          mockGetCounterUseCase,
          mockIncrementCounterUseCase,
          mockDecrementCounterUseCase,
          mockResetCounterUseCase,
        );
      },
      act: (cubit) async {
        await Future.delayed(const Duration(milliseconds: 100));
        await cubit.increment();
      },
      skip: 2,
      expect: () => [isA<CounterError>()],
    );

    blocTest<CounterCubit, CounterState>(
      'emits CounterLoaded when decrement is successful',
      build: () {
        when(() => mockGetCounterUseCase())
            .thenAnswer((_) async => const Right(tCounterEntity));
        when(() => mockDecrementCounterUseCase())
            .thenAnswer((_) async => const Right(tDecrementedCounter));
        return CounterCubit(
          mockGetCounterUseCase,
          mockIncrementCounterUseCase,
          mockDecrementCounterUseCase,
          mockResetCounterUseCase,
        );
      },
      act: (cubit) async {
        await Future.delayed(const Duration(milliseconds: 100));
        await cubit.decrement();
      },
      skip: 2,
      expect: () => [const CounterLoaded(tDecrementedCounter)],
      verify: (_) {
        verify(() => mockDecrementCounterUseCase()).called(1);
      },
    );

    blocTest<CounterCubit, CounterState>(
      'emits CounterError when decrement fails',
      build: () {
        when(() => mockGetCounterUseCase())
            .thenAnswer((_) async => const Right(tCounterEntity));
        when(() => mockDecrementCounterUseCase())
            .thenAnswer((_) async => Left(Exception('Failed to decrement')));
        return CounterCubit(
          mockGetCounterUseCase,
          mockIncrementCounterUseCase,
          mockDecrementCounterUseCase,
          mockResetCounterUseCase,
        );
      },
      act: (cubit) async {
        await Future.delayed(const Duration(milliseconds: 100));
        await cubit.decrement();
      },
      skip: 2,
      expect: () => [isA<CounterError>()],
    );

    blocTest<CounterCubit, CounterState>(
      'emits CounterLoaded when reset is successful',
      build: () {
        when(() => mockGetCounterUseCase())
            .thenAnswer((_) async => const Right(tCounterEntity));
        when(() => mockResetCounterUseCase())
            .thenAnswer((_) async => const Right(tResetCounter));
        return CounterCubit(
          mockGetCounterUseCase,
          mockIncrementCounterUseCase,
          mockDecrementCounterUseCase,
          mockResetCounterUseCase,
        );
      },
      act: (cubit) async {
        await Future.delayed(const Duration(milliseconds: 100));
        await cubit.reset();
      },
      skip: 2,
      expect: () => [const CounterLoaded(tResetCounter)],
      verify: (_) {
        verify(() => mockResetCounterUseCase()).called(1);
      },
    );

    blocTest<CounterCubit, CounterState>(
      'emits CounterError when reset fails',
      build: () {
        when(() => mockGetCounterUseCase())
            .thenAnswer((_) async => const Right(tCounterEntity));
        when(() => mockResetCounterUseCase())
            .thenAnswer((_) async => Left(Exception('Failed to reset')));
        return CounterCubit(
          mockGetCounterUseCase,
          mockIncrementCounterUseCase,
          mockDecrementCounterUseCase,
          mockResetCounterUseCase,
        );
      },
      act: (cubit) async {
        await Future.delayed(const Duration(milliseconds: 100));
        await cubit.reset();
      },
      skip: 2,
      expect: () => [isA<CounterError>()],
    );
  });
}
