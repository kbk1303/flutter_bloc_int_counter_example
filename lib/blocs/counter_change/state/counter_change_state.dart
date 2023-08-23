class CounterChangeState {
  late int _currentNumber = 0;

  int get currentValue => _currentNumber;

  CounterChangeState init() {
    return CounterChangeState().._currentNumber = 0;
  }

  CounterChangeState increment(int current) {
    return CounterChangeState()
      .._currentNumber = current
      .._currentNumber += 1;
  }

  CounterChangeState decrement(int current) {
    return CounterChangeState()
     .._currentNumber = current
     .._currentNumber =_currentNumber == 0 ? 0 : _currentNumber -= 1;
    /*
    _currentNumber = current;
   
    return CounterChangeState().._currentNumber;
    */
  }
}
