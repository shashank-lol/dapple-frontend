import 'package:dapple/features/test_section/data/model/question_result_model.dart';
import 'package:dapple/features/test_section/domain/entities/test_result.dart';

class TestResultModel extends TestResult{
  TestResultModel(super.obtainedXp, List<QuestionResultModel> super.questionResults, super.timeTaken);

  factory TestResultModel.fromJson(Map<String, dynamic> json){
    return TestResultModel(
      json['totalXP'],
      (json['questionResult'] as List).map((e) => QuestionResultModel.fromJson(e)).toList(),
      json['totalTimeTaken']
    );
  }
}