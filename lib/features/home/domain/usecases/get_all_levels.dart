import 'package:dapple/features/home/data/models/level_section_wrapper.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../repository/level_repository.dart';

class GetAllLevels implements UseCase<LevelSectionWrapper, NoParams> {
  final LevelRepository repository;

  GetAllLevels(this.repository);

  @override
  Future<Either<Failure, LevelSectionWrapper>> call(NoParams params) async {
    return await repository.getAllLevels();
  }
}

class NoParams {}
