import 'dart:async';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:task/screens/quiz_screen.dart';

class CountDown extends StateNotifier<int> {
  CountDown() : super(0);

  void startTimer(
    int sec,
    BuildContext context,
  ) {
    Timer.periodic(
      const Duration(seconds: 1),
      (Timer timer) {
        if (sec == 0) {
          timer.cancel();
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => const QuizScreen(),
            ),
          );
        } else {
          state--;
        }
      },
    );
  }
}

final countDownProvider = StateNotifierProvider<CountDown, void>((_) {
  return CountDown();
});
