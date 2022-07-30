import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task/screens/c_quiz_screen.dart';

class CountDownScreen extends StatefulWidget {
  const CountDownScreen({super.key});

  @override
  State<CountDownScreen> createState() => _CountDownScreenState();
}

class _CountDownScreenState extends State<CountDownScreen> {
  late Timer timer;
  int initialSec = 3;

  void startTimer() {
    timer = Timer.periodic(
      const Duration(seconds: 1),
      (Timer timer) {
        if (initialSec == 0) {
          setState(() {
            timer.cancel();
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => const QuizScreen(),
              ),
            );
          });
        } else {
          setState(() {
            initialSec--;
          });
        }
      },
    );
  }

  @override
  void initState() {
    startTimer();
    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Get Ready!',
                style: Theme.of(context).textTheme.headline1,
              ),
              SizedBox(
                height: 20.h,
              ),
              Text(
                initialSec.toString(),
                style: Theme.of(context).textTheme.headline2!.copyWith(
                      fontSize: 48.sp,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
