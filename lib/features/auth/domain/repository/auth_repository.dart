import 'package:dapple/core/error/failure.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class AuthRepository {
  Future<Either<Failure, String>> signUpWithEmail({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
  });

  Future<Either<Failure, String>> loginWithEmail({
    required String email,
    required String password,
  });

  Future<Either<Failure, String>> loginWithGoogle({
    required Future<UserCredential?> userCredential,
});
}
