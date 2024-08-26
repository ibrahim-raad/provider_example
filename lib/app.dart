import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_example/timer/timer.dart';
import 'package:provider_example/timer/timer_provider.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => TimerProvider(),
      child: MaterialApp(
        title: 'Timer App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const TimerPage(),
      ),
    );
  }
}
