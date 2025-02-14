import 'package:dapple/core/error/failure.dart';
import 'package:dapple/core/usecase/usecase.dart';
import 'package:dapple/features/question/domain/repository/questions_repository.dart';
import 'package:fpdart/fpdart.dart';

class SubjectiveHint implements UseCase<String, String> {
  final QuestionsRepository questionsRepository;

  SubjectiveHint(this.questionsRepository);
  @override
  Future<Either<Failure,String>> call(String questionId) {
    return questionsRepository.getSubjectiveHint(questionId);
  }
}