import 'package:dapple/features/test_section/domain/entities/test_evaluation.dart';

class TestEvaluationModel extends TestEvaluation{
  TestEvaluationModel(super.title, super.description);

  factory TestEvaluationModel.fromJson(Map<String, dynamic> json){
    return TestEvaluationModel(
      json['title'],
      json['content']
    );
  }

}