import 'package:injectable/injectable.dart';
import '../../../../core/network/base_dio_client.dart';
import '../models/post_model.dart';

abstract class PostRemoteDataSource {
  Future<List<PostModel>> fetchPosts();
  Future<PostModel> fetchPostById(int id);
}

@LazySingleton(as: PostRemoteDataSource)
class PostRemoteDataSourceImpl implements PostRemoteDataSource {
  final BaseDioClient _dioClient;

  PostRemoteDataSourceImpl(this._dioClient);

  @override
  Future<List<PostModel>> fetchPosts() async {
    final response = await _dioClient.get<List<dynamic>>(path: '/posts');

    return response.map((json) => PostModel.fromJson(json)).toList();
  }

  @override
  Future<PostModel> fetchPostById(int id) async {
    final response = await _dioClient.get<Map<String, dynamic>>(
      path: '/posts/$id',
    );

    return PostModel.fromJson(response);
  }
}
