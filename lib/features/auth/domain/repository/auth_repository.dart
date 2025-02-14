import 'package:dapple/core/error/failure.dart';
import 'package:dapple/core/entities/user.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class AuthRepository {
  Future<Either<Failure, User>> signUpWithEmail({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    required int age,
    required String gender,
    required String profession,
    required List<String> socialChallenges,
    required List<String> socialSettings,
  });

  Future<Either<Failure, User>> loginWithEmail({
    required String email,
    required String password,
  });

  Future<Either<Failure, User>> loginWithGoogle();

  Future<Either<Failure, User>> signUpWithGoogle({
    required int age,
    required String gender,
    required String profession,
    required List<String> socialChallenges,
    required List<String> socialSettings,
  });

  Either<Failure,User> currentUser();

}
