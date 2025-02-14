import 'package:dapple/features/question/domain/entities/question.dart';

class ObjectiveQuestion extends Question {
  final List<String> options;
  final String? imageUrl;

  ObjectiveQuestion({
    required super.questionId,
    required this.options,
    required super.xp,
    required super.questionType,
    required super.question,
    this.imageUrl
  });

  @override
  String toString() {
    return 'ObjectiveQuestion{options: $options, imageUrl: $imageUrl, questionId: $questionId, questionType: $questionType, question: $question, xp: $xp}';
  }

  factory ObjectiveQuestion.empty() {
    return ObjectiveQuestion(
      questionId: '',
      options: [],
      imageUrl: '',
      xp: 0,
      questionType: '',
      question: ''
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ObjectiveQuestion && runtimeType == other.runtimeType;

  @override
  int get hashCode => 1;
}