import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../entities/post_entity.dart';
import '../repositories/post_repository.dart';

@lazySingleton
class GetPostsUseCase {
  final PostRepository _repository;

  GetPostsUseCase(this._repository);

  Future<Either<Exception, List<PostEntity>>> call() async {
    return await _repository.getPosts();
  }
}
