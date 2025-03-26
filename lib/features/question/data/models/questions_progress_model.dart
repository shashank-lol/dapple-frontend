import 'package:dapple/features/question/domain/entities/questions_progress.dart';

class QuestionsProgressModel extends QuestionsProgress {
  QuestionsProgressModel({
    required super.questions,
    required super.currentXp,
    required super.startIndex,
  });

  factory QuestionsProgressModel.fromJson(Map<String, dynamic> json, List<dynamic> questions) {
    return QuestionsProgressModel(
      questions: questions,
      currentXp:  json['sectionProgress']['xp'],
      startIndex: json['sectionProgress']['progress'],
    );
  }

}