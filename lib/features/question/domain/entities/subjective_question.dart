import 'package:dapple/features/question/domain/entities/question.dart';

class SubjectiveQuestion extends Question {

  SubjectiveQuestion({
    required super.questionId,
    required super.question,
    required super.questionType,
    required super.xp
  });

  @override
  String toString() {
    return 'SubjectiveQuestion{questionId: $questionId, question: $question, questionType: $questionType, xp: $xp}';
  }

  factory SubjectiveQuestion.empty() {
    return SubjectiveQuestion(
      questionId: '',
      question: '',
      questionType: '',
      xp: 0
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SubjectiveQuestion && runtimeType == other.runtimeType;

  @override
  int get hashCode => 2;
}