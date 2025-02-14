import 'package:dapple/features/question/domain/entities/evaluation.dart';

class SubjectiveQuestionAnswer {
  final List<Evaluation> evaluations;
  final List<String> bestAnswer;
  final List<String> userAnswer;
  final int xp;

  SubjectiveQuestionAnswer(
      {required this.evaluations, required this.bestAnswer, required this.xp, required this.userAnswer});
}
