import 'package:dapple/core/error/failure.dart';
import 'package:dapple/core/usecase/usecase.dart';
import 'package:dapple/features/auth/domain/repository/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fpdart/fpdart.dart';

class GoogleSignIn implements UseCase<String, GoogleSignInParams> {
    final AuthRepository authRepository;
    const GoogleSignIn(this.authRepository);
  @override
  Future<Either<Failure,String>> call(GoogleSignInParams params) async {
    return await authRepository.loginWithGoogle(userCredential: params.userCredential);
  }
}

class GoogleSignInParams {
  final Future<UserCredential?> userCredential;
  GoogleSignInParams({
    required this.userCredential,
  });
}