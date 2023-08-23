import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc_int_counter_example/blocs/random-number/data/repository/random_number_resp.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

class RandomNumberApiService implements IRandomNumber {
  @override
  Future<int> fetchRandomNumber() async {
    try {
      final response =
          await http.get(Uri.parse('http://192.168.86.129:3000/random'));
      throwIf(response.statusCode != 200, 'An error occured in http request');

      final number = jsonDecode(response.body);
      try {
        if (kDebugMode) {
          print(int.tryParse(number['randomInt'].toString()));
        }
      } catch (fe) {
        if (kDebugMode) {
          print('parse failed!');
        }
        rethrow;
      }
      int retv = int.tryParse(number['randomInt'].toString())!;
      return retv;
    } catch (e) {
      rethrow;
    }
  }
}
