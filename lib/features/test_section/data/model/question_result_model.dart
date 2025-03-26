import 'package:dapple/features/test_section/data/model/test_evaluation_model.dart';
import 'package:dapple/features/test_section/data/model/test_summary_model.dart';
import 'package:dapple/features/test_section/domain/entities/question_result.dart';

class QuestionResultModel extends QuestionResult{
  QuestionResultModel(super.obtainedXp, super.evaluations, super.summaries);

  factory QuestionResultModel.fromJson(Map<String, dynamic> json){
    return QuestionResultModel(
      json['userAnswerXP'],
      (json['evaluation'] as List).map((e) => TestEvaluationModel.fromJson(e)).toList(),
      (json['answerSummary'] as List).map((e) => TestSummaryModel.fromJson(e)).toList()
    );
  }

}