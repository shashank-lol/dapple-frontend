import 'package:dapple/features/question/data/models/evaluation_model.dart';
import 'package:dapple/features/question/domain/entities/voice_question_answer.dart';

class VoiceQuestionAnswerModel extends VoiceQuestionAnswer {
  VoiceQuestionAnswerModel({required super.evaluation, required super.xp});

  factory VoiceQuestionAnswerModel.fromJson(Map<String, dynamic> json) {
    return VoiceQuestionAnswerModel(
      evaluation: json['evaluation'].map<EvaluationModel>((e) => EvaluationModel.fromJson(e)).toList(),
      xp: json['xp'],
    );
  }

}