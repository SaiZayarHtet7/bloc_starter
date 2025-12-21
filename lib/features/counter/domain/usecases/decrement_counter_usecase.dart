import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../entities/counter_entity.dart';
import '../repositories/counter_repository.dart';

@lazySingleton
class DecrementCounterUseCase {
  final CounterRepository _repository;

  DecrementCounterUseCase(this._repository);

  Future<Either<Exception, CounterEntity>> call() async {
    return await _repository.decrementCounter();
  }
}
