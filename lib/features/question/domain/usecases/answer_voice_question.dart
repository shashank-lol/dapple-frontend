import 'dart:io';

import 'package:dapple/features/question/domain/entities/voice_question_answer.dart';
import 'package:dapple/features/question/domain/repository/questions_repository.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecase/usecase.dart';

class AnswerVoiceQuestion implements UseCase<VoiceQuestionAnswer, AnswerVoiceQuestionParams> {

  final QuestionsRepository repository;
  AnswerVoiceQuestion(this.repository);

  @override
  Future<Either<Failure, VoiceQuestionAnswer>> call(AnswerVoiceQuestionParams params) async {
    return await repository.answerVoiceQuestion(params);
  }
}

class AnswerVoiceQuestionParams {
  final String questionId;
  final File answer;

  AnswerVoiceQuestionParams({required this.questionId, required this.answer});
}