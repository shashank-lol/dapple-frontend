import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../repository/socket_repository.dart';

class RetryAnswer implements UseCase<void, RetryAnswerParams> {
  final SocketRepository repository;

  RetryAnswer(this.repository);

  @override
  Future<Either<Failure,void>> call(RetryAnswerParams params) async {
    return await repository.retryAnswer(params.questionId, params.sessionId);
  }
}

class RetryAnswerParams {
  final String questionId;
  final String sessionId;

  RetryAnswerParams(this.questionId, this.sessionId);
}