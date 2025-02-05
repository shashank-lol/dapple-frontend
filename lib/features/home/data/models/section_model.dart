import '../../domain/entities/section.dart';

class SectionModel extends Section{
  SectionModel({
    required super.title,
    required super.sectionXp
});
  factory SectionModel.fromJson(Map<String, dynamic> json) {
    return SectionModel(
      title: json['sectionTitle'],
      sectionXp: json['sectionXp'],
    );
  }

}