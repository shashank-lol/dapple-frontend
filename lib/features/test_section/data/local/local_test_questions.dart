import 'package:dapple/features/test_section/data/model/test_result_model.dart';

import '../model/question_result_model.dart';
import '../model/test_evaluation_model.dart';
import '../model/test_question_model.dart';
import '../model/test_summary_model.dart';

abstract interface class TestQuestionsLocal {
  List<TestQuestionModel> getTestQuestions();
  TestResultModel getTestResults();
}

class TestQuestionsLocalImpl implements TestQuestionsLocal {
  @override
  List<TestQuestionModel> getTestQuestions() {
    return [
      TestQuestionModel(
          question: "Start a natural small talk conversation with a colleague at the coffee machine.", questionId: "1", xp: 100),
      TestQuestionModel(
          question: "You notice your colleague seems distracted while talking to you. What would you do?", questionId: "1", xp: 100),
      TestQuestionModel(
          question: "Your colleague shares an exciting story about their weekend. Respond in an engaging way", questionId: "1", xp: 100),
      TestQuestionModel(
          question: "End a casual workplace conversation politely and naturally", questionId: "1", xp: 100)
    ];
  }

  TestResultModel getTestResults() {
    return TestResultModel(
      85, // obtainedXp
      [
        QuestionResultModel(
          25,
          [
            TestEvaluationModel(
                "Clarity", "Answer was well-structured and easy to understand"),
            TestEvaluationModel("Accuracy", "Response was factually correct"),
          ],
          [
            TestSummaryModel("Content Quality",
                "The answer demonstrated good knowledge", 8, 10),
            TestSummaryModel(
                "Completeness", "Covered all required aspects", 7, 10),
          ],
        ),
        QuestionResultModel(
          20,
          [
            TestEvaluationModel("Relevance", "Answer stayed on topic"),
          ],
          [
            TestSummaryModel("Depth", "Provided sufficient detail", 6, 10),
          ],
        ),
        QuestionResultModel(
          15,
          [
            TestEvaluationModel(
                "Logic", "Reasoning was sound but could be improved"),
          ],
          [
            TestSummaryModel("Analysis", "Basic analysis present", 5, 10),
          ],
        ),
        QuestionResultModel(
          25,
          [
            TestEvaluationModel("Creativity", "Showed original thinking"),
            TestEvaluationModel("Expression", "Well-articulated response"),
          ],
          [
            TestSummaryModel(
                "Innovation", "Creative approach to problem", 8, 10),
            TestSummaryModel(
                "Presentation", "Good formatting and structure", 7, 10),
          ],
        ),
      ],
      1200, // timeTaken
    );
  }
}
