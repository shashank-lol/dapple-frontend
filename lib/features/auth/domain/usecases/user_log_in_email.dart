import 'package:firebase_auth/firebase_auth.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../repository/auth_repository.dart';

class UserLogInWithEmail implements UseCase<String, UserLogInEmailParams> {
  final AuthRepository authRepository;

  UserLogInWithEmail(this.authRepository);

  @override
  Future<Either<Failure, String>> call(UserLogInEmailParams params) async {
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