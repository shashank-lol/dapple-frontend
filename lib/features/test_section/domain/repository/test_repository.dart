import 'package:dapple/features/test_section/domain/entities/test_result.dart';
import 'package:dapple/features/test_section/domain/entities/test_section_data.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failure.dart';

abstract interface class TestRepository{
  Future<Either<Failure, TestSectionData >> getTestQuestions(String sectionId);
  Future<Either<Failure, TestResult>> calculateResult(String sessionId, String sectionId);
}