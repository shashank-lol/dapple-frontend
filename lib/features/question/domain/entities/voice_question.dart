import 'package:dapple/features/question/domain/entities/question.dart';

class VoiceQuestion extends Question {

  VoiceQuestion({
    required super.questionId,
    required super.question,
    required super.questionType,
    required super.xp,
  });

  @override
  String toString() {
    return 'VoiceQuestion{questionId: $questionId, question: $question, questionType: $questionType, xp: $xp}';
  }

  factory VoiceQuestion.empty() {
    return VoiceQuestion(
      questionId: '',
      question: '',
      questionType: '',
      xp: 0,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is VoiceQuestion &&
          runtimeType == other.runtimeType &&
          questionId == other.questionId &&
          question == other.question &&
          questionType == other.questionType &&
          xp == other.xp;

  @override
  int get hashCode => 5;
}