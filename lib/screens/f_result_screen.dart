import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task/screens/c_quiz_type_selection_screen.dart';
import 'package:task/screens/g_answers_screen.dart';
import 'package:task/screens/b_onboarding_screen.dart';
import 'package:task/utils/app_constant.dart';
import 'package:task/widgets/custom_button.dart';

class ResultScreen extends HookWidget {
  const ResultScreen({
    super.key,
    required this.score,
    required this.selectedOptionsList,
    required this.timeTakenByUser,
    required this.noOfQuiz,
    required this.scriptFile,
  });
  final int score;
  final List<int> selectedOptionsList;
  final List<int> timeTakenByUser;
  final int noOfQuiz;
  final String scriptFile;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    late String commitment;
    late String imagePath;
   
    useEffect(() {
      if (score == 10 || score == 9) {
        commitment = 'Excellent';
        imagePath = 'assets/images/5.png';
      } else if (score == 8 || score == 7) {
        commitment = 'Awesome';
        imagePath = 'assets/images/4.png';
      } else if (score == 6 || score == 5) {
        commitment = 'Good';
        imagePath = 'assets/images/3.png';
      } else if (score == 4 || score == 3) {
        commitment = 'Average';
        imagePath = 'assets/images/2.png';
      } else if (score == 2 || score == 1) {
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
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.share_outlined,
            ),
          )
        ],
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 120.h,
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
                    width: score == 0 ? 0 : 30 * score.toDouble() - 6,
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
              height: 10.h,
            ),
            SizedBox(
              width: 290,
              child: Text(
                '$score/$noOfQuiz',
                textAlign: TextAlign.right,
                style: Theme.of(context).textTheme.headline2!.copyWith(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                    ),
              ),
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
                        builder: (context) => const QuizTyepSelectionScreen(),
                      ),
                    );
                  },
                  title: 'Play Again',
                ),
              ),
            ),
            SizedBox(
              height: 5.h,
            ),
            TextButton(
              style: TextButton.styleFrom(
                foregroundColor: AppConstant.primaryColor,
              ),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => CheckAnswerScreen(
                      selectedOptionsList: selectedOptionsList,
                      scriptFile: scriptFile,
                      timeTakenByUser: timeTakenByUser,
                    ),
                  ),
                );
              },
              child: Text(
                "Check Answers",
                style: Theme.of(context).textTheme.headline4!.copyWith(
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1.2,
                      decoration: TextDecoration.underline,
                    ),
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
          ],
        ),
      ),
    );
  }
}
