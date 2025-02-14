import 'package:dapple/features/question/domain/entities/subjective_question.dart';

class SubjectiveQuestionModel extends SubjectiveQuestion {
  SubjectiveQuestionModel(
      {required super.questionId,
      required super.question,
      required super.questionType,
      required super.xp});

  factory SubjectiveQuestionModel.fromJson(Map<String, dynamic> json) {
    return SubjectiveQuestionModel(
      questionId: json['questionId'],
      question: json['question'],
      questionType: json['type'],
      xp: json['xp'],
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SubjectiveQuestionModel && runtimeType == other.runtimeType ||
      other is SubjectiveQuestion;

  @override
  int get hashCode => 2;
}
