import 'package:dapple/features/expert_talk/domain/entities/expert.dart';

class ExpertModel extends Expert{
  const ExpertModel({
    required super.expertId,
    required super.name,
    required super.image,
    required super.description,
    required super.rating,
    required super.xp,
  });

  factory ExpertModel.fromJson(Map<String, dynamic> json) {
    return ExpertModel(
      expertId: json['expertId'],
      name: json['name'],
      image: json['imageUrl'],
      description: json['bio'],
      xp: json['xpRequired'],
      rating: json['rating'],
    );
  }
}