// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task/screens/b_onboarding_screen.dart';
import 'package:task/screens/c_quiz_type_selection_screen.dart';

class SplashScreen extends StatefulHookConsumerWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    super.initState();
    timerAndNav();
  }

  timerAndNav() async {
    await Future.delayed(
      const Duration(seconds: 2),
    );
    if (!mounted) return;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (!mounted) return;
    if (prefs.getBool('isAppInited') != null) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const QuizTyepSelectionScreen(),
        ),
      );
    } else {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const OnboardingScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: CircleAvatar(
            radius: 60.h,
            backgroundColor: Colors.white,
            child: Center(
              child: Image.asset(
                'assets/images/applogo.png',
                height: 60.h,
                fit: BoxFit.fitWidth,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
