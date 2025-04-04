import 'package:dapple/core/error/failure.dart';
import 'package:dapple/features/test_section/data/local/local_test_questions.dart';
import 'package:dapple/features/test_section/domain/entities/test_result.dart';
import 'package:dapple/features/test_section/domain/entities/test_section_data.dart';
import 'package:dapple/features/test_section/domain/repository/test_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:fpdart/src/either.dart';

import '../../../../core/error/exceptions.dart';
import '../remote/test_data_source.dart';

class TestQuestionsRepoImpl implements TestRepository {
  final TestDataSource testQuestionsDataSource;
  final TestQuestionsLocal testQuestionsLocal;

  TestQuestionsRepoImpl(
      {required this.testQuestionsDataSource,
      required this.testQuestionsLocal});

  @override
  Future<Either<Failure, TestSectionData>> getTestQuestions(
      String sectionId) async {
    try {
      final questions =
          await testQuestionsDataSource.getTestQuestions(sectionId);
      return right(questions);
    } on ServerException catch (e) {
      debugPrint("Local Data, Server Exception $e");
      final localQuestions = testQuestionsLocal.getTestQuestions();
      return right(TestSectionData(questions: localQuestions, sessionId: "0"));
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, TestResult>> calculateResult(String sessionId, String sectionId) async {
    try{
      final result = await testQuestionsDataSource.getTestResult(sessionId,sectionId);
      return right(result);
    } on ServerException catch(e){
      final localResult = testQuestionsLocal.getTestResults();
      return right(localResult);
      return left(Failure(e.message));
    }
  }
}
