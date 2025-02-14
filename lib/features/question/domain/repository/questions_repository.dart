import 'package:dapple/features/question/domain/entities/objective_question_answer.dart';
import 'package:dapple/features/question/domain/entities/questions_progress.dart';
import 'package:dapple/features/question/domain/entities/subjective_question_answer.dart';
import 'package:dapple/features/question/domain/usecases/answer_objective_question.dart';
import 'package:dapple/features/question/domain/usecases/answer_subjective_question.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failure.dart';

abstract interface class QuestionsRepository {
  Future<Either<Failure, QuestionsProgress>> getQuestions(String sectionId);
  Future<Either<Failure, void>> markLessonCompleted(String lessonId);

  Future<Either<Failure,ObjectiveQuestionAnswer>> answerObjectiveQuestion(AnswerObjectiveQuestionParams question);
  Future<Either<Failure, SubjectiveQuestionAnswer>> answerSubjectiveQuestion(AnswerSubjectiveQuestionParams question);

  Future<Either<Failure,String>> getSubjectiveHint(String questionId);
}