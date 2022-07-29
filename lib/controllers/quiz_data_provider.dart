import 'package:hooks_riverpod/hooks_riverpod.dart';

class QuizData extends StateNotifier<void> {
  QuizData() : super(null);

  void getData() {}
}

final quizDataProvider = StateNotifierProvider<QuizData, void>((_) {
  return QuizData();
});
