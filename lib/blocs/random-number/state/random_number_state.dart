enum RandomNumberStates { initial, loading, loaded, complete, error }

class RandomNumberState {
  final RandomNumberStates _states;
  final int? _number;

  RandomNumberStates get currentState => _states;
  int? get randomNumber => _number;

  RandomNumberState({required RandomNumberStates states, int number = -1})
      : _states = states,
        _number = number;
}
