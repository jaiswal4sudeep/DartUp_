import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task/screens/e_answers_screen.dart';
import 'package:task/screens/b_countdown_screen.dart';
import 'package:task/screens/a_onboarding_screen.dart';
import 'package:task/utils/app_constant.dart';
import 'package:task/widgets/custom_button.dart';

class ResultScreen extends HookWidget {
  const ResultScreen({
    super.key,
    required this.score,
    required this.selectedOptionsList,
    required this.noOfQuiz,
  });
  final int score;
  final List<int> selectedOptionsList;
  final int noOfQuiz;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    late String commitment;
    late String imagePath;

    useEffect(() {
      if (score == 5) {
        commitment = 'Excellent';
        imagePath = 'assets/images/5.png';
      } else if (score == 4) {
        commitment = 'Awesome';
        imagePath = 'assets/images/4.png';
      } else if (score == 3) {
        commitment = 'Good';
        imagePath = 'assets/images/3.png';
      } else if (score == 2) {
        commitment = 'Average';
        imagePath = 'assets/images/2.png';
      } else if (score == 1) {
        commitment = 'Bad';
        imagePath = 'assets/images/1.png';
      } else {
        commitment = 'Better Luck Next Time';
        imagePath = 'assets/images/0.png';
      }
      return null;
    });
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => const OnboardingScreen(),
              ),
            );
          },
          icon: const Icon(
            Icons.close_rounded,
          ),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 100.h,
            ),
            Image.asset(
              imagePath,
              scale: 0.8,
            ),
            SizedBox(
              height: 20.h,
            ),
            Text(
              commitment,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline2!.copyWith(
                    fontSize: 28.sp,
                  ),
            ),
            SizedBox(
              height: 20.h,
            ),
            Container(
              width: 300,
              height: 20.h,
              decoration: BoxDecoration(
                color: AppConstant.subtitlecolor,
                borderRadius: BorderRadius.circular(50),
              ),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 3.0),
                  child: Container(
                    width: score == 0 ? 0 : 60 * score.toDouble() - 6,
                    height: 15.h,
                    decoration: BoxDecoration(
                      color: AppConstant.titlecolor,
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 15.h,
            ),
            Text(
              'Total Score : $score/$noOfQuiz',
              style: Theme.of(context).textTheme.headline3,
            ),
            const Spacer(),
            Center(
              child: SizedBox(
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
                  title: 'Play Again',
                ),
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            Center(
              child: SizedBox(
                width: width * 0.8,
                height: 40.h,
                child: CustomButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => CheckAnswerScreen(
                          selectedOptionsList: selectedOptionsList,
                        ),
                      ),
                    );
                  },
                  title: 'Check Answer',
                  bgColor: Colors.transparent,
                  textColor: AppConstant.primaryColor,
                ),
              ),
            ),
            SizedBox(
              height: 30.h,
            ),
          ],
        ),
      ),
    );
  }
}
