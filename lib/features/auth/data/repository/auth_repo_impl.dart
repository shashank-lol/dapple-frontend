import 'package:dapple/core/error/exceptions.dart';
import 'package:dapple/core/error/failure.dart';
import 'package:dapple/features/auth/data/remote/auth_data_source.dart';
import 'package:dapple/features/auth/domain/repository/auth_repository.dart';
import 'package:dapple/features/auth/domain/usecases/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fpdart/src/either.dart';

import 'package:google_sign_in/google_sign_in.dart';
class AuthRepoImpl implements AuthRepository {
  final AuthDataSource authDataSource;

  const AuthRepoImpl(this.authDataSource);

  @override
  Future<Either<Failure, String>> loginWithEmail(
      {required String email, required String password}) async {
    try{
      final result = authDataSource.loginWithEmail(email: email, password: password);
      // authDataSource.test();
      return right("User logged in successfully");
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, String>> signUpWithEmail(
      {required String firstName,
      required String lastName,
      required String email,
      required String password}) async {
    try {
      final result = authDataSource.signUpWithEmail(
          firstName: firstName,
          lastName: lastName,
          email: email,
          password: password);
      return right("User created successfully");
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, String>> loginWithGoogle({required Future<UserCredential?> userCredential}) {
    // TODO: implement loginWithGoogle
    throw UnimplementedError();
  }
}
