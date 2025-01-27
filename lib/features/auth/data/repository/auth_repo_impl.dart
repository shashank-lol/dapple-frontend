import 'package:dapple/core/error/exceptions.dart';
import 'package:dapple/core/error/failure.dart';
import 'package:dapple/features/auth/data/local/user_data_source.dart';
import 'package:dapple/features/auth/data/remote/auth_data_source.dart';
import 'package:dapple/features/auth/domain/repository/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fpdart/src/either.dart';
import 'package:dapple/core/entities/user.dart' as user;

class AuthRepoImpl implements AuthRepository {
  final AuthDataSource authDataSource;
  final UserDataSource userDataSource;

  const AuthRepoImpl(this.authDataSource, this.userDataSource);

  String? validateEmailAndPassword(String email, String password) {
    if (password.length < 6) {
      return "Password must be at least 6 characters";
    }
    const pattern = r"(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'"
        r'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-'
        r'\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*'
        r'[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4]'
        r'[0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9]'
        r'[0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\'
        r'x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])';
    final regex = RegExp(pattern);

    if (!regex.hasMatch(email)) {
      return "Invalid email";
    }
    return null;
  }

  @override
  Future<Either<Failure, user.User>> loginWithEmail(
      {required String email, required String password}) async {
    final error = validateEmailAndPassword(email, password);
    if (error != null) {
      return left(Failure(error));
    }
    try {
      final result =
          await authDataSource.loginWithEmail(email: email, password: password);
      return right(result);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, user.User>> signUpWithEmail(
      {required String firstName,
      required String lastName,
      required String email,
      required String password}) async {
    final error = validateEmailAndPassword(email, password);
    if (error != null) {
      return left(Failure(error));
    }
    try {
      final result = await authDataSource.signUpWithEmail(
          firstName: firstName,
          lastName: lastName,
          email: email,
          password: password);
      return right(result);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, user.User>> loginWithGoogle({required bool isSignUp}) async {
    try {
      final result = await authDataSource.loginWithGoogle(isSignUp: isSignUp);
      return right(result);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    } on FirebaseAuthException catch (e) {
      return left(Failure("Firebase Auth Exception: ${e.message}"));
    }
  }

  @override
  Either<Failure, user.User> currentUser() {
    final user = userDataSource.getCurrentUser();
    if (user != null) {
      return right(user);
    } else {
      return left(Failure("No user found"));
    }
  }
}
