import 'package:dapple/core/error/failure.dart';
import 'package:dapple/features/question/data/models/questions_progress_model.dart';
import 'package:dapple/features/question/data/models/voice_question_answer_model.dart';
import 'package:dapple/features/question/data/remote/questions_remote_data_source.dart';
import 'package:dapple/features/question/domain/entities/objective_question_answer.dart';
import 'package:dapple/features/question/domain/entities/subjective_question_answer.dart';
import 'package:dapple/features/question/domain/repository/questions_repository.dart';
import 'package:dapple/features/question/domain/usecases/answer_objective_question.dart';
import 'package:dapple/features/question/domain/usecases/answer_subjective_question.dart';
import 'package:dapple/features/question/domain/usecases/answer_voice_question.dart';
import 'package:fpdart/src/either.dart';

import '../../../../core/error/exceptions.dart';

class QuestionsRepoImpl implements QuestionsRepository {
  QuestionsRemoteDataSource questionsRemoteDataSource;

  QuestionsRepoImpl(this.questionsRemoteDataSource);

  @override
  Future<Either<Failure, QuestionsProgressModel>> getQuestions(
      String sectionId) async {
    try {
      final questions = await questionsRemoteDataSource.getQuestions(sectionId);
      return right(questions);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, void>> markLessonCompleted(String lessonId) async {
    try {
      return right(
          await questionsRemoteDataSource.markLessonCompleted(lessonId));
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, ObjectiveQuestionAnswer>> answerObjectiveQuestion(
      AnswerObjectiveQuestionParams objectiveQuestionAnswer) async {
    try {
      return right(await questionsRemoteDataSource.answerObjectiveQuestion(
          objectiveQuestionAnswer.optionIndex,
          objectiveQuestionAnswer.questionId));
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, SubjectiveQuestionAnswer>> answerSubjectiveQuestion(
      AnswerSubjectiveQuestionParams question) async {
    try {
      return right(await questionsRemoteDataSource.answerSubjectiveQuestion(
          question.answer, question.questionId));
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, String>> getSubjectiveHint(String questionId) async {
    try {
      return right(
          await questionsRemoteDataSource.getSubjectiveHint(questionId));
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, VoiceQuestionAnswerModel>> answerVoiceQuestion(AnswerVoiceQuestionParams question) async {
    try{
      return right(await questionsRemoteDataSource.answerVoiceQuestion(question.questionId, question.answer));
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

}
