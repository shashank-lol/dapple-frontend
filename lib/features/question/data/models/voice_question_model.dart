import '../../domain/entities/voice_question.dart';

class VoiceQuestionModel extends VoiceQuestion {
  VoiceQuestionModel({
    required super.questionId,
    required super.question,
    required super.questionType,
    required super.xp,
  });

  factory VoiceQuestionModel.fromJson(Map<String, dynamic> json) {
    return VoiceQuestionModel(
      questionId: json['questionId'],
      question: json['question'],
      questionType: json['questionType'],
      xp: json['xp'],
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is VoiceQuestionModel && runtimeType == other.runtimeType ||
      other is VoiceQuestion;

  @override
  int get hashCode => 5;
}