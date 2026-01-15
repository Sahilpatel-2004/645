import 'package:equatable/equatable.dart';

abstract class CounterEvent extends Equatable{
  List<Object> get props =>[];
}

class increment extends CounterEvent{}

class decrement extends CounterEvent{}