import '../models/questions_progress_model.dart';

abstract interface class LocalQuestionsDataSource {
  Future<QuestionsProgressModel> getQuestions();
}

class LocalQuestionsDataSourceImpl implements LocalQuestionsDataSource {
  @override
  Future<QuestionsProgressModel> getQuestions() async {
    return Future.delayed(
        Duration.zero,
        () => QuestionsProgressModel(
              questions: [
                {
                  "type": "subjective",
                  "questionId": "1",
                  "question": "What is the capital of France?",
                  "xp": "10",
                },
                {
                  "type": "subjective",
                  "questionId": "1",
                  "question": "What is the capital of South Africa?",
                  "xp": "10",
                }
              ],
              currentXp: 20,
              startIndex: 0,
            ));
  }
}
