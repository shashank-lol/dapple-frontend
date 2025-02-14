import 'package:dapple/features/question/domain/entities/objective_question_answer.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../repository/questions_repository.dart';

class AnswerObjectiveQuestion
    implements UseCase<ObjectiveQuestionAnswer, AnswerObjectiveQuestionParams> {
  final QuestionsRepository questionsRepository;

  AnswerObjectiveQuestion(this.questionsRepository);

  @override
  Future<Either<Failure, ObjectiveQuestionAnswer>> call(
      AnswerObjectiveQuestionParams question) async {
    return await questionsRepository.answerObjectiveQuestion(question);
  }
}

class AnswerObjectiveQuestionParams {
  final int optionIndex;
  final String questionId;

  AnswerObjectiveQuestionParams(
      {required this.optionIndex, required this.questionId});
}
