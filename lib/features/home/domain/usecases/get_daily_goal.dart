import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/daily_goal.dart';
import '../repository/daily_goal_repository.dart';

class GetDailyGoal implements UseCase<DailyGoal, Null> {
  final DailyGoalRepository dailyGoalRepository;

  const GetDailyGoal(this.dailyGoalRepository);

  @override
  Future<Either<Failure, DailyGoal>> call(Null params) async {
    return dailyGoalRepository.getDailyGoal();
  }
}



