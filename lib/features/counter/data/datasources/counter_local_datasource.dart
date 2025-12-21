import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/counter_model.dart';

abstract class CounterLocalDataSource {
  Future<CounterModel> getCounter();
  Future<CounterModel> saveCounter(int value);
}

@LazySingleton(as: CounterLocalDataSource)
class CounterLocalDataSourceImpl implements CounterLocalDataSource {
  static const String _counterKey = 'counter_value';
  final SharedPreferences _prefs;

  CounterLocalDataSourceImpl(this._prefs);

  @override
  Future<CounterModel> getCounter() async {
    final value = _prefs.getInt(_counterKey) ?? 0;
    return CounterModel(value: value);
  }

  @override
  Future<CounterModel> saveCounter(int value) async {
    await _prefs.setInt(_counterKey, value);
    return CounterModel(value: value);
  }
}
