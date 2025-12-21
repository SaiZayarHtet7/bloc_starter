import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../entities/post_entity.dart';
import '../repositories/post_repository.dart';

@lazySingleton
class GetPostByIdUseCase {
  final PostRepository _repository;

  GetPostByIdUseCase(this._repository);

  Future<Either<Exception, PostEntity>> call(int id) async {
    return await _repository.getPostById(id);
  }
}
