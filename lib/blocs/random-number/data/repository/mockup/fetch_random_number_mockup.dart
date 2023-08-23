import 'dart:math';

import 'package:flutter_bloc_int_counter_example/blocs/random-number/data/repository/random_number_resp.dart';

class RandomNumberMockup implements IRandomNumber {
  @override
  Future<int> fetchRandomNumber() async {
    await Future.delayed(const Duration(seconds: 1)); // simulate small delay
    final random = Random();
    return 1 + random.nextInt(100);
  }
}
