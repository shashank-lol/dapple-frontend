import 'package:fpdart/fpdart.dart';

import '../../../../core/entities/user.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../repository/auth_repository.dart';

class SignUpWithGoogle implements UseCase<User, GoogleSignUpParams> {
  final AuthRepository repository;

  SignUpWithGoogle(this.repository);

  @override
  Future<Either<Failure, User>> call(GoogleSignUpParams params) async {
    return await repository.signUpWithGoogle(
        age: params.age,
        gender: params.gender,
        profession: params.profession,
        socialChallenges: params.socialChallenges,
        socialSettings: params.socialSettings);
  }
}

class GoogleSignUpParams {
  final String gender;
  final String profession;
  final List<String> socialChallenges;
  final List<String> socialSettings;
  final int age;

  GoogleSignUpParams(
      {required this.gender,
      required this.profession,
      required this.socialChallenges,
      required this.socialSettings,
      required this.age});
}
