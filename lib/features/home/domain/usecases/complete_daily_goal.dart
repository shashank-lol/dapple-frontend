import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../repository/daily_goal_repository.dart';

class CompleteDailyGoal implements UseCase<bool, CompleteDailyGoalParams> {
  final DailyGoalRepository repository;

  CompleteDailyGoal(this.repository);

  @override
  Future<Either<Failure, bool>> call(CompleteDailyGoalParams params) async {
    return await repository.markCompleted(params.answer);
  }
}

class CompleteDailyGoalParams {
  final String answer;

  CompleteDailyGoalParams(this.answer);
}