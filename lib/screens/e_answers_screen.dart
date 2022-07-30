// ignore_for_file: prefer_typing_uninitialized_variables, prefer_interpolation_to_compose_strings

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task/utils/app_constant.dart';

class CheckAnswerScreen extends StatelessWidget {
  const CheckAnswerScreen({super.key});

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
            return ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: data['questions'].length,
              itemBuilder: (context, index) {
                return QuestionWidget(
                  data: data,
                  qid: index,
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
  }) : super(key: key);

  final data;
  final int qid;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 10,
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
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8.0,
                  vertical: 4.0,
                ),
                child: Text(
                  'A) ' + data['questions'][qid]['options'][0],
                  style: Theme.of(context).textTheme.headline5!.copyWith(
                        fontSize: data['questions'][qid]['correct_answer'] == 1
                            ? 13.sp
                            : 12.sp,
                        fontWeight:
                            data['questions'][qid]['correct_answer'] == 1
                                ? FontWeight.w700
                                : FontWeight.w500,
                      ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8.0,
                  vertical: 4.0,
                ),
                child: Text(
                  'B) ' + data['questions'][qid]['options'][1],
                  style: Theme.of(context).textTheme.headline5!.copyWith(
                        fontSize: data['questions'][qid]['correct_answer'] == 2
                            ? 13.sp
                            : 12.sp,
                        fontWeight:
                            data['questions'][qid]['correct_answer'] == 2
                                ? FontWeight.w700
                                : FontWeight.w500,
                      ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8.0,
                  vertical: 4.0,
                ),
                child: Text(
                  'C) ' + data['questions'][0]['options'][2],
                  style: Theme.of(context).textTheme.headline5!.copyWith(
                        fontSize: data['questions'][qid]['correct_answer'] == 3
                            ? 13.sp
                            : 12.sp,
                        fontWeight:
                            data['questions'][qid]['correct_answer'] == 3
                                ? FontWeight.w700
                                : FontWeight.w500,
                      ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8.0,
                  vertical: 4.0,
                ),
                child: Text(
                  'D) ' + data['questions'][qid]['options'][3],
                  style: Theme.of(context).textTheme.headline5!.copyWith(
                        fontSize: data['questions'][qid]['correct_answer'] == 4
                            ? 13.sp
                            : 12.sp,
                        fontWeight:
                            data['questions'][qid]['correct_answer'] == 4
                                ? FontWeight.w700
                                : FontWeight.w500,
                      ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
