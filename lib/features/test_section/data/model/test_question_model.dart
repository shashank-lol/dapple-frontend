import 'package:dapple/features/test_section/domain/entities/test_question.dart';

class TestQuestionModel extends TestQuestion{
  TestQuestionModel({
    required super.question,
    required super.questionId,
    required super.xp
  });

  factory TestQuestionModel.fromJson(Map<String, dynamic> json) {
    return TestQuestionModel(
      question: json['question'],
      questionId: json['questionId'],
      xp: json['xp']
    );
  }
}