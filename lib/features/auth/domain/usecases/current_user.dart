import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecase/usecase.dart';
import 'package:dapple/core/entities/user.dart';
import '../repository/auth_repository.dart';

class CurrentUser implements UseCase<User, bool> {
  final AuthRepository repository;

  CurrentUser(this.repository);

  @override
  Future<Either<Failure, User>> call(bool params) async {
    return repository.currentUser();
  }
}