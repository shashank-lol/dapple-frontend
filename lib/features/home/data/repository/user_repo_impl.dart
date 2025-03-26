import 'package:dapple/core/error/exceptions.dart';
import 'package:dapple/core/error/failure.dart';
import 'package:dapple/features/home/data/local/user_local_data.dart';
import 'package:dapple/features/home/domain/repository/user_repository.dart';
import 'package:fpdart/fpdart.dart';

import '../remote/xp_data_source.dart';

class UserRepoImpl implements UserRepository {
  XpDataSource userDataSource;
  UserLocalData userLocalData;

  UserRepoImpl(this.userDataSource, this.userLocalData);

  @override
  Future<Either<Failure, int>> getUserXp() async {
    try {
      int xp = await userDataSource.getUserXp();
      updateUserXpToLocal(xp);
      return right(xp);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<void> updateUserXpToLocal(int xp) async {
    await userLocalData.updateUserXpToLocal(xp);
  }
}
