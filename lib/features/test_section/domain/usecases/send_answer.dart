import 'package:dapple/core/error/failure.dart';
import 'package:dapple/core/usecase/usecase.dart';
import 'package:fpdart/fpdart.dart';

import '../repository/socket_repository.dart';

class SendAnswer implements UseCase<void, SendAnswerParams> {
  final SocketRepository repository;

  SendAnswer(this.repository);

  @override
  Future<Either<Failure,void>> call(SendAnswerParams params) async {
    return await repository.sendAnswer(params.answer, params.questionId, params.sessionId);
  }
}

class SendAnswerParams {
  final String answer;
  final String questionId;
  final String sessionId;

  SendAnswerParams(this.answer, this.questionId, this.sessionId);
}