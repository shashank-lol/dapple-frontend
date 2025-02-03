import '../../domain/entities/level.dart';

class LevelModel extends Level{
  LevelModel({
    required super.id,
    required super.name,
    required super.description,
    super.imageUrl,
    required super.sections
  });

  factory LevelModel.fromJson(Map<String, dynamic> json) {
    return LevelModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      imageUrl: json['imageUrl'],
      sections: json['sections'].map<String>((e) => e.toString()).toList(),
    );
  }
}