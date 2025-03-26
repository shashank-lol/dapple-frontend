import 'package:dapple/features/test_section/domain/entities/test_summary.dart';

class TestSummaryModel extends TestSummary{
  TestSummaryModel(super.title, super.content, super.userScore, super.totalScore);

  factory TestSummaryModel.fromJson(Map<String, dynamic> json){
    return TestSummaryModel(
      json['title'],
      json['content'],
      json['userScore'],
      json['maxScore']
    );
  }
}