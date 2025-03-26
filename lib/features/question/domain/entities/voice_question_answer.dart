import 'package:dapple/features/question/domain/entities/evaluation.dart';

class VoiceQuestionAnswer {
  final List<Evaluation> evaluation;
  final int xp;

  VoiceQuestionAnswer({required this.evaluation, required this.xp});
}