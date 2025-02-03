import 'package:dapple/features/section/domain/entities/section_content.dart';

class Lesson extends SectionContent{
  final String title;
  final String imageUrl;
  final List<String> content;

  Lesson({
    required this.title,
    required this.imageUrl,
    required this.content,
    required super.id,
    required super.xp
  });
}