import 'package:dapple/features/home/data/models/level_model.dart';
import 'package:dapple/features/home/data/models/section_model.dart';

class LevelSectionWrapper {
  final List<LevelModel> levels;
  final List<SectionModel> sections;
  final int completedLevels;
  final int completedSections;

  LevelSectionWrapper({
    required this.levels,
    required this.sections,
    required this.completedLevels,
    required this.completedSections,
  });

  factory LevelSectionWrapper.fromJson(Map<String, dynamic> json) {
    return LevelSectionWrapper(
      levels: (json['levels'] as List).map((e) => LevelModel.fromJson(e as Map<String, dynamic>)).toList(),
      sections: (json['sectionData'] as List).map((e) => SectionModel.fromJson(e as Map<String, dynamic>)).toList(),
      completedLevels: json['userProgress']['completedLevels'],
      completedSections: json['userProgress']['completedSections'],
    );
  }
}