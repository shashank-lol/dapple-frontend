import 'package:dapple/core/error/failure.dart';
import 'package:dapple/core/usecase/usecase.dart';
import 'package:fpdart/fpdart.dart';

import '../repository/socket_repository.dart';

class SendImage implements UseCase<void, SendImageParams> {
  final SocketRepository repository;

  SendImage(this.repository);

  @override
  Future<Either<Failure,void>> call(SendImageParams params) async {
    return await repository.sendImage(params.image, params.questionId, params.sessionId);
  }
}

class SendImageParams {
  final String image;
  final String questionId;
  final String sessionId;

  SendImageParams(this.image, this.questionId, this.sessionId);
}