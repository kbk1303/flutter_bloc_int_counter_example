import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_int_counter_example/blocs/counter_change/event/counter_change_event.dart';
import 'package:flutter_bloc_int_counter_example/blocs/counter_change/state/counter_change_state.dart';

class CounterChangeBloc extends Bloc<CounterChangeEvent, CounterChangeState> {
  CounterChangeBloc() : super(CounterChangeState()..init()) {
    on<CounterIncrementEvent>((event, emit) => emit(state.increment(state.currentValue)));
    on<CounterDecrementEvent>((event, emit) => emit(state.decrement(state.currentValue)));
  }
}
