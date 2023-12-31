import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_int_counter_example/blocs/counter_change/bloc/counter_change_bloc.dart';
import 'package:flutter_bloc_int_counter_example/blocs/counter_change/event/counter_change_event.dart';
import 'package:flutter_bloc_int_counter_example/blocs/counter_change/state/counter_change_state.dart';
import 'package:flutter_bloc_int_counter_example/blocs/random-number/bloc/random_number_bloc.dart';
import 'package:flutter_bloc_int_counter_example/blocs/random-number/event/random_number_event.dart';
import 'package:flutter_bloc_int_counter_example/blocs/random-number/state/random_number_state.dart';
import 'package:flutter_bloc_int_counter_example/services/locators/service_locator.dart';

void main() {
  setupLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a blue toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Int\'s on the bloc!'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: MultiBlocProvider(
        providers: [
          BlocProvider<CounterChangeBloc>(
            create: (context) => CounterChangeBloc(),
          ),
          BlocProvider<RandomNumberBloc>(
              create: (context) => RandomNumberBloc()),
        ],
        child: const CounterPage(),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}

class CounterPage extends StatelessWidget {
  const CounterPage({super.key});

  @override
  Widget build(BuildContext context) {
    final CounterChangeBloc counterBloc =
        BlocProvider.of<CounterChangeBloc>(context);
    final RandomNumberBloc randomBloc =
        BlocProvider.of<RandomNumberBloc>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Int\'s on the bloc!')),
      body: Row(
        children: [
          BlocBuilder<CounterChangeBloc, CounterChangeState>(
            builder: (BuildContext context, CounterChangeState state) {
              return Center(
                child: Text(
                  state.currentValue.toString(),
                  style: const TextStyle(fontSize: 24.0),
                ),
              );
            },
          ),
          BlocBuilder<RandomNumberBloc, RandomNumberState>(
            builder: (BuildContext context, RandomNumberState state) {
              if (state.currentState == RandomNumberStates.initial) {
                return const Center(
                  child: Text('Waiting for random number...'),
                );
              }
              if (state.currentState == RandomNumberStates.loading) {
                return const CircularProgressIndicator();
              }
              return Center(
                child: Text(
                  state.currentState != RandomNumberStates.error
                      ? 'This is a random number: ${state.randomNumber}'
                      : 'An error occured',
                  style: const TextStyle(fontSize: 24.0),
                ),
              );
            },
          ),
        ],
      ),
      floatingActionButton: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0),
            child: FloatingActionButton(
              child: const Icon(Icons.add),
              onPressed: () {
                counterBloc.add(CounterIncrementEvent());
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0),
            child: FloatingActionButton(
              child: const Icon(Icons.remove),
              onPressed: () {
                counterBloc.add(CounterDecrementEvent());
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0),
            child: FloatingActionButton(
              child: const Icon(Icons.add_circle_sharp),
              onPressed: () {
                randomBloc.add(FetchRamdomNumberEvent(useMockup: false));
              },
            ),
          ),
        ],
      ),
    );
  }
}
