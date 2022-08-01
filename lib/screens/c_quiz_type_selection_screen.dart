import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task/screens/d__countdown_screen.dart';
import 'package:task/utils/app_constant.dart';
import 'package:task/widgets/custom_button.dart';

class QuizTyepSelectionScreen extends StatefulWidget {
  const QuizTyepSelectionScreen({super.key});

  @override
  State<QuizTyepSelectionScreen> createState() =>
      _QuizTyepSelectionScreenState();
}

class _QuizTyepSelectionScreenState extends State<QuizTyepSelectionScreen> {
  int selectedOption = 0;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Theme(
                  data: Theme.of(context).copyWith(
                    colorScheme: ColorScheme.fromSwatch().copyWith(
                      primary: AppConstant.titlecolor,
                      secondary: AppConstant.titlecolor,
                    ),
                  ),
                  child: ExpansionTile(
                    title: const Text(
                      'Dart',
                      style: TextStyle(
                        color: AppConstant.titlecolor,
                      ),
                    ),
                    children: [
                      RadioListTile(
                        value: 1,
                        groupValue: selectedOption,
                        onChanged: (val) {
                          setState(() {
                            selectedOption = val!;
                          });
                        },
                        activeColor: AppConstant.titlecolor,
                        title: Text(
                          'Novice',
                          style:
                              Theme.of(context).textTheme.headline4!.copyWith(
                                    color: AppConstant.titlecolor,
                                  ),
                        ),
                      ),
                      RadioListTile(
                        value: 2,
                        groupValue: selectedOption,
                        onChanged: (val) {
                          setState(() {
                            selectedOption = val!;
                          });
                        },
                        activeColor: AppConstant.titlecolor,
                        title: Text(
                          'Intermediate',
                          style:
                              Theme.of(context).textTheme.headline4!.copyWith(
                                    color: AppConstant.titlecolor,
                                  ),
                        ),
                      ),
                      RadioListTile(
                        value: 3,
                        groupValue: selectedOption,
                        onChanged: (val) {
                          setState(() {
                            selectedOption = val!;
                          });
                        },
                        activeColor: AppConstant.titlecolor,
                        title: Text(
                          'Expert',
                          style:
                              Theme.of(context).textTheme.headline4!.copyWith(
                                    color: AppConstant.titlecolor,
                                  ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Theme(
                  data: Theme.of(context).copyWith(
                    colorScheme: ColorScheme.fromSwatch().copyWith(
                      primary: AppConstant.titlecolor,
                      secondary: AppConstant.titlecolor,
                    ),
                  ),
                  child: ExpansionTile(
                    title: const Text(
                      'Flutter',
                      style: TextStyle(
                        color: AppConstant.titlecolor,
                      ),
                    ),
                    children: [
                      RadioListTile(
                        value: 4,
                        groupValue: selectedOption,
                        onChanged: (val) {
                          setState(() {
                            selectedOption = val!;
                          });
                        },
                        activeColor: AppConstant.titlecolor,
                        title: Text(
                          'Novice',
                          style:
                              Theme.of(context).textTheme.headline4!.copyWith(
                                    color: AppConstant.titlecolor,
                                  ),
                        ),
                      ),
                      RadioListTile(
                        value: 5,
                        groupValue: selectedOption,
                        onChanged: (val) {
                          setState(() {
                            selectedOption = val!;
                          });
                        },
                        activeColor: AppConstant.titlecolor,
                        title: Text(
                          'Intermediate',
                          style:
                              Theme.of(context).textTheme.headline4!.copyWith(
                                    color: AppConstant.titlecolor,
                                  ),
                        ),
                      ),
                      RadioListTile(
                        value: 6,
                        groupValue: selectedOption,
                        onChanged: (val) {
                          setState(() {
                            selectedOption = val!;
                          });
                        },
                        activeColor: AppConstant.titlecolor,
                        title: Text(
                          'Expert',
                          style:
                              Theme.of(context).textTheme.headline4!.copyWith(
                                    color: AppConstant.titlecolor,
                                  ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const Spacer(),
              SizedBox(
                width: width * 0.8,
                height: 40.h,
                child: CustomButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => CountDownScreen(
                          selectedOption: selectedOption,
                        ),
                      ),
                    );
                  },
                  title: 'START NOW',
                ),
              ),
              SizedBox(
                height: 40.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
