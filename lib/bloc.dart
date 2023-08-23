import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';

enum CounterEvent { increment, decrement }

class CounterBloc extends Bloc<CounterEvent, int> {
  CounterBloc() : super(0) {
    on<CounterEvent>(_onEvent, transformer: sequential());
  }


  FutureOr<void> _onEvent(CounterEvent event, Emitter<int> emit) async {
    switch (event) {
      case CounterEvent.increment:
        emit(state + 1);
        break;
      case CounterEvent.decrement:
        emit(state == 0 ? 0 : state - 1);
    }
  }
}
