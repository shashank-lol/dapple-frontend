import 'package:dapple/features/test_section/domain/usecases/get_test_result.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

import '../../../domain/entities/test_result.dart';

part 'result_state.dart';

class ResultCubit extends Cubit<ResultState> {
  GetTestResult _getTestResult;

  ResultCubit(GetTestResult getTestResult)
      : _getTestResult = getTestResult,
        super(ResultInitial());

  void calculateResult(String sessionId, String sectionId) async {
    emit(ResultLoading());
    await _getTestResult(GetTestResultParams(sessionId, sectionId)).then((result) {
      result.fold(
        (failure) => emit(ResultError(failure.message)),
        (testResult) => emit(ResultLoaded(testResult)),
      );
    });
  }
}
