import 'package:dapple/core/error/failure.dart';
import 'package:dapple/core/usecase/usecase.dart';
import 'package:dapple/core/entities/user.dart';
import 'package:dapple/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/src/either.dart';

class UserSignUp implements UseCase<User, UserSignUpParams> {
  final AuthRepository authRepository;
  const UserSignUp(this.authRepository);

  @override
  Future<Either<Failure, User>> call(UserSignUpParams params) async {
    return await authRepository.signUpWithEmail(
      firstName: params.firstName,
      lastName: params.lastName,
      email: params.email,
      password: params.password,
    );
  }
}

class UserSignUpParams {
  final String firstName;
  final String lastName;
  final String email;
  final String password;

  UserSignUpParams({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
  });
}