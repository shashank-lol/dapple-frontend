import 'package:dapple/features/expert_talk/domain/entities/booking.dart';
import 'package:dapple/features/expert_talk/domain/repository/expert_repository.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecase/usecase.dart';

class GetExpertSchedule implements UseCase<List<Booking>, String>{
  final ExpertRepository repository;

  GetExpertSchedule({required this.repository});

  @override
  Future<Either<Failure,List<Booking>>>call(String expertId) async {
    return await repository.getExpertSchedule(expertId);
  }
}