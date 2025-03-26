import '../model/test_question_model.dart';

abstract interface class TestQuestionsLocal {
  List<TestQuestionModel> getTestQuestions();
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
}
