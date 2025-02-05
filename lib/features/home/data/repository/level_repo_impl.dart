import 'package:dapple/core/error/failure.dart';
import 'package:dapple/features/home/data/local/level_local_data_source.dart';
import 'package:dapple/features/home/data/models/level_section_wrapper.dart';
import 'package:dapple/features/home/domain/repository/level_repository.dart';
import 'package:fpdart/src/either.dart';

import '../../../../core/error/exceptions.dart';
import '../remote/level_data_source.dart';

class LevelRepoImpl implements LevelRepository {
  final LevelDataSource levelDataSource;
  final LevelLocalDataSource localDataSource;

  LevelRepoImpl(this.levelDataSource, this.localDataSource);

  @override
  Future<Either<Failure, LevelSectionWrapper>> getAllLevels() async {
    try{
      final result = await levelDataSource.getAllLevels();
      return right(result);
    } on ServerException catch(e){
      final localLevels = localDataSource.getAllLevels();
      return right(localLevels);
    }
  }
}