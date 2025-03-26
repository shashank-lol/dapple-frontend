import 'package:dapple/core/usecase/usecase.dart';
import 'package:dapple/features/test_section/domain/entities/test_section_data.dart';
import 'package:dapple/features/test_section/domain/repository/test_repository.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failure.dart';

class GetTestQuestion implements UseCase<TestSectionData ,String> {
  TestRepository repository;

  GetTestQuestion(this.repository);
  @override
  Future<Either<Failure,TestSectionData>> call(String params) async {
    return await repository.getTestQuestions(params);
  }
}