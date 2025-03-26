import '../../domain/entities/subjective_question_answer.dart';
import 'evaluation_model.dart';

class SubjectiveQuestionAnswerModel extends SubjectiveQuestionAnswer {
  SubjectiveQuestionAnswerModel({
    required super.evaluations,
    required super.bestAnswer,
    required super.xp,
    required super.userAnswer,
  });

  factory SubjectiveQuestionAnswerModel.fromJson(Map<String, dynamic> json) {
    return SubjectiveQuestionAnswerModel(
      evaluations: json['evaluation'].map<EvaluationModel>((e) => EvaluationModel.fromJson(e)).toList(),
      bestAnswer: json['bestAnswer'].map<String>((e) => e.toString()).toList(),
      userAnswer: json['userAnswer'].map<String>((e) => e.toString()).toList(),
      xp: json['xp'],
    );
  }
}