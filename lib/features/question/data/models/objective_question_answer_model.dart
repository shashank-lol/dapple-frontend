import 'package:dapple/features/question/domain/entities/objective_question_answer.dart';

class ObjectiveQuestionAnswerModel extends ObjectiveQuestionAnswer {
  bool? isCorrect;
  ObjectiveQuestionAnswerModel({
    required super.correctOptionIndex,
    this.isCorrect,
    required super.explanation,
    required super.xp,
  });

  factory ObjectiveQuestionAnswerModel.fromJson(Map<String, dynamic> json) {
    return ObjectiveQuestionAnswerModel(
      correctOptionIndex: json['correctOption'],
      explanation: List<String>.from(json['explanation']),
      xp: json['xp'],
    );
  }

}