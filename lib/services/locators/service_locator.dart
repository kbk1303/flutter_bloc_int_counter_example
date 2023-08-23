import 'package:flutter_bloc_int_counter_example/blocs/random-number/data/repository/api/fetch_random_number_service.dart';
import 'package:flutter_bloc_int_counter_example/blocs/random-number/data/repository/mockup/fetch_random_number_mockup.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => RandomNumberMockup());
  locator.registerLazySingleton(() => RandomNumberApiService());
}
