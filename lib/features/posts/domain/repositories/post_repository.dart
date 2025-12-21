import 'package:dartz/dartz.dart';
import '../entities/post_entity.dart';

abstract class PostRepository {
  Future<Either<Exception, List<PostEntity>>> getPosts();
  Future<Either<Exception, PostEntity>> getPostById(int id);
}
