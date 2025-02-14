import 'package:dapple/features/question/domain/entities/question.dart';

class Lesson extends Question {
  final List<String> content;
  final String? imageUrl;

  Lesson({
    required super.questionId,
    required super.title,
    required this.content,
    this.imageUrl,
    required super.xp,
  });

  @override
  String toString() {
    return 'Lesson{content: $content, imageUrl: $imageUrl, questionId: $questionId, title: $title, xp: $xp}';
  }

  factory Lesson.empty() {
    return Lesson(
      questionId: '',
      title: '',
      content: [],
      imageUrl: '',
      xp: 0,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Lesson && runtimeType == other.runtimeType;

  @override
  int get hashCode => 3;
}