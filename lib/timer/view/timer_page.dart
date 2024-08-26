import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../timer_provider.dart';

class TimerPage extends StatelessWidget {
  const TimerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => TimerProvider(),
      child: const TimerView(),
    );
  }
}

class TimerView extends StatelessWidget {
  const TimerView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Timer')),
      body: const Stack(
        children: [
          Background(),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(vertical: 100.0),
                child: Center(child: TimerText()),
              ),
              Actions(),
            ],
          ),
        ],
      ),
    );
  }
}

class TimerText extends StatelessWidget {
  const TimerText({super.key});

  @override
  Widget build(BuildContext context) {
    final timerProvider = context.watch<TimerProvider>();
    final duration = timerProvider.currentDuration;
    final minutesStr =
        ((duration / 60) % 60).floor().toString().padLeft(2, '0');
    final secondsStr = (duration % 60).floor().toString().padLeft(2, '0');

    return Text(
      '$minutesStr:$secondsStr',
      style: Theme.of(context).textTheme.displayLarge,
    );
  }
}

class Actions extends StatelessWidget {
  const Actions({super.key});

  @override
  Widget build(BuildContext context) {
    final timerProvider = context.watch<TimerProvider>();

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        if (!timerProvider.isRunning &&
            !timerProvider.isPaused &&
            !timerProvider.isComplete) ...[
          FloatingActionButton(
            onPressed: timerProvider.start,
            child: const Icon(Icons.play_arrow),
          ),
        ],
        if (timerProvider.isRunning) ...[
          FloatingActionButton(
            onPressed: timerProvider.pause,
            child: const Icon(Icons.pause),
          ),
          FloatingActionButton(
            onPressed: timerProvider.reset,
            child: const Icon(Icons.replay),
          ),
        ],
        if (timerProvider.isPaused) ...[
          FloatingActionButton(
            onPressed: timerProvider.resume,
            child: const Icon(Icons.play_arrow),
          ),
          FloatingActionButton(
            onPressed: timerProvider.reset,
            child: const Icon(Icons.replay),
          ),
        ],
        if (timerProvider.isComplete) ...[
          FloatingActionButton(
            onPressed: timerProvider.reset,
            child: const Icon(Icons.replay),
          ),
        ],
      ],
    );
  }
}

class Background extends StatelessWidget {
  const Background({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.blue.shade50,
            Colors.blue.shade500,
          ],
        ),
      ),
    );
  }
}
