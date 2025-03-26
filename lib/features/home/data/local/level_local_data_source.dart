import 'package:dapple/features/home/data/local/section_descriptions.dart';

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
          name: "Networking with Confidence",
          description: "Making connections in professional settings",
          imageUrl: "",
          sections: [
            SectionModel(
                title: "Words that Work",
                sectionXp: 480,
                sectionId: "section1",
                description: sectionDescriptions[0]
            ),
            SectionModel(
                title: "Reading the Room",
                sectionXp: 280,
                sectionId: "section2",
                description: sectionDescriptions[1]
            ),
            SectionModel(
                title: "Finding Your Voice",
                sectionXp: 560,
                sectionId: "section3",
                description: sectionDescriptions[2]
            ),
            SectionModel(
                title: "Putting It All Together",
                sectionXp: 800,
                sectionId: "section4",
                description: sectionDescriptions[3]
            ),
          ],
        ),
        LevelModel(
          name: "The Art of Small Talk at Work",
          description: "Engaging in casual workplace conversations",
          imageUrl: "",
          sections: [
            SectionModel(
                title: "Starting Strong",
                sectionXp: 480,
                sectionId: "section1",
                description: sectionDescriptions[0]
            ),
            SectionModel(
                title: "Beyond Words",
                sectionXp: 280,
                sectionId: "section2",
                description: sectionDescriptions[1]
            ),
            SectionModel(
                title: "Tone Matters",
                sectionXp: 560,
                sectionId: "section3",
                description: sectionDescriptions[2]
            ),
            SectionModel(
                title: "The Real-World Test",
                sectionXp: 800,
                sectionId: "section4",
                description: sectionDescriptions[3]
            ),
          ],
        ),
        LevelModel(
          name: "Handling Difficult Conversations",
          description: "Managing conflicts and tough discussions",
          imageUrl: "",
          sections: [
            SectionModel(
                title: "Speaking with Purpose",
                sectionXp: 480,
                sectionId: "section1",
                description: sectionDescriptions[0]
            ),
            SectionModel(
                title: "The Social Decoder",
                sectionXp: 280,
                sectionId: "section2",
                description: sectionDescriptions[1]
            ),
            SectionModel(
                title: "Pace & Pause",
                sectionXp: 560,
                sectionId: "section3",
                description: sectionDescriptions[2]
            ),
            SectionModel(
                title: "Master the Moment",
                sectionXp: 800,
                sectionId: "section4",
                description: sectionDescriptions[3]
            ),
          ],
        ),
        LevelModel(
          name: "Speaking Up in Team Discussions",
          description: "Contributing ideas and opinions in meetings",
          imageUrl: "",
          sections: [
            SectionModel(
                title: "Teaching What to Speak",
                sectionXp: 480,
                sectionId: "section1",
                description: sectionDescriptions[0]
            ),
            SectionModel(
                title: "Spot the Signal",
                sectionXp: 280,
                sectionId: "section2",
                description: sectionDescriptions[1]
            ),
            SectionModel(
                title: "Clear & Confident",
                sectionXp: 560,
                sectionId: "section3",
                description: sectionDescriptions[2]
            ),
            SectionModel(
                title: "Social Success Check",
                sectionXp: 800,
                sectionId: "section4",
                description: sectionDescriptions[3]
            ),
          ],
        ),
      ],
      completedLevels: 1,
      completedSections: 3,
    );
  }
}
