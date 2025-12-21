import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../domain/entities/counter_entity.dart';
import '../../domain/repositories/counter_repository.dart';
import '../datasources/counter_local_datasource.dart';
import '../datasources/counter_remote_datasource.dart';

@LazySingleton(as: CounterRepository)
class CounterRepositoryImpl implements CounterRepository {
  final CounterLocalDataSource _localDataSource;
  // Keep remote data source for future API integration
  // ignore: unused_field
  final CounterRemoteDataSource _remoteDataSource;

  CounterRepositoryImpl(this._localDataSource, this._remoteDataSource);

  @override
  Future<Either<Exception, CounterEntity>> getCounter() async {
    try {
      final result = await _localDataSource.getCounter();
      return Right(result);
    } catch (e) {
      return Left(Exception('Failed to get counter: $e'));
    }
  }

  @override
  Future<Either<Exception, CounterEntity>> incrementCounter() async {
    try {
      final current = await _localDataSource.getCounter();
      final newValue = current.value + 1;
      final result = await _localDataSource.saveCounter(newValue);
      return Right(result);
    } catch (e) {
      return Left(Exception('Failed to increment counter: $e'));
    }
  }

  @override
  Future<Either<Exception, CounterEntity>> decrementCounter() async {
    try {
      final current = await _localDataSource.getCounter();
      final newValue = current.value - 1;
      final result = await _localDataSource.saveCounter(newValue);
      return Right(result);
    } catch (e) {
      return Left(Exception('Failed to decrement counter: $e'));
    }
  }

  @override
  Future<Either<Exception, CounterEntity>> resetCounter() async {
    try {
      final result = await _localDataSource.saveCounter(0);
      return Right(result);
    } catch (e) {
      return Left(Exception('Failed to reset counter: $e'));
    }
  }
}
