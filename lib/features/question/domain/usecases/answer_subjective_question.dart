import 'package:dapple/features/question/domain/entities/subjective_question_answer.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../repository/questions_repository.dart';

class AnswerSubjectiveQuestion implements UseCase<SubjectiveQuestionAnswer, AnswerSubjectiveQuestionParams> {
  final QuestionsRepository questionsRepository;

  AnswerSubjectiveQuestion(this.questionsRepository);

  @override
  Future<Either<Failure, SubjectiveQuestionAnswer>> call(AnswerSubjectiveQuestionParams question) async {
    return await questionsRepository.answerSubjectiveQuestion(question);
  }
}

class AnswerSubjectiveQuestionParams {
  final List<String> answer;
  final String questionId;

  AnswerSubjectiveQuestionParams({required this.answer, required this.questionId});
}