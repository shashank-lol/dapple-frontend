import 'package:dapple/features/question/domain/entities/questions_progress.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../repository/questions_repository.dart';

class GetAllQuestions implements UseCase<QuestionsProgress, String> {
  final QuestionsRepository repository;

  GetAllQuestions(this.repository);

  @override
  Future<Either<Failure, QuestionsProgress>> call(String sectionId) async {
    return await repository.getQuestions(sectionId);
  }
}
