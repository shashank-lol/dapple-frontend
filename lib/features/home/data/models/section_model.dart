import '../../domain/entities/section.dart';

class SectionModel extends Section{
  SectionModel({
    required super.title,
    required super.sectionXp,
    required super.sectionId,
    required super.description
});
  factory SectionModel.fromJson(Map<String, dynamic> json, String description) {
    return SectionModel(
      title: json['name'],
      sectionXp: json['totalXP'],
      sectionId: json['sectionId'],
      description: description
    );
  }

}