import '../../domain/entities/level.dart';

class LevelModel extends Level{
  LevelModel({
    required super.name,
    required super.description,
    super.imageUrl,
    super.sections
  });

  factory LevelModel.fromJson(Map<String, dynamic> json) {
    return LevelModel(
      name: json['name'],
      description: json['description'],
      imageUrl: json['imageUrl'],
      sections: ((json['sections'])??[]).map<String>((e) => e.toString()).toList(),
    );
  }
}