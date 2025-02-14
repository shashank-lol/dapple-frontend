import 'package:dapple/features/question/domain/entities/lesson.dart';

class LessonsModel extends Lesson{
  LessonsModel({
    required super.questionId,
    required super.title,
    required super.content,
    super.imageUrl,
    required super.xp,
  });

  factory LessonsModel.fromJson(Map<String, dynamic> json) {
    return LessonsModel(
      questionId: json['lessonId'],
      title: json['title'],
      content: List<String>.from(json['content']),
      imageUrl: json['imageUrl'],
      xp: json['xp'],
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LessonsModel && runtimeType == other.runtimeType || other is Lesson;

  @override
  int get hashCode => 3;
}