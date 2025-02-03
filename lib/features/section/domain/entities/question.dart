import 'package:dapple/features/section/domain/entities/section_content.dart';

class Question extends SectionContent {
  final String question;
  final String? imageUrl;
  final QuestionType type;
  final List<String> options;

  Question(
      {required this.question,
      required this.imageUrl,
      required this.type,
      required this.options,
      required super.id,
      required super.xp});
}

enum QuestionType { mcq, subjectiveType, subjectiveSpeak }
