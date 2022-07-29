import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task/screens/countdown_screen.dart';
import 'package:task/widgets/custom_button.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Center(
              child: Image.asset(
                'assets/images/onboarding.png',
                height: 350.h,
                fit: BoxFit.fitWidth,
              ),
            ),
            SizedBox(
              width: width * 0.8,
              height: 40.h,
              child: CustomButton(
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => const CountDownScreen(),
                    ),
                  );
                },
                title: 'START NOW',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
