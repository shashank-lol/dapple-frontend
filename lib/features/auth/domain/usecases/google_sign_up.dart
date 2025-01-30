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
    return await repository.signUpWithGoogle(selectedCourses: params.selectedCourses, age: params.age);
  }
}

class GoogleSignUpParams {
  final List<int> selectedCourses;
  final int age;

  GoogleSignUpParams({required this.selectedCourses, required this.age});
}