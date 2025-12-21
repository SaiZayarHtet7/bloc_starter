import 'package:equatable/equatable.dart';

class CounterEntity extends Equatable {
  final int value;

  const CounterEntity({required this.value});

  @override
  List<Object> get props => [value];

  CounterEntity copyWith({int? value}) {
    return CounterEntity(value: value ?? this.value);
  }
}
