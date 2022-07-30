// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:task/screens/d_result_screen.dart';
import 'package:task/utils/app_constant.dart';
import 'package:task/widgets/custom_button.dart';

class QuizScreen extends ConsumerStatefulWidget {
  const QuizScreen({Key? key}) : super(key: key);

  @override
  HomeViewState createState() => HomeViewState();
}

class HomeViewState extends ConsumerState<QuizScreen> {
  int currentQuestion = 0;
  late Timer timer;
  int maxSec = 15;
  late int currentSec;
  int selectedOption = 0;
  int userScore = 0;
  bool isSelected = false;
  var quizData;

  List<int> selectedOptionByUser = [];

  void startTimer() {
    timer = Timer.periodic(
      const Duration(seconds: 1),
      (Timer timer) {
        if (currentSec == 0) {
          setState(() {
            timer.cancel();
          });
          if (currentQuestion < quizData['questions'].length - 1) {
            nextQuiz();
          } else {
            closeQuiz();
          }
        } else {
          setState(() {
            currentSec--;
          });
        }
      },
    );
  }

  nextQuiz() {
    userProgressData();
    setState(() {
      timer.cancel();
      startTimer();
      currentQuestion++;
      isSelected = false;
      selectedOption = 0;
      currentSec = maxSec;
    });
  }

  closeQuiz() {
    timer.cancel();
    userProgressData();
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => ResultScreen(
          score: userScore,
          selectedOptionsList: selectedOptionByUser,
        ),
      ),
    );
  }

  // void notLastQuiz() {
  //   setState(() {
  //     // isSelected = false;
  //     // selectedOption = 0;
  //     timer.cancel();
  //     currentSec = maxSec;
  //     startTimer();
  //     currentQuestion++;
  //   });
  // }

  // void lastQuiz() {
  //   notLastQuiz();
  //   Navigator.of(context).pushReplacement(
  //     MaterialPageRoute(
  //       builder: (context) => const ResultScreen(
  //         // score: userScore,
  //         score: 1,
  //       ),
  //     ),
  //   );
  // }

  Future<void> getQuizData() async {
    var gotData = await DefaultAssetBundle.of(context)
        .loadString('assets/json/quiz_data.json');
    quizData = json.decode(gotData.toString());
    return quizData;
  }

  userProgressData() {
    if (selectedOption ==
        quizData['questions'][currentQuestion]['correct_answer']) {
      setState(() {
        userScore++;
      });
    }
    selectedOptionByUser.add(selectedOption);
  }

  @override
  void initState() {
    currentSec = maxSec;
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
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: FutureBuilder(
        future: getQuizData(),
        builder: (context, snapshot) {
          var data = quizData;
          if (data == null) {
            return const Center(
              child: CircularProgressIndicator(
                color: AppConstant.primaryColor,
              ),
            );
          } else {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: SizedBox(
                      width: 125,
                      height: 125,
                      child: CustomPaint(
                        painter: OpenPainter(
                          seconds: currentSec * 0.418879.toDouble(),
                        ),
                        child: Center(
                          child: Text(
                            currentSec.toString(),
                            style:
                                Theme.of(context).textTheme.headline2!.copyWith(
                                      fontWeight: FontWeight.w900,
                                      fontSize: 48.sp,
                                    ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        data['questions'][currentQuestion]['question'],
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headline2!.copyWith(
                              fontWeight: FontWeight.w700,
                              fontSize: 28.sp,
                            ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  options(
                    data,
                    context,
                    1,
                  ),
                  options(
                    data,
                    context,
                    2,
                  ),
                  options(
                    data,
                    context,
                    3,
                  ),
                  options(
                    data,
                    context,
                    4,
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  Center(
                    child: SizedBox(
                      width: width * 0.8,
                      height: 40.h,
                      child: CustomButton(
                        onPressed: () {
                          if (currentQuestion <
                              quizData['questions'].length - 1) {
                            nextQuiz();
                          } else {
                            closeQuiz();
                          }
                        },
                        title: isSelected ? 'Submit' : 'Skip',
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }

  RadioListTile<int> options(
    data,
    BuildContext context,
    int optionId,
  ) {
    return RadioListTile(
      value: optionId,
      groupValue: selectedOption,
      onChanged: (val) {
        setState(
          () {
            selectedOption = val!;
            isSelected = true;
          },
        );
      },
      activeColor: AppConstant.titlecolor,
      title: Text(
        data['questions'][currentQuestion]['options'][optionId - 1],
        style: Theme.of(context).textTheme.headline4!.copyWith(
              color: selectedOption == optionId
                  ? AppConstant.titlecolor
                  : AppConstant.titlecolor.withOpacity(0.8),
            ),
      ),
    );
  }
}

class OpenPainter extends CustomPainter {
  double seconds;

  OpenPainter({
    required this.seconds,
  });

  @override
  void paint(Canvas canvas, Size size) {
    var paint1 = Paint()
      ..color = AppConstant.titlecolor.withOpacity(0.7)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;
    canvas.drawArc(
      const Offset(0, 0) & const Size(125, 125),
      0, //radians
      seconds, //radians
      false,
      paint1,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
