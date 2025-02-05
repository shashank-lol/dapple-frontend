import 'package:dapple/features/home/data/models/level_section_wrapper.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failure.dart';

abstract interface class LevelRepository {
  Future<Either<Failure, LevelSectionWrapper>> getAllLevels();
}
