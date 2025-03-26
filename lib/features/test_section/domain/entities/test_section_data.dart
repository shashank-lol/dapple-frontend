import 'package:dapple/features/test_section/domain/entities/test_question.dart';

class TestSectionData{
  final List<TestQuestion> questions;
  final String sessionId;

  TestSectionData({
    required this.questions,
    required this.sessionId
  });

  @override
  String toString() {
    return 'TestSectionData(questions: $questions, sessionId: $sessionId)';
  }
}