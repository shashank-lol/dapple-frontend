import 'package:dapple/features/home/domain/entities/section.dart';

class Level {
  final String name;
  final String description;
  final String? imageUrl;
  final List<Section>? sections;

  Level(
      {required this.name,
      required this.description,
      required this.imageUrl,
      required this.sections});
}
