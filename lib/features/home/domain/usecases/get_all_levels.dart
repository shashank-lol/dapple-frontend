import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/level.dart';
import '../repository/level_repository.dart';

class GetAllLevels implements UseCase<List<Level>, NoParams> {
  final LevelRepository repository;

  GetAllLevels(this.repository);

  @override
  Future<Either<Failure, List<Level>>> call(NoParams params) async {
    return await repository.getAllLevels();
  }
}

class NoParams {}