import 'package:dapple/core/entities/user.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../repository/auth_repository.dart';

class UserLogInWithEmail implements UseCase<User, UserLogInEmailParams> {
  final AuthRepository authRepository;

  UserLogInWithEmail(this.authRepository);

  @override
  Future<Either<Failure, User>> call(UserLogInEmailParams params) async {
    return await authRepository.loginWithEmail(email: params.email, password: params.password);
  }
}

class UserLogInEmailParams {
  final String email;
  final String password;

  UserLogInEmailParams({
    required this.email,
    required this.password,
  });
}