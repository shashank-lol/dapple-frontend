import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failure.dart';
import '../entities/expert.dart';

abstract class ExpertRepository {
  Future<Either<Failure, List<Expert>>> getExperts();
}