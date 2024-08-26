import 'package:flutter/material.dart';
import 'dart:async';

class TimerProvider with ChangeNotifier {
  static const int initialDuration = 10; // Example duration
  int currentDuration = initialDuration;
  Timer? _timer;
  bool isRunning = false;
  bool isPaused = false;
  bool isComplete = false;

  void start() {
    if (isRunning || isPaused) return;
    isRunning = true;
    isPaused = false;
    isComplete = false;
    currentDuration = initialDuration;
    notifyListeners();
    _startTimer();
  }

  void pause() {
    if (!isRunning) return;
    isPaused = true;
    isRunning = false;
    _timer?.cancel();
    notifyListeners();
  }

  void resume() {
    if (!isPaused) return;
    isPaused = false;
    isRunning = true;
    notifyListeners();
    _startTimer();
  }

  void reset() {
    _timer?.cancel();
    currentDuration = initialDuration;
    isRunning = false;
    isPaused = false;
    isComplete = false;
    notifyListeners();
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (currentDuration > 0) {
        currentDuration--;
        notifyListeners();
      } else {
        timer.cancel();
        isRunning = false;
        isComplete = true;
        notifyListeners();
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
