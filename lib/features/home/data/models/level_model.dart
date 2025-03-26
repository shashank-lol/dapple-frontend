import 'package:dapple/features/home/data/local/section_descriptions.dart';
import 'package:dapple/features/home/data/models/section_model.dart';

import '../../domain/entities/level.dart';

class LevelModel extends Level {
  LevelModel(
      {required super.name,
      required super.description,
      required super.sections,
      super.imageUrl});

  factory LevelModel.fromJson(Map<String, dynamic> json) {
    return LevelModel(
      name: json['name'],
      description: json['description'],
      imageUrl: json['imageUrl'],
      sections: List<SectionModel>.generate(
        json['sections'].length,
        (i) => SectionModel.fromJson(
            json['sections'][i] as Map<String, dynamic>,
            sectionDescriptions[i]),
      ),
    );
  }
}
