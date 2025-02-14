import 'package:dapple/features/question/domain/entities/evaluation.dart';

class EvaluationModel extends Evaluation{
  EvaluationModel({
    required super.title,
    required super.content
  });

  factory EvaluationModel.fromJson(Map<String, dynamic> json) {
    return EvaluationModel(
      title: json['title'],
      content: json['content'],
    );
  }
}