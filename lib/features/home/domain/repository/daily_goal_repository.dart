import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failure.dart';
import '../entities/daily_goal.dart';

abstract interface class DailyGoalRepository {
  Future<Either<Failure, DailyGoal>> getDailyGoal();
  Future<Either<Failure, bool>> markCompleted(String answer);
}