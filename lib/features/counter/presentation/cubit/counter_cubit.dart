import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:equatable/equatable.dart';
import '../../domain/entities/counter_entity.dart';
import '../../domain/usecases/get_counter_usecase.dart';
import '../../domain/usecases/increment_counter_usecase.dart';
import '../../domain/usecases/decrement_counter_usecase.dart';
import '../../domain/usecases/reset_counter_usecase.dart';

part 'counter_state.dart';

@injectable
class CounterCubit extends Cubit<CounterState> {
  final GetCounterUseCase _getCounterUseCase;
  final IncrementCounterUseCase _incrementCounterUseCase;
  final DecrementCounterUseCase _decrementCounterUseCase;
  final ResetCounterUseCase _resetCounterUseCase;

  CounterCubit(
    this._getCounterUseCase,
    this._incrementCounterUseCase,
    this._decrementCounterUseCase,
    this._resetCounterUseCase,
  ) : super(CounterInitial()) {
    loadCounter();
  }

  Future<void> loadCounter() async {
    emit(CounterLoading());
    final result = await _getCounterUseCase();
    result.fold(
      (failure) => emit(CounterError(failure.toString())),
      (counter) => emit(CounterLoaded(counter)),
    );
  }

  Future<void> increment() async {
    if (state is CounterLoaded) {
      emit(CounterLoading());
      final result = await _incrementCounterUseCase();
      result.fold(
        (failure) => emit(CounterError(failure.toString())),
        (counter) => emit(CounterLoaded(counter)),
      );
    }
  }

  Future<void> decrement() async {
    if (state is CounterLoaded) {
      emit(CounterLoading());
      final result = await _decrementCounterUseCase();
      result.fold(
        (failure) => emit(CounterError(failure.toString())),
        (counter) => emit(CounterLoaded(counter)),
      );
    }
  }

  Future<void> reset() async {
    emit(CounterLoading());
    final result = await _resetCounterUseCase();
    result.fold(
      (failure) => emit(CounterError(failure.toString())),
      (counter) => emit(CounterLoaded(counter)),
    );
  }
}
