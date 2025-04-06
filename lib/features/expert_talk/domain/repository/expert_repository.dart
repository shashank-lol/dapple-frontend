import 'package:dapple/features/expert_talk/domain/entities/booking.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failure.dart';
import '../entities/expert.dart';

abstract class ExpertRepository {
  Future<Either<Failure, List<Expert>>> getExperts();
  Future<Either<Failure, List<Booking>>> getExpertSchedule(String expertId);
}