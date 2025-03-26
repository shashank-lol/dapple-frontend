import 'package:dapple/core/error/failure.dart';
import 'package:dapple/core/usecase/usecase.dart';
import 'package:dapple/features/test_section/domain/repository/socket_repository.dart';
import 'package:fpdart/fpdart.dart';

class CloseSocket implements UseCase<void, NoParams> {

  final SocketRepository socketRepository;

  CloseSocket(this.socketRepository);
  @override
  Future<Either<Failure,void>> call(NoParams params) async {
    return await socketRepository.closeConnection();
  }
}