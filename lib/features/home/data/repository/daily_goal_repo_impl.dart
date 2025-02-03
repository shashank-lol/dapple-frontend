import 'package:dapple/core/error/failure.dart';
import 'package:dapple/features/home/data/remote/daily_goal_data_source.dart';
import 'package:dapple/features/home/domain/entities/daily_goal.dart';
import 'package:dapple/features/home/domain/repository/daily_goal_repository.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/error/exceptions.dart';

class DailyGoalRepoImpl implements DailyGoalRepository{

  final DailyGoalDataSource dailyGoalDataSource;

  const DailyGoalRepoImpl(this.dailyGoalDataSource);
  @override
  Future<Either<Failure, DailyGoal>> getDailyGoal() async {
    try{
      final result = await dailyGoalDataSource.getDailyGoal();
      return right(result);
    } on ServerException catch(e){
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, bool>> markCompleted(String answer) async{
    try{
      final result = await dailyGoalDataSource.markCompleted(answer);
      return right(result);
    } on ServerException catch(e){
      return left(Failure(e.message));
    }

  }

}