import 'package:dapple/core/error/failure.dart';
import 'package:dapple/core/usecase/usecase.dart';
import 'package:dapple/core/entities/user.dart';
import 'package:dapple/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class LoginWithGoogle implements UseCase<User, bool> {
    final AuthRepository authRepository;
    const LoginWithGoogle(this.authRepository);
  @override
  Future<Either<Failure,User>> call(bool isSignUp) async {
    return await authRepository.loginWithGoogle(isSignUp: isSignUp);
  }
}
