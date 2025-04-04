import 'package:dapple/features/home/data/models/level_model.dart';

class LevelSectionWrapper {
  final List<LevelModel> levels;
  final int completedLevels;
  final int completedSections;
  LevelSectionWrapper({
    required this.levels,
    required this.completedLevels,
    required this.completedSections,
  });

  factory LevelSectionWrapper.fromJson(Map<String, dynamic> json) {
    return LevelSectionWrapper(
      levels: (json['levels'] as List).map((e) => LevelModel.fromJson(e as Map<String, dynamic>)).toList(),
      completedLevels: json['userProgress']['completedLevels'],
      completedSections: json['userProgress']['completedSections'],
    );
  }

  /// Updates completed levels and sections when a level is completed
  LevelSectionWrapper levelCompleted() {
    int newCompletedLevels = completedLevels + 1;
    int newCompletedSections = 0;
    return LevelSectionWrapper(
      levels: levels,
      completedLevels: newCompletedLevels,
      completedSections: newCompletedSections,
    );
  }

  /// Updates completed levels and sections when a section is completed
  LevelSectionWrapper sectionCompleted() {
    int newCompletedLevels = completedLevels ;
    int newCompletedSections = completedSections + 1;
    return LevelSectionWrapper(
      levels: levels,
      completedLevels: newCompletedLevels,
      completedSections: newCompletedSections,
    );
  }

}