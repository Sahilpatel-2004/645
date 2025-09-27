import 'package:bloc/bloc.dart';
import 'package:resturent_app/Bloc/Counter/counter_event.dart';
import 'package:resturent_app/Bloc/Counter/counter_state.dart';

class CounterBloc extends Bloc<CounterEvent,CounterState>{

  CounterBloc():super(CounterState()){
    on<increment>(Increment);
    on<decrement>(Decrement);

  }
  void Increment(increment event , Emitter<CounterState> emit){
    emit(state.copyWith(count: state.count+1));
  }
  void Decrement(decrement event , Emitter<CounterState> emit){
    if(state.count>1){
    emit(state.copyWith(count: state.count-1));
    }
  }
}