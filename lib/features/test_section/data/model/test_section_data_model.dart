import 'package:dapple/features/test_section/data/model/test_question_model.dart';
import 'package:dapple/features/test_section/domain/entities/test_section_data.dart';

class TestSectionDataModel extends TestSectionData {
  TestSectionDataModel({required super.questions, required super.sessionId});

  factory TestSectionDataModel.fromJson(Map<String, dynamic> json) {
    return TestSectionDataModel(
        questions: json['data']
            .map<TestQuestionModel>(
                (question) => TestQuestionModel.fromJson(question))
            .toList(),
        sessionId: json['sessionId']);
  }
}
