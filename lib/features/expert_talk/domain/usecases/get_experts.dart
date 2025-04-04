import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/expert.dart';
import '../repository/expert_repository.dart';

class GetAllExperts implements UseCase<List<Expert>, NoParams> {
  final ExpertRepository repository;

  GetAllExperts(this.repository);

  @override
  Future<Either<Failure, List<Expert>>> call(NoParams params) async {
    return await repository.getExperts();
  }
}