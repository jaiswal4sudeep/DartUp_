// ignore_for_file: non_constant_identifier_names, avoid_print

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
  bool isQuizOver = false;
  late Timer timer;
  int initialSec = 15;
  int selectedOption = 0;
  int userScore = 0;
  bool isSelected = false;

  void startTimer() {
    timer = Timer.periodic(
      const Duration(seconds: 1),
      (Timer timer) {
        if (initialSec == 0) {
          if (currentQuestion < 4) {
            notLastQuiz();
          }
          if (currentQuestion == 4) {
            lastQuiz();
          }
        } else {
          setState(() {
            initialSec--;
          });
        }
      },
    );
  }

  void notLastQuiz() {
    setState(() {
      isSelected = false;
      selectedOption = 0;
      timer.cancel();
      initialSec = 15;
      startTimer();
      currentQuestion++;
    });
  }

  void lastQuiz() {
    setState(() {
      timer.cancel();
      startTimer();
      isQuizOver = true;
    });
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
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: FutureBuilder(
        future: DefaultAssetBundle.of(context)
            .loadString('assets/json/quiz_data.json'),
        builder: (context, snapshot) {
          var data = json.decode(snapshot.data.toString());
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
                          seconds: initialSec * 0.418879.toDouble(),
                        ),
                        child: Center(
                          child: Text(
                            initialSec.toString(),
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
                        onPressed: isQuizOver
                            ? () {
                                if (selectedOption ==
                                    data['questions'][currentQuestion]
                                        ['correct_answer']) {
                                  setState(() {
                                    userScore++;
                                  });
                                }
                                Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                    builder: (context) => ResultScreen(
                                      score: userScore,
                                    ),
                                  ),
                                );
                              }
                            : () {
                                if (selectedOption ==
                                    data['questions'][currentQuestion]
                                        ['correct_answer']) {
                                  setState(() {
                                    userScore++;
                                  });
                                }
                                if (currentQuestion < 4) {
                                  notLastQuiz();
                                }
                                if (currentQuestion == 4) {
                                  lastQuiz();
                                }
                              },
                        title: isSelected
                            ? (isQuizOver ? 'Submit' : 'Submit & Next')
                            : (isQuizOver ? 'Submit' : 'Skip'),
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
