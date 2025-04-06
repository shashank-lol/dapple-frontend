import 'package:dapple/features/expert_talk/data/local/dummy_experts.dart';
import 'package:dapple/features/expert_talk/domain/entities/booking.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failure.dart';
import '../../domain/repository/expert_repository.dart';
import '../models/expert_model.dart';
import '../remote/expert_remote_data_source.dart';

class ExpertRepositoryImpl implements ExpertRepository {
  final ExpertRemoteDataSource remoteDataSource;
  final ExpertLocalDataSource expertLocalDataSource =
      ExpertLocalDataSourceImpl();

  ExpertRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, List<ExpertModel>>> getExperts() async {
    try {
      //TODO: Uncomment the remote data source call when available
      // final localExperts = expertLocalDataSource.getExperts();
      // return Right(await Future.delayed(Duration.zero, () => localExperts));
      final experts = await remoteDataSource.getExperts();
      return Right(experts);
    } catch (e) {
      // Show local experts if remote call fails
      final localExperts = expertLocalDataSource.getExperts();
      return Right(await Future.delayed(Duration.zero, () => localExperts));
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Booking>>> getExpertSchedule(String expertId) async {
    try {
      // Use remote data source to fetch the schedule
      final schedule = await remoteDataSource.getExpertSchedule(expertId);
      return Right(schedule); // Return the list of Booking objects directly
    } catch (e) {
      // Handle any exceptions (e.g., ServerException or other errors)
      return Left(Failure(e is ServerException ? e.message : e.toString()));
    }
  }
}
