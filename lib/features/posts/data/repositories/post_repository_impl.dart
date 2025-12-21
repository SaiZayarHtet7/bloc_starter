import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../domain/entities/post_entity.dart';
import '../../domain/repositories/post_repository.dart';
import '../datasources/post_remote_datasource.dart';

@LazySingleton(as: PostRepository)
class PostRepositoryImpl implements PostRepository {
  final PostRemoteDataSource _remoteDataSource;

  PostRepositoryImpl(this._remoteDataSource);

  @override
  Future<Either<Exception, List<PostEntity>>> getPosts() async {
    try {
      final posts = await _remoteDataSource.fetchPosts();
      return Right(posts);
    } catch (e) {
      return Left(Exception('Failed to fetch posts: $e'));
    }
  }

  @override
  Future<Either<Exception, PostEntity>> getPostById(int id) async {
    try {
      final post = await _remoteDataSource.fetchPostById(id);
      return Right(post);
    } catch (e) {
      return Left(Exception('Failed to fetch post: $e'));
    }
  }
}
