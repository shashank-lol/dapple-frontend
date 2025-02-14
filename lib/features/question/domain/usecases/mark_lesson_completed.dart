import 'package:dapple/core/error/failure.dart';
import 'package:dapple/core/usecase/usecase.dart';
import 'package:dapple/features/question/domain/repository/questions_repository.dart';
import 'package:fpdart/fpdart.dart';

class MarkLessonCompleted implements UseCase<void, String> {
  final QuestionsRepository questionsRepository;
  MarkLessonCompleted(this.questionsRepository);

  @override
  Future<Either<Failure,void>> call(String lessonId) async {
    return await questionsRepository.markLessonCompleted(lessonId);
  }
}