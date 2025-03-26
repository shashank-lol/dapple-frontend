import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/test_result.dart';
import '../repository/test_repository.dart';

class GetTestResult implements UseCase<TestResult, GetTestResultParams> {
  final TestRepository repository;

  GetTestResult(this.repository);

  @override
  Future<Either<Failure, TestResult>> call(GetTestResultParams params) async {
    return await repository.calculateResult(params.sessionId,params.sectionId);
  }
}

class GetTestResultParams {
  final String sessionId;
  final String sectionId;

  GetTestResultParams(this.sessionId, this.sectionId);
}