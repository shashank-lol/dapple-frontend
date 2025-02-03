import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failure.dart';
import '../entities/level.dart';

abstract interface class LevelRepository {
  Future<Either<Failure, List<Level>>> getAllLevels();
}
