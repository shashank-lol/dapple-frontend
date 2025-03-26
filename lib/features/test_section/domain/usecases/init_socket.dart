import 'package:dapple/core/error/failure.dart';
import 'package:dapple/core/usecase/usecase.dart';
import 'package:fpdart/fpdart.dart';

import '../repository/socket_repository.dart';

class InitSocket implements UseCase<void, NoParams> {
  final SocketRepository repository;

  InitSocket(this.repository);

  @override
  Future<Either<Failure,void>> call(NoParams params) async {
    return await repository.initSocket();
  }
}