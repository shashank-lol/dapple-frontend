import 'package:dapple/features/test_section/domain/entities/test_evaluation.dart';
import 'package:dapple/features/test_section/domain/entities/test_summary.dart';

class  QuestionResult{
  final int obtainedXp;
  final List<TestEvaluation> evaluations;
  final List<TestSummary> summaries;

  QuestionResult(this.obtainedXp, this.evaluations, this.summaries);

  @override
  String toString() {
    return 'QuestionResult(obtainedXp: $obtainedXp, evaluations: $evaluations, summaries: $summaries)';
  }

}