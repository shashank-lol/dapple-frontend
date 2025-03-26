import 'package:dapple/features/test_section/domain/entities/question_result.dart';

class TestResult{
  final int obtainedXp;
  final int timeTaken;
  final List<QuestionResult> questionResults;

  TestResult(this.obtainedXp, this.questionResults, this.timeTaken);

  @override
  String toString() {
    return 'TestResult(obtainedXp: $obtainedXp, questionResults: $questionResults, timeTaken: $timeTaken)';
  }
}