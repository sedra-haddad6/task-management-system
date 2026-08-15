import 'dart:async';

import 'package:get/get.dart';

enum PomodoroState {
  work,
  shortBreak,
  longBreak,
}

class PomodoroController extends GetxController {
  final int workMinutes = 25;
  final int shortBreakMinutes = 5;
  final int longBreakMinutes = 30;

  final state = PomodoroState.work.obs;
  final remainingSeconds = 0.obs;
  final isRunning = false.obs;
  final sessionCount = 0.obs;

  Timer? _timer;

  @override
  void onInit() {
    super.onInit();
    _setTime(workMinutes);
  }

  void _setTime(int minutes) {
    remainingSeconds.value = minutes * 60;
  }

  void start() {
    if (isRunning.value) return;

    isRunning.value = true;

    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        if (remainingSeconds.value > 0) {
          remainingSeconds.value--;
        } else {
          _nextState();
        }
      },
    );
  }

  void stop() {
    _timer?.cancel();
    _timer = null;
    isRunning.value = false;
  }

  void toggleTimer() {
    if (isRunning.value) {
      stop();
    } else {
      start();
    }
  }

  void reset() {
    stop();

    switch (state.value) {
      case PomodoroState.work:
        _setTime(workMinutes);
        break;

      case PomodoroState.shortBreak:
        _setTime(shortBreakMinutes);
        break;

      case PomodoroState.longBreak:
        _setTime(longBreakMinutes);
        break;
    }
  }

  void _nextState() {
    stop();

    if (state.value == PomodoroState.work) {
      sessionCount.value++;

      if (sessionCount.value % 4 == 0) {
        state.value = PomodoroState.longBreak;
        _setTime(longBreakMinutes);
      } else {
        state.value = PomodoroState.shortBreak;
        _setTime(shortBreakMinutes);
      }
    } else {
      state.value = PomodoroState.work;
      _setTime(workMinutes);
    }

    start();
  }

  String get formattedTime {
    final minutes = remainingSeconds.value ~/ 60;
    final seconds = remainingSeconds.value % 60;

    return '${minutes.toString().padLeft(2, '0')}:'
        '${seconds.toString().padLeft(2, '0')}';
  }

  String get stateLabel {
    switch (state.value) {
      case PomodoroState.work:
        return 'Work Time';

      case PomodoroState.shortBreak:
        return 'Short Break';

      case PomodoroState.longBreak:
        return 'Long Break';
    }
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }
}