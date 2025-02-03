import 'package:dapple/core/error/failure.dart';
import 'package:dapple/features/home/domain/repository/level_repository.dart';
import 'package:fpdart/src/either.dart';

import '../../../../core/error/exceptions.dart';
import '../../domain/entities/level.dart';
import '../remote/level_data_source.dart';

class LevelRepoImpl implements LevelRepository {
  final LevelDataSource levelDataSource;

  LevelRepoImpl(this.levelDataSource);

  @override
  Future<Either<Failure, List<Level>>> getAllLevels() async {
    try{
      final result = await levelDataSource.getAllLevels();
      return right(result);
    } on ServerException catch(e){
      return left(Failure(e.message));
    }
  }
}