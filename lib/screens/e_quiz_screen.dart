// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:task/screens/f_result_screen.dart';
import 'package:task/utils/app_constant.dart';
import 'package:task/widgets/arc.dart';
import 'package:task/widgets/custom_button.dart';

class QuizScreen extends ConsumerStatefulWidget {
  const QuizScreen({
    super.key,
    required this.selectedOption,
  });

  final int selectedOption;

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
  late String scriptFile;
  late String optFileIndex;

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
          noOfQuiz: quizData['questions'].length,
          scriptFile: scriptFile,
        ),
      ),
    );
  }

  Future<void> getQuizData() async {
    var gotData = await DefaultAssetBundle.of(context).loadString(scriptFile);
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
    optFileIndex = widget.selectedOption.toString();
    scriptFile = 'assets/json/$optFileIndex.json';
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
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder(
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
              return Column(
                children: [
                  SizedBox(
                    height: height * 0.85 - 50,
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 60.h,
                          ),
                          Center(
                            child: SizedBox(
                              width: 125,
                              height: 125,
                              child: CustomPaint(
                                painter: Arc(
                                  seconds: currentSec * 0.418879.toDouble(),
                                ),
                                child: Center(
                                  child: Text(
                                    currentSec.toString(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline2!
                                        .copyWith(
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
                                style: Theme.of(context)
                                    .textTheme
                                    .headline2!
                                    .copyWith(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 28.sp,
                                    ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 15.h,
                          ),
                          ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: data['questions'][currentQuestion]
                                    ['options']
                                .length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: RadioListTile(
                                  value: index + 1,
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
                                    data['questions'][currentQuestion]
                                        ['options'][index],
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline4!
                                        .copyWith(
                                          color: selectedOption == index + 1
                                              ? AppConstant.titlecolor
                                              : AppConstant.titlecolor
                                                  .withOpacity(0.8),
                                        ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.15,
                    child: Center(
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
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
