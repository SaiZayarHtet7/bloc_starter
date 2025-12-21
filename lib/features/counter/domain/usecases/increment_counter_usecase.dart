import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../entities/counter_entity.dart';
import '../repositories/counter_repository.dart';

@lazySingleton
class IncrementCounterUseCase {
  final CounterRepository _repository;

  IncrementCounterUseCase(this._repository);

  Future<Either<Exception, CounterEntity>> call() async {
    return await _repository.incrementCounter();
  }
}
