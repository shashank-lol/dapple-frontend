import 'package:dapple/core/error/failure.dart';
import 'package:dapple/core/usecase/usecase.dart';
import 'package:dapple/features/home/domain/repository/user_repository.dart';
import 'package:fpdart/fpdart.dart';

class UpdateXp implements UseCase<int,NoParams > {
  UserRepository userRepository;
  UpdateXp(this.userRepository);

  @override
  Future<Either<Failure,int>> call(params) async {
    return userRepository.getUserXp();
  }
}