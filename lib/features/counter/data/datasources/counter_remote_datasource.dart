import 'package:injectable/injectable.dart';
import '../../../../core/network/base_dio_client.dart';
import '../models/counter_model.dart';

abstract class CounterRemoteDataSource {
  Future<CounterModel> fetchCounterFromApi();
}

@LazySingleton(as: CounterRemoteDataSource)
class CounterRemoteDataSourceImpl implements CounterRemoteDataSource {
  final BaseDioClient _dioClient;

  CounterRemoteDataSourceImpl(this._dioClient);

  @override
  Future<CounterModel> fetchCounterFromApi() async {
    // Example API call using JSONPlaceholder
    // In a real app, this would call your actual counter API
    final response = await _dioClient.get<Map<String, dynamic>>(
      path: '/posts/1',
    );

    // For demonstration, we'll use the post ID as counter value
    return CounterModel(value: response['id'] as int? ?? 0);
  }
}
