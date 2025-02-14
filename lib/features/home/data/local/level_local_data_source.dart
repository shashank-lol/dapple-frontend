import '../models/level_model.dart';
import '../models/level_section_wrapper.dart';
import '../models/section_model.dart';

abstract interface class LevelLocalDataSource {
  LevelSectionWrapper getAllLevels();
}

class LevelLocalDataSourceImpl implements LevelLocalDataSource {
  @override
  LevelSectionWrapper getAllLevels() {
    return LevelSectionWrapper(
      levels: [
        LevelModel(
          name: "Level 1",
          description: "This is level 1",
          imageUrl: "",
          sections: [
            "Section 1",
          ],
        ),
        LevelModel(
          name: "Level 2",
          description: "This is level 2",
          imageUrl: "",
          sections: [
            "Section 1",
          ],
        ),
        LevelModel(
          name: "Level 3",
          description: "This is level 3",
          imageUrl: "",
          sections: [
            "Section 1",
          ],
        ),
      ],
      sections: [
        SectionModel(
          title: "What to Speak?",
          sectionXp: 480,
        ),
        SectionModel(
          title: "Understanding Social Cues",
          sectionXp: 400,
        ),
        SectionModel(
          title: "How to Speak?",
          sectionXp: 800,
        ),
        SectionModel(
          title: "Final Assessment",
          sectionXp: 1000,
        ),
      ],
      completedLevels: 0,
      completedSections: 0,
    );
  }
}
