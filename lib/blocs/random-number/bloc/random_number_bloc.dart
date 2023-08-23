import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_int_counter_example/blocs/random-number/data/repository/api/fetch_random_number_service.dart';
import 'package:flutter_bloc_int_counter_example/blocs/random-number/data/repository/mockup/fetch_random_number_mockup.dart';
import 'package:flutter_bloc_int_counter_example/blocs/random-number/event/random_number_event.dart';
import 'package:flutter_bloc_int_counter_example/blocs/random-number/state/random_number_state.dart';
import 'package:flutter_bloc_int_counter_example/services/locators/service_locator.dart';

class RandomNumberBloc extends Bloc<RandomNumberEvent, RandomNumberState> {
  RandomNumberBloc()
      : super(RandomNumberState(states: RandomNumberStates.initial)) {
    on<FetchRamdomNumberEvent>(_onFetchRandomNumber);
  }

  void _onFetchRandomNumber(
      FetchRamdomNumberEvent event, Emitter<RandomNumberState> emit) async {
    emit(RandomNumberState(states: RandomNumberStates.loading));

    if (event.useMockup ?? event.useMockup!) {
      //fetch the random number from mockup
      final mockup = locator<RandomNumberMockup>(); //dependency injection
      final number = await mockup.fetchRandomNumber();
      emit(RandomNumberState(states: RandomNumberStates.loaded));
      emit(RandomNumberState(
          states: RandomNumberStates.complete, number: number));
    } else {
      //fetch the random number for REST API
      final apiService =
          locator<RandomNumberApiService>(); //dependency injection
      try {
        final number = await apiService.fetchRandomNumber();
        emit(RandomNumberState(states: RandomNumberStates.loaded));
        emit(RandomNumberState(
            states: RandomNumberStates.complete, number: number));
      } catch (e) {
        emit(RandomNumberState(states: RandomNumberStates.error));
      }
    }
  }
}
