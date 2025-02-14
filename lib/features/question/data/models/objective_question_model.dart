import 'package:dapple/features/question/domain/entities/objective_question.dart';

class ObjectiveQuestionModel extends ObjectiveQuestion {
  ObjectiveQuestionModel(
      {required super.questionId,
      required super.question,
      required super.questionType,
      required super.options,
      required super.xp,
      super.imageUrl});

  factory ObjectiveQuestionModel.fromJson(Map<String, dynamic> json) {
    return ObjectiveQuestionModel(
      questionId: json['questionId'],
      question: json['question'],
      questionType: json['type'],
      options: List<String>.from(json['options']),
      xp: json['xp'],
      imageUrl: json['imageUrl'],
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ObjectiveQuestionModel && runtimeType == other.runtimeType ||
      other is ObjectiveQuestion;

  @override
  int get hashCode => 1;
}
