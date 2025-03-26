import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failure.dart';

abstract interface class UserRepository {
  Future<Either<Failure, int>> getUserXp();
  Future<void> updateUserXpToLocal(int xp);
}