// ignore_for_file: prefer_interpolation_to_compose_strings, prefer_typing_uninitialized_variables

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task/utils/app_constant.dart';
import 'package:task/widgets/option_widget.dart';

class CheckAnswerScreen extends StatelessWidget {
  const CheckAnswerScreen({
    super.key,
    required this.selectedOptionsList,
  });

  final List<int> selectedOptionsList;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(
            Icons.keyboard_arrow_left_rounded,
          ),
        ),
      ),
      body: FutureBuilder(
        future: DefaultAssetBundle.of(context)
            .loadString('assets/json/quiz_data.json'),
        builder: (context, snapshot) {
          var data = json.decode(
            snapshot.data.toString(),
          );
          if (data == null) {
            return const Center(
              child: CircularProgressIndicator(
                color: AppConstant.primaryColor,
              ),
            );
          } else {
            return ListView.separated(
              separatorBuilder: (context, index) {
                return Center(
                  child: Container(
                    height: 1.h,
                    width: MediaQuery.of(context).size.width * 0.9,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          AppConstant.backgroundColor,
                          AppConstant.subtitlecolor,
                          AppConstant.backgroundColor,
                        ],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                    ),
                  ),
                );
              },
              physics: const BouncingScrollPhysics(),
              itemCount: data['questions'].length,
              itemBuilder: (context, index) {
                return QuestionWidget(
                  data: data,
                  qid: index,
                  selectedOptionsList: selectedOptionsList,
                );
              },
            );
          }
        },
      ),
    );
  }
}

class QuestionWidget extends StatelessWidget {
  const QuestionWidget({
    Key? key,
    required this.data,
    required this.qid,
    required this.selectedOptionsList,
  }) : super(key: key);

  final data;
  final int qid;
  final List<int> selectedOptionsList;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                '\u2022 ' + data['questions'][qid]['question'],
                style: Theme.of(context).textTheme.headline3!.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
              ),
            ),
            OptionWidget(
              text: 'A) ' + data['questions'][qid]['options'][0],
              isTrue:
                  data['questions'][qid]['correct_answer'] == 1 ? true : false,
              isSelectedByUser: selectedOptionsList[qid] == 1 ? true : false,
            ),
            OptionWidget(
              text: 'B) ' + data['questions'][qid]['options'][1],
              isTrue:
                  data['questions'][qid]['correct_answer'] == 2 ? true : false,
              isSelectedByUser: selectedOptionsList[qid] == 2 ? true : false,
            ),
            OptionWidget(
              text: 'C) ' + data['questions'][qid]['options'][2],
              isTrue:
                  data['questions'][qid]['correct_answer'] == 3 ? true : false,
              isSelectedByUser: selectedOptionsList[qid] == 3 ? true : false,
            ),
            OptionWidget(
              text: 'D) ' + data['questions'][qid]['options'][3],
              isTrue:
                  data['questions'][qid]['correct_answer'] == 4 ? true : false,
              isSelectedByUser: selectedOptionsList[qid] == 4 ? true : false,
            ),
          ],
        ),
      ),
    );
  }
}

// TODO initFunc